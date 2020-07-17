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

import heatmap                              # Heatmap 생성 모듈
import filepath                             # Video File Open GUI 모듈
#import LoginDB                              # MySQL Connector & MySQL Login 모듈
import executeSQL                           # SQL 쿼리문을 실행하는 모듈
import pymysql                              # python에서 MySQL을 사용할 수 있게 하는 모듈
import createBBox                           # 관심구역 지정 모듈     
import selectGUI                            # GUI 생성 모듈
import highlight                            # 하이라이트 추출 모듈
import ballTracking                         # 공 인식 및 추적 모듈
import graph                                # 그래프 생성 모듈

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

# 국제 규격 골대 사이즈에 기반하여 프레임 속 사이즈 계산    
def calculate_goalnet_size(stadium_width, stadium_height, width, height, flag) : 
    
    if flag == 1 : 
        # 국제 규격의 골대 너비: 100
        width_rate = 100 / stadium_width 
        frame_goalnet_width = width * width_rate
        return frame_goalnet_width
        
    if flag == 0 :
        # 국제 규격의 골대 높이: 300
        height_rate = 300 / stadium_height
        frame_goalnet_height = height * height_rate 
        return frame_goalnet_height
    

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
    y, x, z = np.genfromtxt('../result/ball_coord.txt', delimiter=',', unpack=True,dtype=int)
    return (x,y, z)

def ball_is_in_penalty_area(ball_x, ball_y, stadium_width, goalnet_width, goalnet_height, width, height) : 
    
    # 국제 규격의 패널티 거리 : 600cm 
    width_rate = 600 / stadium_width 
    frame_600 = width * width_rate
       
       
    # 왼쪽 페널티 영역    
    left_center_x1 = goalnet_width
    left_center_y1 = height/2 - goalnet_height/2
    x1 = left_center_x1 - ball_x
    y1 = left_center_y1 - ball_y
    
    left_center_x2 = goalnet_width
    left_center_y2 = height/2 + goalnet_height/2
    x2 = left_center_x2 - ball_x
    y2 = left_center_y2 - ball_y
    
    left_rect_width = goalnet_width + frame_600
    left_rect_height1 = height/2 - goalnet_height/2 
    left_rect_height2 = height/2 + goalnet_height/2
    
    if (math.sqrt(math.pow(x1,2) + math.pow(y1,2)) <= frame_600  or
            math.sqrt(math.pow(x2,2) + math.pow(y2,2)) <= frame_600 or
            (ball_x <= left_rect_width and left_rect_height1 <= ball_y <= left_rect_height2) ) :
        return True 
   
    
    #오른쪽 페널티 영역
    right_center_x3 = width - goalnet_width
    right_center_y3 = height/2 - goalnet_height/2   
    x3 = right_center_x3 - ball_x
    y3 = right_center_y3 - ball_y
    
    right_center_x4 = width - goalnet_width
    right_center_y4 = height/2 + goalnet_height/2
    x4 = right_center_x4 - ball_x
    y4 = right_center_y4 - ball_y
    
    right_rect_width = width - (goalnet_width + frame_600)
    right_rect_height1 = height/2 - goalnet_height/2 
    right_rect_height2 = height/2 + goalnet_height/2
    
    if (math.sqrt(math.pow(x3,2) + math.pow(y3,2)) <= frame_600  or
            math.sqrt(math.pow(x4,2) + math.pow(y4,2)) <= frame_600 or
            (right_rect_width <= ball_x  and right_rect_height1 <= ball_y <= right_rect_height2) ) :
        return True 
    else :
        return False



