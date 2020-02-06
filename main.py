from __future__ import print_function       # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                          # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                                  # 오픈cv 열기
import os                                   # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                                  # 환경변수같은 인수를 입력받는 모듈
import random                               # 난수 생성할때 사용하는 모듈
import imutils                              # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
# import pycuda     
import math     
import collections

import pymysql                              # python에서 MySQL을 사용할 수 있게 하는 모듈
from io import BytesIO                      # 
from PIL import Image                       # PIL 모듈 Image를 다루기 위한 것
import base64                               # base64 형식으로 인코딩 디코딩하기 위한 모듈
import pandas as pd                         # pandas 모듈 Dataframe을 다루기 위한 모듈
from sqlalchemy import create_engine        # MySQL 다루기 위한 PyMySQL과 다른 모듈

# to have different colours in plotting heatmaps for different players
# 히트맵에 각기 다른 색상을 표현하기 위한 튜플로 된 리스트  12개
colors123 = [(0,0,0),(255,255,255),(255,0,0),(0,255,0),(0,0,255),(255,255,0),(0,255,255),(255,0,255),(192,192,192),(244,164,96),(128,128,0),(240, 50, 230)]

if __name__ == '__main__':

#######################################################################################################
#                                           PyMySQL문법                                               #
#######################################################################################################

    # MySQL의 데이터베이스를 로그인하고 연결하는 메소드 pymysql.connect() connect는 관련된 정보를 저장하는 변수
    connect = pymysql.connect(host='localhost', user='root', password='1234', db='AIWUserDB',charset='UTF8MB4')

    # 데이터베이스의 데이터를 받아오는 메소드 .corsor()
    cursor = connect.cursor()

    player_id = input("ID를 입력해주세요 : ")

    while True:
        if isinstance(player_id,str):
            break
        else :
            player_id = input("ID를 입력해주세요 : ")

    # SQL 문법으로 명령어를 .format() 메소드로 합성
    sql = "select * from coachsignupinfo where id = '{0}'".format(player_id)

    # 파이썬으로 작성한 SQL문법을 MySQL에서 실행하는 메소드 .execute()
    cursor.execute(sql)

    # 받아온 데이터에서 하나의 레코드만(행)을 가져오는 메소드 .fetchone() / 모든 데이터 .fetchall()
    player_information = cursor.fetchone()

    # 데이터 변화 적용
    # CREATE 혹은 DROP, DELETE, UPDATE, INSERT와 같이 Database 내부의 데이터에 영향을 주는 함수의 경우 .commit()을 해주어야 함.
    # conn.commit()

    ##################################################################
    ##이미지를 base64 형식으로 바꾸고 MySQL을 이용해서 DB 저장하는 부분##
    ##################################################################

    # SQL Alchemy를 이용하여 Python과 MySQL을 연결하는 메소드
    engine = create_engine('mysql+pymysql://root:1234@localhost/AIWUserDB', echo = False, encoding='utf-8')

    buffer = BytesIO()

