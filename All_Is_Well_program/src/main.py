from __future__ import print_function       # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                          # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                                  # 오픈cv 열기
import os                                   # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                                  # 환경변수같은 인수를 입력받는 모듈
import random                               # 난수 생성할때 사용하는 모듈
import imutils                              # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리

import math
import collections
#from datetime import datetime

import heatmap

import filepath                             # Video File Open GUI 모듈
#import LoginDB                              # MySQL Connector & MySQL Login 모듈
import executeSQL                           # SQL 쿼리문을 실행하는 모듈




import pymysql                              # python에서 MySQL을 사용할 수 있게 하는 모듈
import createBBox                         # 관심구역 지정 모듈     
import selectGUI           

from moviepy.editor import *                                     # moviepy 라이브러리 :
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip # 하이라이트 영상 추출을 위해 구간 자르는 라이브러리 


def calculate_moving_distance(stadium_width, stadium_height, width, height, player_coord, last_coord):
    
    width_weight = stadium_width / width
    height_weight = stadium_height / height
    # 초당 프레임간 발생한 거리차이를 a, b에 누적시킴 
    x = player_coord.x - last_coord.x
    y = player_coord.y - last_coord.y
    
    # 경기장 크기와 영상크기에 따른 가중치를 곱해줌
    x = x*width_weight
    y = y*height_weight
    
    moving_value=math.sqrt(math.pow(x,2) + math.pow(y,2)) # 초당 움직인 거리(즉 속도) - 유클리디안 거리측정 사용
    
    # 트레커 추적중 발생하는 진동을 최소화하기위한 코드
    if(moving_value < 2) :
        moving_value=0
    
    moving_distance = moving_value / 100     # cm -> m 단위로 변환 
    moving_distance = round(moving_distance,2)                # 반올림 처리

    return moving_distance

def init_video(video_stream):   
    # 비디오 성공 여부와 첫 프레임(형식 변환)
    success, frame = video_stream.read()
    # 영상 읽기에 실패 예외처리
    if not success:
        print('Failed to read video')
        sys.exit(1)
    frame = imutils.resize(frame, width=1000) # 리사이징
    
     
    # 영상의 높이와 너비 저장
    height,width,_ = frame.shape 
    
    # frame per Second
    fps = video_stream.get(cv2.CAP_PROP_FPS)
    fps = round(fps,0)
    
    # 4분할 interval
    interval = video_stream.get(cv2.CAP_PROP_FRAME_COUNT)/4
    interval = int(round(interval,0)-1)
   
    
    return success, frame, height, width, fps, interval
 
def print_player_box(en_name, frame, box, has_ball):
    point_start = (int(box[0]), int(box[1]))
    point_end = (int(box[0] + box[2]), int(box[1] + box[3]))
    
    if has_ball is True :
        box_color = (255,0,0)
    else :
        box_color = (0,0,255)
    
    # 선수를 색상 박스로 추적
    cv2.rectangle(frame, point_start, point_end, box_color, 2, 1)

    # 선수의 왼쪽위에 이름 출력
    cv2.putText(frame, en_name, (point_start[0]-5, point_start[1]-10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255), 1, cv2.LINE_AA)

def readBallCoord() : # ball_coord.txt 파일에서 공 좌표 읽어오는 함수 
    y, x, z = np.genfromtxt('../result/ball_coord_TEST.txt', delimiter=',', unpack=True,dtype=int)
    return (x,y, z)