if __name__ == '__main__':

    # 영상 파일 경로를 GUI로 입력받음
    video_object = filepath.OpenPath()
    video_path = video_object.video_path
            
    # 영상 파일 경로를 통해 video_stream을 읽어옴
    video_stream = cv2.VideoCapture(video_path)  
 
    # 영상의 헤드, 성공여부, 프레임값, 높이, 너비, 영상 fps, 4분기 간격 반환
    success, frame, height, width, fps, interval = init_video(video_stream) 
    
    # kpu 풋살장 3068*1590 / 연수풋살장 3800*1800 / 평균 4000 * 2000
    # 일단 하드코딩 GUI로 구현예정
    stadium_width = 3800
    stadium_height = 1800
    
    # 공을 추적하고 결과를 텍스트로 저장함 // 시간 오래걸릴땐 주석처리
    #ballTracking.track_ball(video_path)
   
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

    # 프레임 속 골대의 너비, 높이 계산 
    goalnet_width = calculate_goalnet_size(stadium_width, stadium_height, width, height, 1)
    goalnet_height = calculate_goalnet_size(stadium_width, stadium_height, width, height, 0)
    print('실제 골대 크기에서 프레임 크기로 반환 \n')
    print('골대 너비 : ', round(goalnet_width, 1), '\n')
    print('골대 높이 : ', round(goalnet_height,1) , '\n')



    
    ######################################################
    
    for player in range(1, total_player+1): # 선수 1부터 total_player까지 반복문
       
        
        # 영상 파일 경로를 통해 video_stream을 읽어옴
        video_stream = cv2.VideoCapture(video_path) 
        
        # 영상의 헤드, 성공여부, 프레임값, 높이, 너비, 영상 fps, 4분기 간격 반환
        success, frame, height, width, fps, interval = init_video(video_stream) 
        
        
        ############################################################
        # 초기 로그인 모듈을 활용해 로그인을 진행하고 사용자의 아이디를 받아옴
        #player_id = LoginDB.login_function()
        
        
        # 팀선택과 플레이어선택을 나눌것임 
        ###################################################
        #기존코드
        #player_object = selectGUI.PlayerSelect()
        #player_id = player_object.selected_player
        #player_team = player_object.selected_team
        ###################################################
        
        if(player == 1 or (player==flag+1)) :
            player_team = selectGUI.TeamSelect().selected_team
        player_id = selectGUI.PlayerSelect(player_team).selected_player
        
        
        
        
        # 사용자 아이디를 바탕으로 PlayerTable을 생성하거나 접속함
        executeSQL.CreatePlayerTable(player_id)
        
        # 사용자 ID를 기반으로 Pathmap Table을 생성해줌
        pathmap_table = executeSQL.CreatePathmapTable(player_id)
        
        # 경기정보 식별을 위해 play_id를 받아옴
        play_id = executeSQL.PlayID(player_id)
        
        en_name = str(executeSQL.EngName(player_id))

        ############################################################
        
        # 히트맵창의 배경이 될 이미지 지정
        pitch_image = cv2.imread('../image/pitch.png')
        pitch_image = cv2.resize(pitch_image,(width,height))
        
        # 결과창의 배경이 될 이미지 지정
        result_image = cv2.imread('../image/result_background_small.png')

        
        #result_image = cv2.resize(pitch_image,(width,height))
        
        
        # 선수 좌표값을 저장할 파일
        player_coords_text = open( '../result/player_coord.txt', 'w' )
        
        ##################################################이미 분석한 선수 박스 쳐 주는 부분 #########################################################
        if(player>1) :
            print(past_box)
            i = 0
            for boxinfo in past_box:
                box_p1 = (int(boxinfo[0]), int(boxinfo[1]))
                box_p2 = (int(boxinfo[0] + boxinfo[2]), int(boxinfo[1] + boxinfo[3]))
                i += 1
                if i <= flag : # A팀 
                    cv2.rectangle(frame, box_p1, box_p2, (0,0,255), 2, 1) #빨강
                    cv2.putText(frame, boxinfo[4]+' '+boxinfo[5], (int(boxinfo[0])-27, int(boxinfo[1])-5), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window
                else : # B팀
                    cv2.rectangle(frame, box_p1, box_p2, (255,0,1), 2, 1) #파랑
                    cv2.putText(frame, boxinfo[4]+' '+boxinfo[5], (int(boxinfo[0])-27, int(boxinfo[1])-5), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,0,1), 1, cv2.LINE_AA)  #Multitracker_Window
                
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
        walk_percent = 0
        jog_percent = 0
        sprint_percent = 0
        distance_value = 0
        pathmap=pitch_image.copy()
        
        result_window=result_image.copy()
        
        ball_touch = 0                  # roi로 선택한 선수가 공을 점유한 프레임 수(볼 터치 수)를 카운팅함 
        show_goal_frame = 0             # 골인 경우 화면에 fps 프레임수 동안 "골인입니다" 표시하기 위해
        highlight_goal_point = 0        # 하이라이트 추출시 골인인 프레임을 중심으로 앞뒤로 6초동안 보여주기
        highlight_goal_fail_point = 0   # 하이라이트 추출시 골 시도했지만 실패인 프레임을 중심으로 앞뒤로 6초동안 보여주기

        secs=0
        sec_list=[]
        speed_list=[]


        #좌표를 표현할 이름있는 튜플
        Point = collections.namedtuple('Point',['x','y'])
        last_coord = Point(x=0, y=0)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
        arrow_tail= Point(x=0,y=0)
        
        ball_x,ball_y,ball_frame_count = readBallCoord() # 공의 좌표, 공이 인식된 프레임 읽어오기
        
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
            
            
            ############################################# 공 좌표 읽어오는 부분 #############################
            if(ball_x[frame_count] > -1):
            
                ###################################################골 인식 알고리즘 #############################################################                          
                
                # 공이 슬로우모션으로 쫓아가는 현상 해결(현재 프레임과 공이 인식된 프레임 번호가 같을 경우만 화면에 공 출력)
                if ball_frame_count[frame_count] == frame_count :
                
                    # Home 팀의 골인 경우
                    if ball_x[frame_count] >= width - goalnet_width + 5 : # 골대(국제 규격)에 공이 진입시 (오차 5감안)
                        if height * 0.5 - (goalnet_height/2) <= ball_y[frame_count] <= height * 0.5 + (goalnet_height/2) : # 국제 규격에 맞춤
                            
                            print('Home팀 골인입니다!!!!!', frame_count)
                            
                            cv2.putText(frame, 'Home team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                            show_goal_frame = 1
                            highlight_goal_point = frame_count # 골인을 인식한 프레임을 하이라이트 기준으로 삼음 
                    
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 0, 255), 2) # 빨간색으로 표시
                            pre_frame_count = frame_count
                            
                            
                    # Away팀의 골인 경우 
                    elif ball_x[frame_count] <= goalnet_width-5 : 
                        if height * 0.5 - (goalnet_height/2) <= ball_y[frame_count] <= height * 0.5 + (goalnet_height/2) : # 국제 규격에 맞춤
                            
                            print('Away팀 골인입니다!!!!!', frame_count)
                            
                            cv2.putText(frame, 'Away team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                            show_goal_frame = 1
                            highlight_goal_point = frame_count # 골인을 인식한 프레임을 하이라이트 기준으로 삼음
                            
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 0, 255), 2) # 빨간색으로 표시
                            pre_frame_count = frame_count
                    
                
                    # '골'이 아닌 경우
                    else : 
                        # 패널티 에어리어에 진입시
                        if ball_is_in_penalty_area(ball_x[frame_count], ball_y[frame_count], stadium_width, goalnet_width, goalnet_height, width, height) == True : 
                            highlight_goal_fail_point = frame_count
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 228, 255), 2) #노란색 
                            
                        else :
                            cv2.circle(frame, (ball_x[frame_count], ball_y[frame_count]), 5, (0, 0, 0), 2) # 검은색
                            

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
                    
                #속도 비율 계산    
                if (walk_count + jog_count + sprint_count != 0) :
                    walk_percent = round(walk_count / (walk_count + jog_count + sprint_count) * 100, 1)
                    jog_percent = round(jog_count / (walk_count + jog_count + sprint_count) * 100, 1)
                    sprint_percent = round(sprint_count / (walk_count + jog_count + sprint_count) * 100, 1)
                
                
                last_coord = player_coord   # 과거 좌표 갱신
                
                secs+=1
                sec_list.append(secs)
                speed_list.append(speed)
                
                move_ratio=[walk_percent,jog_percent,sprint_percent]
                
                graph.drow_graph(sec_list,speed_list,move_ratio,en_name)
                
                #txt 로그로 남겨주는 부분
                # f.write( 'Player '+str(i)+' x,y: '+str(int(box[0]))+','+str(int(box[1])) + '\n' )
                # fTemp.write(str(int(box[1]))+','+str(int(box[0]))+'\n')  히트맵에 더많은 로그를 찍기위해 이동
           
            if(frame_count % (fps*2)==0) :
                overlay=pathmap.copy()
                cv2.arrowedLine(overlay,arrow_tail, player_coord, (0,0,0),2,cv2.LINE_AA)
                cv2.arrowedLine(overlay,arrow_tail, player_coord, (0,0,0),2,cv2.LINE_AA)
                pathmap = cv2.addWeighted(overlay, 0.5, pathmap, 0.5, 0)  #Heatmap_Window
                arrow_tail = player_coord


            ''' 속도 개선을 위해 잠시 pathmap을 넘기는 부분을 지움
            if((frame_count % (fps*10))==0) :     # 프레임기반 10초(fps)마다 동작하는 코드
                if(frame_count==0) : 
                    pathmap_filename = '../result/pathmap_0secs.png'
                else :
                    pathmap_filename = '../result/pathmap_'+str(frame_count / (fps*10)*10)+'secs.png'

                cv2.imwrite(pathmap_filename, pathmap, [cv2.IMWRITE_PNG_COMPRESSION, 0])

                # image를 base64형식으로 바꾸고 데이터 베이스에 저장
                executeSQL.CommitPathmap(pathmap_filename,pathmap_table,play_id)
            '''

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
            
            #골인 경우 2초 동안 화면에 출력해주기 위함
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
            
            ######################################################################################
            # 모듈화 예정
            
           
            result_window=result_image.copy()
            # 레이더창에 실시간으로 선수의 볼터치 비율 보여주기 
            cv2.putText(result_window, str(en_name),(65, 32), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(accumulate_distance)+'m',(263, 32), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(ball_touch),(485, 32), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            
            cv2.putText(result_window, str(speed) +'km/h',(65, 95), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(top_speed) +'km/h',(263, 95), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(avg_speed) +'km/h',(485, 95), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            
            
            cv2.putText(result_window, str(walk_percent) + '%',(65, 160), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(jog_percent)+ '%',(263, 160), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            cv2.putText(result_window, str(sprint_percent)+ '%',(485, 160), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
            
            ######################################################################################

            # show all windows
            cv2.imshow('MainWindow', frame)
            #cv2.imshow('PathMap',pathmap)
            cv2.imshow('Radar',radar)
            # show result window
            cv2.imshow('result', result_window)
            
            # 영상 일시 정지
            key = cv2.waitKey(1) & 0xFF
            if key == 32: # space 키   
                cv2.waitKey(0)
                
            # 종료 
            if key == 27:  # esc키 
                cv2.destroyAllWindows() # 화면 종료해주기
                graph.destroy_graph()
                break    
            
            ################################################ 트래커가 선수객체 놓쳤을 경우###########################################
            
            if key == ord('p'):  # 'p' 키
                cv2.putText(frame, 'Draw new box!!',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                cv2.imshow('MainWindow', frame)
                
                if player <= flag : 
                    bbox = createBBox.select_bbox(player_num, home, player_team, video_stream, frame);
                else :
                    bbox = createBBox.select_bbox(player_num, away, player_team, video_stream, frame);
                tracker = cv2.TrackerCSRT_create()
                tracker.init(frame, bbox)
                
            ##################################################################################################################
            
            
             
        
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
            
        ################################ 공 점유율 계산 알고리즘 ###############################################
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
        
        cv2.destroyAllWindows() # 화면 종료해주기
        graph.destroy_graph()
    

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
        
    end_window = np.ones((350,710,3), np.uint8)
    end_window = end_window*240
    
    ########################################공 점유율 계산 알고리즘################################################
    #모듈화 예정
    #for문이 다 돌은 뒤 공 점유율 계산
    ball_share_A_res = sum_ball_A / (sum_ball_A + sum_ball_B) * 100
    ball_share_A_res = round(ball_share_A_res,1)
    ball_share_B_res = sum_ball_B / (sum_ball_A + sum_ball_B) * 100
    ball_share_B_res = round(ball_share_B_res,1)

    
    print('\n')
    print('---------------------------------------------------------------------------------------------------')
    print('A팀 공 점유율: ', sum_ball_A, ' / (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_A_res, '%')
    print('B팀 공 점유율: ', sum_ball_B, ' / (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_B_res, '%')
    
    result_str = '-----------------------------------\n' \
    +'  A Team Ball share : ' + str(sum_ball_A) + ' % (' + str(sum_ball_A) + '+' + str(sum_ball_B) + ') x 100 = ' + str(ball_share_A_res)+ '%\n' \
    +'  B Team Ball share : ' + str(sum_ball_B) + ' % (' + str(sum_ball_A) + '+' + str(sum_ball_B) + ') x 100 = ' + str(ball_share_B_res) + '%\n' \
    + '------------------------------------'
    
         
    # A팀 선수 개인의 기여도 %
    print('\nA팀 선수 개인의 기여도')
    result_str += '\nA Team player contribution rate\n  '
    j = 0
    for i in ball_share_A :   
        contribution_rate = round(i / sum_ball_A * 100, 1)
        print(past_box[j][5], ' : ', contribution_rate, '%')
        result_str += past_box[j][5] + ' : ' + str(contribution_rate) + '%\n  '
        j += 1
        
    print('\n')

    # B팀 선수 개인의 기여도 % 
    j = 0
    print('B팀 선수 개인의 기여도')
    result_str += '\nB Team player contribution rate\n  '

    for i in ball_share_B :
        contribution_rate = (round)(i / sum_ball_B * 100, 1)
        print(past_box[j+flag][5], ' : ', contribution_rate, '%')
        result_str += past_box[j+flag][5] + ' : ' + str(contribution_rate) + '%\n  '
        j += 1
    
    
    
    
    print('---------------------------------------------------------------------------------------------------')
    
    
    #하이라이트 추출
    if highlight_goal_point != 0: 
        print('\n')
        print('하이라이트 추출 시작.....')
        highlight.makeHighlight(video_stream, video_path, highlight_goal_point) # 모듈 호출
        
    
    y0, dy = 50, 30
    for i, line in enumerate(result_str.split('\n')):
           y = y0 + i*dy
           cv2.putText(end_window, line, (50, y ), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
           
    #cv2.putText(end_window, result_str,(30, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 1, cv2.LINE_AA)
    cv2.imshow('end', end_window)
    cv2.waitKey(0)    
    
    executeSQL.CloseConnect()


# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도


# 30초마다 평균속도, 최종 히트맵, 칼로리, 비율