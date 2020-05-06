from __future__ import print_function       # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                          # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                                  # 오픈cv 열기
import os                                   # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                                  # 환경변수같은 인수를 입력받는 모듈
import random                               # 난수 생성할때 사용하는 모듈
import imutils                              # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리

import math
import collections


import heatmap

import filepath                             # Video File Open GUI 모듈
#import LoginDB                              # MySQL Connector & MySQL Login 모듈
import executeSQL                           # SQL 쿼리문을 실행하는 모듈

import pymysql                              # python에서 MySQL을 사용할 수 있게 하는 모듈
import createBBox                         # 관심구역 지정 모듈     
import selectGUI                  


def calculate_moving_distance(player_coord, last_coord):
    weight = 4
    # 초당 프레임간 발생한 거리차이를 a, b에 누적시킴 
    x = player_coord.x - last_coord.x
    y = player_coord.y - last_coord.y
    
    moving_value=math.sqrt(math.pow(x,2) + math.pow(y,2)) # 초당 움직인 거리(즉 속도) - 유클리디안 거리측정 사용
    
    # 트레커 추적중 발생하는 진동을 최소화하기위한 코드
    if(moving_value < 2) :
        moving_value=0
    
    moving_distance = weight * moving_value / 100     # 경기장 크기에따른 가중치를 통해 m단위로 변환 
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
 
def print_player_box(player_id, frame, box):
    point_start = (int(box[0]), int(box[1]))
    point_end = (int(box[0] + box[2]), int(box[1] + box[3]))
    en_name = str(executeSQL.EngName(player_id))
    
    # 선수를 빨간 박스로 추적
    cv2.rectangle(frame, point_start, point_end, (0,0,255), 2, 1)

    # 선수의 왼쪽위에 이름 출력
    cv2.putText(frame, en_name, (point_start[0]-10, point_start[1]-10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)


if __name__ == '__main__':

   # 영상 파일 경로를 GUI로 입력받음
    video_object = filepath.OpenPath()
    video_path = video_object.video_path
    print("비디오 경로 : ",video_path)
    # video_path = "../sample_videos/TEST.mov"
    
    ######################################################
    player_number = selectGUI.PlayerNumber()
    home = player_number.home_int
    away = player_number.away_int
    print("home : ",home, " / away : ", away)
    
    # 6명 vs 6명으로 뛴다고 입력 받았을 경우
    total_player = home + away # 경기에 참여하는 플레이어 수가 12명인 경우
    flag = home
    
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
        
        ############################################################

        # 히트맵창의 배경이 될 이미지 지정
        pitch_image = cv2.imread('../image/heatmap2.png')
        pitch_image = cv2.resize(pitch_image,(width,height))
        
        # 선수 좌표값을 저장할 파일
        player_coords_text = open( '../result/player_coord.txt', 'w' )
        
        
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


        #좌표를 표현할 이름있는 튜플
        Point = collections.namedtuple('Point',['x','y'])
        last_coord = Point(x=0, y=0)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
        arrow_tail= Point(x=0,y=0)


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
            print_player_box(player_id, frame, box)
            
            # radar창의 배경을 초기화 해줌
            radar = pitch_image.copy()        
            cv2.circle(radar, player_coord, 10, (0,0,255), -1)

            
            # 거리와 속도 추정치를 계산하기 위한 코드들
            if(frame_count==0) :
                last_coord = arrow_tail =  player_coord   # 첫 프레임에서는 과거 좌표를 현재좌표와 동일하게 초기화함
                
            if((frame_count%fps)==0) :     # 프레임기반 1초(fps)마다 동작하는 코드
                #distance = 거리
                #walk_weight = 걷기 비중, jog_weight = 조깅 비중, sprint_weight = 스프린트 비중
            
                moving_distance = calculate_moving_distance(player_coord, last_coord)
                
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
                
            #f.write(str(int(box[1]))+','+str(int(box[0]))+'\n')
            coords_string = coords_string+str(int(box[1]))+','+str(int(box[0]))+'\n'  # coords_string 스트링에 좌표값을 누적시킴
            frame_count=frame_count+1   # 프레임 갯수를 세어줌
            
            # print('거리 추정치 : ', distance, ' / 속도 추정치 : ',speed,' km/h')
            
            # 누적 거리값을 레이더의 플레이어 머리위에 띄워줌
            cv2.putText(radar, str(speed)+'km/h '+str(accumulate_distance)+'m', (int(box[0]-60), int(box[1])-20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)  #tracker_Window
            
                    

            # show all windows
            cv2.imshow('MainWindow', frame)
            cv2.imshow('PathMap',pathmap)
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



# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도


# 30초마다 평균속도, 최종 히트맵, 칼로리, 비율