if __name__ == '__main__':

    # 영상 파일 경로를 GUI로 입력받음
    video_object = filepath.OpenPath()
    video_path = video_object.video_path
    #video_path = "../sample_videos/TEST.mov"
    
    
    
   
    ######################################################
    player_number = selectGUI.PlayerNumber()
    home = player_number.home_int
    away = player_number.away_int
    print("home : ",home, " / away : ", away)
    
    # 6명 vs 6명으로 뛴다고 입력 받았을 경우
    total_player = home + away # 경기에 참여하는 플레이어 수가 12명인 경우
    flag = home
    
    # 각 팀 선수들이 전체 경기 중 공을 점유한 프레임 수 
    ball_share_A = [] 
    ball_share_B = []

    # 팀 단위로 경기 동안 공을 점유한 프레임 수 
    sum_ball_A = 0
    sum_ball_B = 0
    
    past_box = []


    
    ######################################################
    
    for player in range(1, total_player+1): # 선수 1부터 total_player까지 반복문
        
        # 영상 파일 경로를 통해 video_stream을 읽어옴
        video_stream = cv2.VideoCapture(video_path)  
     
        # 영상의 헤드, 성공여부, 프레임값, 높이, 너비, 영상 fps, 4분기 간격 반환
        success, frame, height, width, fps, interval = init_video(video_stream) 
        
        
        
        ############################################################
        # 초기 로그인 모듈을 활용해 로그인을 진행하고 사용자의 아이디를 받아옴
        #player_id = LoginDB.login_function()
        player_object = selectGUI.PlayerSelect()
        player_id = player_object.selected_player
        player_team = player_object.selected_team

        # 사용자 아이디를 바탕으로 PlayerTable을 생성하거나 접속함
        executeSQL.CreatePlayerTable(player_id)
        
        # 사용자 ID를 기반으로 Pathmap Table을 생성해줌
        pathmap_table = executeSQL.CreatePathmapTable(player_id)
        
        # 경기정보 식별을 위해 play_id를 받아옴
        play_id = executeSQL.PlayID(player_id)
        
        en_name = str(executeSQL.EngName(player_id))

        ############################################################

        
        # 히트맵창의 배경이 될 이미지 지정
        pitch_image = cv2.imread('../image/heatmap2.png')
        pitch_image = cv2.resize(pitch_image,(width,height))
        
        # 선수 좌표값을 저장할 파일
        player_coords_text = open( '../result/player_coord.txt', 'w' )
        
        ##################################################이미 분석한 선수 박스 쳐 주는 부분 #########################################################
        if(player>1) :
            print(past_box)
            for boxinfo in past_box:
                box_p1 = (int(boxinfo[0]), int(boxinfo[1]))
                box_p2 = (int(boxinfo[0] + boxinfo[2]), int(boxinfo[1] + boxinfo[3]))
                cv2.rectangle(frame, box_p1, box_p2, (0,0,0), 2, 1) 
                cv2.putText(frame, boxinfo[4]+' '+boxinfo[5], (int(boxinfo[0])-27, int(boxinfo[1])-5), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (30,30,30), 2, cv2.LINE_AA)  #Multitracker_Window
        ###################################################################################################################################

        
        # 팀 이름, 선수번호와 함께 관심구역 지정
        if player <= flag : 
            player_num = player
            bbox = createBBox.select_bbox(player_num, home, player_team, video_stream, frame);
        else :
            player_num = player-flag
            bbox = createBBox.select_bbox(player_num, away, player_team, video_stream, frame);
        # 관심구역 지정 코드

        #bbox = createBBox.selectBBox(frame)

        # CSRT tracker 초기화
        tracker = cv2.TrackerCSRT_create()
        tracker.init(frame, bbox)
        
        
        
        accumulate_distance = 0           # 영상기반 추정거리값을 저장
        frame_count = 0                   # 프레임을 카운팅함                   
        moving_value = 0               # 움직인 거리의 비중을 저장
        top_speed = 0                   # 최고 속도를 저장
        accumulate_speed = 0            # 속도들의 누적값
        temp_distance = 0               # 뛴 거리를 임시저장
        temp_speed = 0                  # 뛴 속도를 임시저장
        interval_distance = 0           # 특정 시간마다의 뛴거리
        interval_acc_speed = 0          # 특정 시간마다의 속도 누적값
        interval_avg_speed = 0          # 특정 시간마다의 평균속도
        coords_string = ''
        walk_count=0
        jog_count=0
        sprint_count = 0
        distance_value = 0
        pathmap=pitch_image.copy()
        
        
        ball_touch = 0                  # roi로 선택한 선수가 공을 점유한 프레임 수(볼 터치 수)를 카운팅함 
        show_goal_frame = 0             # 골인 경우 화면에 fps 프레임수 동안 "골인입니다" 표시하기 위해
        pre_frame_count =0                # 목적: 공이 인식된 현 프레임과 이전 프레임의 '차'를 계산
        highlight_goal_point = 0        # 하이라이트 추출시 골인인 프레임을 중심으로 앞뒤로 6초동안 보여주기



        #좌표를 표현할 이름있는 튜플
        Point = collections.namedtuple('Point',['x','y'])
        last_coord = Point(x=0, y=0)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
        arrow_tail= Point(x=0,y=0)
        
        ball_x,ball_y,ball_frame_count = readBallCoord() # 공의 좌표, 공이 인식된 프레임 읽어오기
        
        # 일단 하드코딩 GUI로 구현예정
        stadium_width = 4000
        stadium_height = 2000



        # 영상이 동작하는 동안 반복
        while True:
            
            # 영상을 1프레임씩 읽어옴
            success, frame = video_stream.read()
            
            # 읽어오기 실패했을때의 예외처리
            if not success:
                break

            # 영상의 크기를 리사이징 해줌
            frame = imutils.resize(frame, width=1000)
            
            # 성공여부(버림)와 box좌표를 반환
            _, box = tracker.update(frame)
            
            # 선수 좌표 저장
            player_coord = Point(x = int(box[0]),y = int(box[1]))
            
            # 선수 추적을 표시
            #print_player_box(player_id, frame, box)
            
            # radar창의 배경을 초기화 해줌
            radar = pitch_image.copy()        
            cv2.circle(radar, player_coord, 10, (0,0,255), -1)
            
            
            #####################################공 점유율 알고리즘##########################################
            #모듈화 예정
            
            #예외처리 부분 - (나중에 변수 통일하기)
            player_x1 = player_coord.x-10 
            player_x2 = int(box[0] + box[2])+10
            player_y1= player_coord.y-10 
            player_y2= int(box[1] + box[3])+10
            
            if player_x1 < 0 :
                player_x1 = 0 
            if player_x2 > width :  # 가로 길이를 초과할 경우 
                player_x2 = width
            
            if player_y1 < 0 :
                player_y1 = 0 
            if player_y2 > height :  # 세로 길이를 초과할 경우
                player_y2 = height
                
            # 공 점유 인식 (공이 선수 roi 박스 안으로 들어올 경우지정해준 선수와 가까이 있을 경우)
            # roi 파란색
            if( player_x1 <ball_x[frame_count]< player_x2 and player_y1 <ball_y[frame_count]< player_y2) : 
                #cv2.rectangle(frame, p1, p2, (255,0,0), 2, 1) #파란색으로 roi 색 바꿔주기
                has_ball = True
                ball_touch += 1
            else : # roi 빨간색
                has_ball = False 
                #cv2.rectangle(frame, p1, p2, (0,0,255), 2, 1) #그렇지 않으면 빨간색 
                
            print_player_box(en_name, frame, box, has_ball)
            ############################################################################################
            
            
            ############################################# 공 인식 출력 알고리즘 #############################
            
            
            if(ball_x[frame_count] > -1):
            
                ###################################################골 인식 알고리즘 #############################################################                          
                
                # 공이 슬로우모션으로 쫓아가는 현상 해결(현재 프레임과 공이 인식된 프레임 번호가 같을 경우만 화면에 공 출력)
                if ball_frame_count[frame_count] == frame_count :
                
                    # Home팀의 '골 에어리어'에 공이 진입한 경우 초록색으로 표시 (가로 1000일 경우: 100이하, 900이상)
                    if ball_x[frame_count] >= width * 0.9 : 
                        
                        is_in_goalnet = False 
                        invisible = frame_count - pre_frame_count
                            
                        if invisible > fps :# '골 에어리어' 영역에서 영상의 '프레임률(fps)' 이상 보이지 않는다면 공은 골 안에 있음 
                            is_in_goalnet = True
                    
                        # '골'인 경우 노란색으로 표시
                        if is_in_goalnet == True  :         #if ball_x == 947 and ball_y ==289 :
                            print('Home팀 골인입니다!!!!!', frame_count)
                            print('invisible term: ', invisible)
                            #cv2.waitKey(0)     # 화면 정지하고 키 입력을 기다리도록 
                            
                            cv2.putText(frame, 'Home team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                            show_goal_frame = 1
                            highlight_goal_point = frame_count # 골인을 인식한 프레임을 하이라이트 기준으로 삼음 
                            
   
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 228, 255), 2) # 노란색으로 표시
                            pre_frame_count = frame_count
                            
                            

                        else :
                            print("Home팀 골에어리어에 공이 진입했습니다.", frame_count)                      
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (22, 219, 29), 2) # 초록색으로 표시
                            pre_frame_count = frame_count
                
                    # Away팀의 '골 에어리어'에 공이 진입한 경우 초록색으로 표시 (가로 1000일 경우: 100이하, 900이상)
                    elif ball_x[frame_count] <= width * 0.1 : 
                        
                        is_in_goalnet = False 
                        invisible = frame_count - pre_frame_count
                       
                            
                        if invisible > fps :# '골 에어리어' 영역에서 영상의 '프레임률(fps)' 이상 보이지 않는다면 공은 골 안에 있음 
                            is_in_goalnet = True
                    
                        # '골'인 경우 노란색으로 표시
                        if is_in_goalnet == True  :         #if ball_x == 947 and ball_y ==289 :
                            print('Away팀 골인입니다!!!!!', frame_count)
                            print('invisible term: ', invisible)
                                
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 228, 255), 2) # 노란색으로 표시
                            pre_frame_count = frame_count
                            highlight_goal_point = frame_count # 골인을 인식한 프레임을 하이라이트 기준으로 삼음
                            
         
                        else :
                            print("Away팀 골에어리어에 공이 진입했습니다.", frame_count)
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (22, 219, 29), 2) # 초록색으로 표시
                            pre_frame_count = frame_count
                    
                
                    # 골에어리어에 공이 진입하지도 않았고, '골'도 아닌 경우
                    else : 
                
                        cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 0, 255), 2)
                        pre_frame_count = frame_count

                        # rectangle(): 직사각형을 그리는 함수-길
                        #파라미터 (이미지, 왼쪽 위 좌표, 오른쪽 아래 좌표, 사각형 색깔, 사각형의 두께, ?? ) -길
        
            ############################################################################################
             
            if(ball_x[frame_count] > -1):
                cv2.circle(radar, (ball_x[frame_count], ball_y[frame_count]), 7, (0, 0, 0), -1)
            
            
            # 거리와 속도 추정치를 계산하기 위한 코드들
            if(frame_count==0) :
                last_coord = arrow_tail =  player_coord   # 첫 프레임에서는 과거 좌표를 현재좌표와 동일하게 초기화함
                past_box.append((int(box[0]), int(box[1]), int(box[2]), int(box[3]), player_team, en_name))
                
            if((frame_count%fps)==0) :     # 프레임기반 1초(fps)마다 동작하는 코드
                #distance = 거리
                #walk_weight = 걷기 비중, jog_weight = 조깅 비중, sprint_weight = 스프린트 비중
            
                moving_distance = calculate_moving_distance(stadium_width, stadium_height, width, height, player_coord, last_coord)
                
                accumulate_distance = accumulate_distance + moving_distance   # 추정거리값을 누적시킴
                accumulate_distance = round(accumulate_distance,2)
                
                speed = moving_distance*3.6       # moving_distance 통해 구해진 m/s에 3.6을 곱해 속도를 k/h로 바꿔줌
                speed = round(speed,2)
                
                if( speed < 5 ) :
                    walk_count = walk_count+1
                elif( speed < 10 ) :
                    jog_count = jog_count+1
                else :
                    sprint_count = sprint_count+1
                
                if(speed > top_speed) :                     # 최고속도를 top_speed에 저장
                    top_speed = speed
                
                accumulate_speed = accumulate_speed+speed   # 속도값들을 전부 누적시킴
                
                if(frame_count!=0):
                    avg_speed = accumulate_speed / (frame_count/fps)
                    avg_speed = round(avg_speed,1)
                else :
                    avg_speed = 0
                
                last_coord = player_coord   # 과거 좌표 갱신
                
                #txt 로그로 남겨주는 부분
                # f.write( 'Player '+str(i)+' x,y: '+str(int(box[0]))+','+str(int(box[1])) + '\n' )
                # fTemp.write(str(int(box[1]))+','+str(int(box[0]))+'\n')  히트맵에 더많은 로그를 찍기위해 이동
           
            if(frame_count % (fps*2)==0) :
                overlay=pathmap.copy()
                cv2.arrowedLine(overlay,arrow_tail, player_coord, (0,0,0),2,cv2.LINE_AA)
                cv2.arrowedLine(overlay,arrow_tail, player_coord, (0,0,0),2,cv2.LINE_AA)
                pathmap = cv2.addWeighted(overlay, 0.5, pathmap, 0.5, 0)  #Heatmap_Window
                arrow_tail = player_coord



            if((frame_count % (fps*10))==0) :     # 프레임기반 10초(fps)마다 동작하는 코드
                if(frame_count==0) : 
                    pathmap_filename = '../result/pathmap_0secs.png'
                else :
                    pathmap_filename = '../result/pathmap_'+str(frame_count / (fps*10)*10)+'secs.png'

                cv2.imwrite(pathmap_filename, pathmap, [cv2.IMWRITE_PNG_COMPRESSION, 0])

                # image를 base64형식으로 바꾸고 데이터 베이스에 저장
                executeSQL.CommitPathmap(pathmap_filename,pathmap_table,play_id)


            if((frame_count % interval)==0 and frame_count != 0) :     # 프레임기반 interval[현재는 30초(fps)]마다 동작하는 코드
                interval_distance = accumulate_distance - temp_distance
                temp_distance = accumulate_distance
                interval_distance = round(interval_distance,2)
                
                interval_acc_speed = accumulate_speed - temp_speed;
                temp_speed = accumulate_speed
                
                interval_avg_speed = interval_acc_speed / (interval/fps)
                interval_avg_speed = round(interval_avg_speed,1)
                # 30초마다 DB로 전송할 부분
                ##########################################################################################
                # interval_distance = 30초마다 뛴 거리
                # interval_avg_speed = 30초마다 뛴 속도

                if interval_distance != 0 or interval_avg_speed != 0:
                    distance_value = distance_value + 5
                    distance_colum = "distance_{0}".format(distance_value)
                    speed_colum = "speed_{0}".format(distance_value)

                    executeSQL.CommitInterval(player_id, distance_colum, interval_distance, speed_colum, interval_avg_speed, play_id)
                ##########################################################################################
                print('5분 뛴 거리 추정치 : ', interval_distance, ' / 5분 뛴 속도 추정치 : ',interval_avg_speed,' km/h')
                
            coords_string = coords_string+str(int(box[1]))+','+str(int(box[0]))+'\n'  # coords_string 스트링에 좌표값을 누적시킴
            #골인 경우 2초 동안 화면에 보여주기 위함######################### 
            if 1 <=show_goal_frame <= fps * 2 :
                if show_goal_frame != 1 :
                    cv2.putText(frame, 'Home team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                show_goal_frame += 1
            ####################################################
            
            # 누적 거리값을 레이더의 플레이어 머리위에 띄워줌
            cv2.putText(radar, str(speed)+'km/h '+str(accumulate_distance)+'m', (int(box[0]-60), int(box[1])-20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)  #tracker_Window
            
             # 레이더창에 실시간으로 선수의 볼터치 비율 보여주기 
            cv2.putText(radar, 'Speed : '+str(speed)+'km/h'+ ', Top speed : '+str(top_speed)+ 'km/h',(55, 40), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
            cv2.putText(radar, 'Average speed : '+str(avg_speed)+'km/h'+', Running Distance : '+str(accumulate_distance)+'m', (55, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
            cv2.putText(radar, 'Walk / Jog / Sprint Count: '+str(walk_count)+' / '+str(jog_count)+' / '+str(sprint_count), (55, 80), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
            cv2.putText(radar, 'Ball Touch Count: '+str(ball_touch), (55, 100), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
            #cv2.putText(radar, 'Pass Count: '+str(pass_count), (55, 120), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                
            
            
            frame_count=frame_count+1   # 프레임 갯수를 세어줌
            
            
                    

            # show all windows
            cv2.imshow('MainWindow', frame)
            #cv2.imshow('PathMap',pathmap)
            cv2.imshow('Radar',radar)
            
            # quit on ESC button
            if cv2.waitKey(1) & 0xFF == 27:  #incase Esc is pressed
                cv2.destroyAllWindows() # 화면 종료해주기
                break
        
        avg_speed = accumulate_speed / (frame_count/fps)
        avg_speed = round(avg_speed,1)

        print('총 뛴 거리 : ', accumulate_distance,'m')
        print('최고 속도 : ', top_speed,'km/h')
        print('평균 속도 : ', avg_speed,'km/h')

        
        print('걸음 수 : ',walk_count,' / 뜀 수 : ',jog_count,' / 스프린트 수 : ',sprint_count)
        move_sum = walk_count+jog_count+sprint_count
        walk_weight = round(walk_count / move_sum * 100,1)
        jog_weight = round(jog_count / move_sum * 100,1)
        sprint_weight = round(sprint_count / move_sum * 100,1)
        
        # 산소 소비량으로 측정하는 대략적인 칼로리 계산법   평균 속도 * (3.5 * 몸무게 * 시간(분) * 5 / 1000
        # 몸무게는 성인 남성 평균체중인 75kg로 가정
        cal = round(avg_speed * (3.5 * 75 *( 0.0167 * move_sum )) * 5 / 1000,1)
        print('\n소모 칼로리 : ',cal)

        # Video Time Calcurator
        video_time= round((frame_count / fps),2)
        
        
        player_coords_text.write(coords_string)
        player_coords_text.close()
        if(not(coords_string=='')) :
            heatmap.printHeatMap(height,width)
            
         ########################## 공 점유율 계산 알고리즘 ###############################################
        if player >= flag + 1 : # A팀 3명, B팀 5명으로 경기할 경우 -> flag = 3 
            ball_share_B.append(ball_touch)   
            print('B팀 ', player-flag, '번째 선수 개인의 공 점유 프레임 수 : ', ball_share_B[player-flag-1]) # 0, 1...
            sum_ball_B += ball_share_B[player-flag-1]
            print('B팀 공 점유 프레임 수 누적값: ', sum_ball_B)
        else :
            ball_share_A.append(ball_touch) 
            print('A팀 ', player, '번째 선수 개인의 공 점유 프레임 수 : ', ball_share_A[player-1])
            sum_ball_A += ball_share_A[player-1]
            print('A팀 공 점유 프레임 수 누적값: ', sum_ball_A)
            
        #############################################################################################

    

    # 최종 데이터를 DB로 전송할 부분
    ##########################################################################################
    # distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
    # walk_weight = 걷기 비중, jog_weight = 조깅 비중, sprint_weight = 스프린트 비중
    # cal = 소모 칼로리
    # result_heatmap.png = 최종 히트맵 파일명
    ##########################################################################################
    
    #######################################################################################################
    #                                           PyMySQL문법                                               #
    #######################################################################################################
    # MySQL 문법 나중에 distance부분에 NOT NULL 추가해주면 좋음 아직 미구현 상태인거 같아서 필드만 만들어 놓음
    
    executeSQL.CommitResult(player_id, avg_speed, top_speed, accumulate_distance, cal, walk_weight, jog_weight, sprint_weight, video_time, play_id)

    # 최종 데이터를 DB로 전송할 부분
    ##########################################################################################
    # distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
    ##########################################################################################
        
    
    ########################################공 점유율 계산 알고리즘################################################
    
    #for문이 다 돌은 뒤 공 점유율 계산
    ball_share_A_res = sum_ball_A / (sum_ball_A + sum_ball_B) * 100
    ball_share_A_res = round(ball_share_A_res,1)
    ball_share_B_res = sum_ball_B / (sum_ball_A + sum_ball_B) * 100
    ball_share_B_res = round(ball_share_B_res,1)

    
    print('\n')
    print('---------------------------------------------------------------------------------------------------')
    print('A팀 공 점유율: ', sum_ball_A, '  (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_A_res, '%')
    print('B팀 공 점유율: ', sum_ball_B, '  (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_B_res, '%')
    print('---------------------------------------------------------------------------------------------------')
    
    ##########################################################################################################
    ##########################################하이라이트 추출 알고리즘#################################################
    
    
    print('\n')
    print('하이라이트 추출 시작.....')
    
    ########################Goal.mov영상 생성#######################
    # 골을 인식한 프레임이 영상에서 몇 초쯤인지 계산
    videoFps = video_stream.get(cv2.CAP_PROP_FPS)   # 1초에 지나가는 프레임 수(fps)
    point1 = int (highlight_goal_point / videoFps )
    
    # 골을 인식한 프레임 앞으로 3초, 뒤로 2초
    start = point1 - 3
    end = point1 + 2
    
    # 영상의 start부터 end까지 영역을 자름 (초 기준)
    ffmpeg_extract_subclip(video_path, start, end, targetname="../result/Goal.mov") 
    
    ####################Goal_zoom1.mov 영상 생성######################
    video_stream = cv2.VideoCapture('../result/Goal.mov')

    #재생할 파일의 넓이와 높이
    width = video_stream.get(cv2.CAP_PROP_FRAME_WIDTH)
    height = video_stream.get(cv2.CAP_PROP_FRAME_HEIGHT)

    #print("재생할 파일 넓이, 높이 : %d, %d"%(width, height))

    fourcc = cv2.VideoWriter_fourcc(*'DIVX')
    out1 = cv2.VideoWriter('../result/Goal_zoom1.mov', fourcc, 30.0, (int(width), int(height)))
    out2 = cv2.VideoWriter('../result/Goal_zoom2.mov', fourcc, 30.0, (int(width), int(height)))


    while(video_stream.isOpened()):
        ret, frame = video_stream.read()
    
        if ret == False:
            break;
        # out1에 해당
        scale =50
        height, width, channel = frame.shape
        centerX, centerY = int(height*0.5), int(width*0.75)  #골인시 줌 위치 
        radiusX, radiusY = int(scale*height/100), int(scale*width/100)
    
        minX,maxX=centerX-radiusX,centerX+radiusX
        minY,maxY=centerY-radiusY,centerY+radiusY
    
        cropped = frame[minX:maxX, minY:maxY]
        resized_cropped = cv2.resize(cropped, (width, height))    
        
        out1.write(resized_cropped)
        
        # out2에 해당
        scale2 = 40
        height2, width2, channel2 = frame.shape
        centerX2, centerY2 = int(height2*0.5), int(width2*0.75)  #골인시 줌 위치 
        radiusX2, radiusY2 = int(scale2*height2/100), int(scale2*width2/100)
    
        minX2,maxX2=centerX2-radiusX2,centerX2+radiusX2
        minY2,maxY2=centerY2-radiusY2,centerY2+radiusY2
    
        cropped2 = frame[minX2:maxX2, minY2:maxY2]
        resized_cropped2 = cv2.resize(cropped2, (width2, height2))    
        
        out2.write(resized_cropped2)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    
    video_stream.release()
    out1.release()
    out2.release()
    cv2.destroyAllWindows()
    ######################################Highlight.mov###################################
    
    # concat함수를 이용해 비디오를 합쳐주기
    clip1 = VideoFileClip('../result/Goal.mov')
    clip2 = VideoFileClip('../result/Goal_zoom1.mov')
    clip3 = VideoFileClip('../result/Goal_zoom2.mov')
    
    final_clip = concatenate_videoclips([clip1, clip2, clip3])
    final_clip.write_videofile('../result/Highlight.mov', codec='libx264') # 코텍 적어줘야

    
    print('하이라이트 영상 생성 완료.....')
    #test용 코드
    #print(highlight_goal_point, ' ', start, ' ', end) 
    
    ##########################################################################################################


  


# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도


# 30초마다 평균속도, 최종 히트맵, 칼로리, 비율