#######################################################################################################

    tracker = cv2.TrackerCSRT_create()  # CSRT tracker 초기화
    videoPath = 'drone2.mp4'   # Read video. here it is pano.mp4 in the same directory
 
    # Create a video capture object to read videos 
    cap = cv2.VideoCapture(videoPath)#비디오를 읽는 함수-길
    
    # Set video to load
    success, frame = cap.read()
    
    fps = cap.get(cv2.CAP_PROP_FPS)
    fps = round(fps,0)
    print(fps)

    frame = imutils.resize(frame, width=600) # 리사이징
    
    backSub = cv2.createBackgroundSubtractorMOG2() # cv에서 제공하는 배경제거를 위한 마스크 초기화

    heatmap_background = cv2.imread('heatmap.png')    # heatmap.png as heatmap window's background
    original = cv2.imread('heatmap.png')
    f = open( 'file.txt', 'w' )
    # quit if unable to read the video file
    if not success:
        print('Failed to read video')
        sys.exit(1)

    ## Select boxes 빈 리스트 선언
    bboxes = []
    colors = [] 
    p=0
    # OpenCV's selectROI function doesn't work for selecting multiple objects in Python
    # So we will call this function in a loop till we are done selecting all objects
    while True:
        
        fgMask = backSub.apply(frame)   # frame에 배경제거 mask를 적용시켜 이미지 생성

        print('Select the Player')

        # ?draw bounding boxes over objects
        # ?selectROI's default behaviour is to draw box starting from the center
        # ?when fromCenter is set to false, you can draw box starting from top left corner
        bbox = cv2.selectROI('MultiTracker', frame) #roi 를 선택하는 함수-길
                                                    #roi 정보가 bbox 에 저장되어 사용된다-길
                                                    #tracker.init(frame123, bbox) # 오브젝트 트래커가 frame123과 bboc를 따라가게끔 설정한다.
        bboxes.append(bbox)
        if (p<6):
            colors.append((0,0,255))
        else:
            colors.append((255,0,0))
        print("Press q to quit selecting boxes and start tracking")
        print("Press any other key to select next object : ", p)
        p=p+1
        k = cv2.waitKey(0) & 0xFF
        if (k == 113):  # q is pressed
            break
    print('Selected bounding boxes {}'.format(bboxes))



    # Create MultiTracker object
    multiTracker = cv2.MultiTracker_create()
    
    #좌표를 표현할 이름있는 튜플
    Point = collections.namedtuple('Point',['x','y'])
    lastPoint = Point(x=-1, y=-1)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
    estimate_distance = 0           # 영상기반 추정거리값을 저장
    distance = 0                    # 거리값을 저장
    frame_cnt = 0                   # 프레임을 카운팅함                   
    moving_weight = 0               # 움직인 거리의 비중을 저장
    top_speed = 0                   # 최고 속도를 저장
    accumulate_speed = 0            # 속도들의 누적값
    temp_distance = 0               # 뛴 거리를 임시저장
    section_distance = 0            # 특정 시간마다의 뛴거리

    

    # Initialize MultiTracker 
    for bbox in bboxes:
        multiTracker.add(tracker, fgMask, bbox)

    # Process video and track objects
    while cap.isOpened():#비디오가 잘 열렸는지 확인하는 함수-길
        success, frame = cap.read()# cap.read() 는 동영상을 1프레임씩 읽어오는 것-길

        if not success:
            break

        frame = imutils.resize(frame, width=600) # 리사이징
        
        fgMask = backSub.apply(frame)   # 프레임에 마스크를 적용시켜 그레이스케일로 만들어줌


        # get updated location of objects in subsequent frames
        success, boxes = multiTracker.update(frame)  #update() 따라가게 만드는 함수 - 길
        l,b ,channels = frame.shape  #maintain all tabs in same shape
        heatmap_background = cv2.resize(heatmap_background,(b,l))
        original = cv2.resize(original,(b,l))
        radar = original.copy()
        # draw tracked objects
        for i, newbox in enumerate(boxes):
            p1 = (int(newbox[0]), int(newbox[1]))
            p2 = (int(newbox[0] + newbox[2]), int(newbox[1] + newbox[3]))
            cv2.rectangle(frame, p1, p2, colors[i], 2, 1)
                        # rectangle(): 직사각형을 그리는 함수-길
                        #파라미터 (이미지, 왼쪽 위 좌표, 오른쪽 아래 좌표, 사각형 색깔, 사각형의 두께, ?? ) -길

            if (i<6):
                cv2.putText(frame, str(i), (int(newbox[0]), int(newbox[1])), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window

                cv2.circle(radar,(int(newbox[0]), int(newbox[1])), 10, (0,0,255), -1)
                #Radar_Window

                overlay=heatmap_background.copy()
                alpha = 0.1  # Transparency factor.
                cv2.circle(overlay,(int(newbox[0]), int(newbox[1])), 10, colors123[i], -1)   #Heatmap_Window
                # Following line overlays transparent rectangle over the image
                heatmap_background = cv2.addWeighted(overlay, alpha, heatmap_background, 1 - alpha, 0)  #Heatmap_Window
                
                
                # 거리와 속도 추정치를 계산하기 위한 코드들
                if(frame_cnt==0) :
                    lastPoint = Point(x = int(newbox[0]), y = int(newbox[1]))   # 첫 프레임에서는 과거 좌표를 현재좌표와 동일하게 초기화함
                    
                if((frame_cnt%fps)==0) :     # 프레임기반 1초(fps)마다 동작하는 코드
                    # 초당 프레임간 발생한 거리차이를 a, b에 누적시킴 
                    a = (int)(newbox[0]) - lastPoint.x
                    b = (int)(newbox[1]) - lastPoint.y
                    
                    moving_weight=math.sqrt(math.pow(a,2) + math.pow(b,2)) # 초당 움직인 거리(즉 속도) - 유클리디안 거리측정 사용
                    
                    # 트레커 추적중 발생하는 진동을 최소화하기위한 코드
                    if(moving_weight < 2) :
                        moving_weight=0
                    
                    estimate_distance = estimate_distance + moving_weight   # 추정거리값을 누적시킴
                    
                    distance = 8 * estimate_distance / 100      # 추정거리에서 도출된 값에 가중치를 두고 m단위로 변환 
                    distance = round(distance,2)                # 반올림 처리           
                    speed = (8 * moving_weight / 100)*3.6       # moving_weight를 통해 구해진 m/s에 3.6을 곱해 속도를 k/h로 바꿔줌
                    speed = round(speed,2)
                    
                    if(speed > top_speed) :                     # 최고속도를 top_speed에 저장
                        top_speed = speed
                    
                    accumulate_speed = accumulate_speed+speed   # 속도값들을 전부 누적시킴

                    lastPoint = Point(x = int(newbox[0]), y = int(newbox[1]))   # 과거 좌표 갱신
                    
                    #txt 로그로 남겨주는 부분
                    f.write( 'Player '+str(i)+' x,y: '+str(int(newbox[0]))+','+str(int(newbox[1])) + '\n' )        #save location coords for future use

                
                if((frame_cnt % (fps*10))==0) :     # 프레임기반 10초(fps)마다 동작하는 코드
                    if(frame_cnt==0) : 
                        heatmap_filename = 'heatmap_0secs.png'
                    else :
                        heatmap_filename = 'heatmap_'+str(frame_cnt / (fps*10)*10)+'secs.png'

                    cv2.imwrite(heatmap_filename, heatmap_background, [cv2.IMWRITE_PNG_COMPRESSION, 0])

                        # 10초마다 DB로 전송할 부분
                        ##########################################################################################
                        # heatmap_filename = 10초마다 찍은 png 파일명
                        ##########################################################################################
                    

                if((frame_cnt % (fps*30))==0) :     # 프레임기반 30초(fps)마다 동작하는 코드
                    section_distance = distance - temp_distance
                    temp_distance = distance
                     # 30초마다 DB로 전송할 부분
                     ##########################################################################################
                     # section_distance = 30초마다 뛴 거리

                     ##########################################################################################

                frame_cnt=frame_cnt+1   # 프레임 갯수를 세어줌
                
                # print('거리 추정치 : ', distance, ' / 속도 추정치 : ',speed,' km/h')
                
                # 누적 거리값을 레이더의 플레이어 머리위에 띄워줌
                cv2.putText(radar, str(speed)+'km/h '+str(distance)+'m', (int(newbox[0]-60), int(newbox[1])-20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window
                
                

        # show all windows
        cv2.imshow('MultiTracker', frame)
        cv2.imshow('fgMask', fgMask)
        cv2.imshow('HeatMap',heatmap_background)
        cv2.imshow('Radar',radar)
        
        # quit on ESC button
        if cv2.waitKey(1) & 0xFF == 27:  #incase Esc is pressed
            break
    
    avg_speed = accumulate_speed / (frame_cnt/fps)
    avg_speed = round(avg_speed,1)

    print('총 뛴 거리 : ', distance,'m')
    print('최고 속도 : ', top_speed,'km/h')
    print('평균 속도 : ', avg_speed,'km/h')

    # 최종 데이터를 DB로 전송할 부분
    ##########################################################################################
    # distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
    ##########################################################################################

#######################################################################################################
#                                           PyMySQL문법                                               #
#######################################################################################################
# MySQL 문법 나중에 distance부분에 NOT NULL 추가해주면 좋음 아직 미구현 상태인거 같아서 필드만 만들어 놓음

sql = """
CREATE TABLE IF NOT EXISTS {0} (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    avgSpeed DECIMAL(10,2),
    maxSpeed DECIMAL(10,2),
    distance_5 DECIMAL(10,2),
    distance_10 DECIMAL(10,2),
    distance_15 DECIMAL(10,2),
    distance_20 DECIMAL(10,2),
    totalDistance DECIMAL(10,2),
    PRIMARY KEY(id)
    );
""".format(player_information[0])

insert_data="""
INSERT INTO {0} (avgSpeed, maxSpeed, totalDistance)
VALUES ({1},{2},{3})
;""".format(player_information[0],avg_speed, top_speed, distance)

# INSERT INTO {0} (avgSpeed, maxSpeed, distance_5, distance_10, distance_15, distance_20, totalDistance) SQL문법 나중에 적용

try:
    cursor.execute(sql)
    cursor.execute(insert_data)
    connect.commit()
except:
    connect.rollback()

connect.close()

# 최종 데이터를 DB로 전송할 부분
##########################################################################################
# distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
##########################################################################################

f.close()




# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도
