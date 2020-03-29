from __future__ import print_function    # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                        # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                                # 오픈cv 열기
import os                                # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                                # 환경변수같은 인수를 입력받는 모듈
import random                            # 난수 생성할때 사용하는 모듈
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
# import pycuda
import math
import collections
import time

# 히트맵에 각기 다른 색상을 표현하기 위한 튜플로 된 리스트  12개를 정의
colors12 = [(0,0,0),(255,255,255),(255,0,0),(0,255,0),(0,0,255),(255,255,0),(0,255,255),(255,0,255),(192,192,192),(244,164,96),(128,128,0),(240, 50, 230)]

if __name__ == '__main__':

    start = time.time()
    
    tracker = cv2.TrackerCSRT_create()  # CSRT tracker 초기화
    videoPath = 'near_2.mov'   # 비디오를 읽어옴
 
    # Create a video capture object to read videos 
    cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길
    
    # Set video to load
    success, frame = cap.read()
    
    fps = cap.get(cv2.CAP_PROP_FPS)
    fps = round(fps,0)

    frame = imutils.resize(frame, width=1000) # 리사이징    


    # hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # lower_white = np.array([0,20,185], dtype=np.uint8)
    # upper_white = np.array([179,110,255], dtype=np.uint8)

    # # Threshold the HSV image to get only white colors
    # mask = cv2.inRange(hsv, lower_white, upper_white)
    # # Bitwise-AND mask and original image
    # res = cv2.bitwise_and(frame,frame, mask= mask)


    
    # 영상 읽기에 실패 예외처리
    if not success:
        print('Failed to read video')
        sys.exit(1)

    ## Select boxes 빈 리스트 선언
    bboxes = []
    colors = [] 
    p=0
    # OpenCV의 selectROI 함수는 다중 객체 선택을 지원하지 않으므로 반복문을 통해 다중 ROI 지정을 구현
    while True:
        
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
    #첫 좌표 (x,y, x+, y+)



    # Create MultiTracker object
    multiTracker = cv2.MultiTracker_create()

    

    # Initialize MultiTracker 
    for bbox in bboxes:
        multiTracker.add(tracker, frame, bbox)
        # multiTracker.add(tracker, fgMask, bbox)


    # Process video and track objects
    while cap.isOpened():#비디오가 잘 열렸는지 확인하는 함수-길
        success, frame = cap.read()# cap.read() 는 동영상을 1프레임씩 읽어오는 것-길

        if not success:
            break

        frame = imutils.resize(frame, width=1000) # 리사이징

        # hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

        # #kpufutsal3.mov
        # lower_white = np.array([0,45,100], dtype=np.uint8)
        # upper_white = np.array([179,140,255], dtype=np.uint8)

        # # Threshold the HSV image to get only white colors
        # mask = cv2.inRange(hsv, lower_white, upper_white)
        # # Bitwise-AND mask and original image
        # res = cv2.bitwise_and(frame,frame, mask= mask)


        # get updated location of objects in subsequent frames
        # success, boxes = multiTracker.update(frame)  #update() 따라가게 만드는 함수 - 길
        success, boxes = multiTracker.update(frame)
        
        # draw tracked objects
        for i, newbox in enumerate(boxes):
            p1 = (int(newbox[0]), int(newbox[1]))
            p2 = (int(newbox[0] + newbox[2]), int(newbox[1] + newbox[3]))
            cv2.rectangle(frame, p1, p2, colors[i], 2, 1)
                        # rectangle(): 직사각형을 그리는 함수-길
                        #파라미터 (이미지, 왼쪽 위 좌표, 오른쪽 아래 좌표, 사각형 색깔, 사각형의 두께, ?? ) -길
        
                    

        # show all windows
        cv2.imshow('MultiTracker', frame)
        
        #cv2.imshow('frame',frame)
        #cv2.imshow('mask',mask)
        #cv2.imshow('res',res)
        
        # quit on ESC button
        if cv2.waitKey(1) & 0xFF == 27:  #incase Esc is pressed
            cv2.destroyAllWindows() # 화면 종료해주기
            break
    print("time : ", time.time() - start)
    

    # 최종 데이터를 DB로 전송할 부분
    ##########################################################################################
    # distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
    # walk_weight = 걷기 비중, jog_weight = 조깅 비중, sprint_weight = 스프린트 비중
    # cal = 소모 칼로리
    # result_heatmap.png = 최종 히트맵 파일명
    ##########################################################################################
    
    





#v2.2 5분동안 뛴 속력 측정, 걸음/조깅/스프린트 비중 측정, 칼로리 측정 기능 추가


# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도


# 30초마다 평균속도, 최종 히트맵, 칼로리, 비율 추가해야함
