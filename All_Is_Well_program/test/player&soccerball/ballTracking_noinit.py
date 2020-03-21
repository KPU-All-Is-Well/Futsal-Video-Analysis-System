# 색깔과 공 크기 하드코딩 안 하도록 

import cv2
import numpy as np
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
import collections


#videoPath = 'yellowBall.mp4'   # 비디오를 읽어옴
videoPath = 'near_2.mov'   # 비디오를 읽어옴
#videoPath = 'full.mp4'   # 비디오를 읽어옴

# Create a video capture object to read videos 
cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길

frame_cnt =0
black = 106
white = 213

str_coord = ''
check = True
ball_x=ball_y=-1
file = open( 'ball_coord.txt', 'w' )  # 좌표값을 저장할 파일


#213, 192



while(1):
        
    success, frame = cap.read()
    if not success:
            break
    frame = imutils.resize(frame, width=1000) # 리사이징
     
    if(frame_cnt == 0) :
        height = frame.shape[0] # 세로 
        width = frame.shape[1] # 가로
    
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    #print(frame.shape) # 가로 = 1000, 세로= 571 
    
    
    if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3) is not None):
        circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3)
    
    if(circles is None):
        str_coord = str_coord+'\n'
    else:
        for c in circles[0,:]:
            x = int(c[0])
            y = int(c[1])
            
            # 공인식 부분(제약사항: 흰색이나 검은색 공만 아니면 됨)
            if(white > frame[y][x][0] > black)  and (frame[y][x][1] > 225)  and (height*0.1 < y < height*0.9) and (width*0.05 < x < width*0.95):     
                # 정수리 검은색 원과 축구장 바닥 흰색 원 배제(색기반), 경기장 밖 배제(가로 15%, 세로 5%)
                
                       
                print('r = ',c[2], '       frame_cnt = ', frame_cnt, '          ',' x = ', x,'      y = ', y,'    ', (frame[y][x][0]), (frame[y][x][1]), (frame[y][x][2]))                          
                
            
                cv2.circle(frame, (c[0], c[1]), c[2], (0, 0, 255), 5)
                cv2.circle(gray, (c[0], c[1]), c[2], (0, 0, 255), 5)
                ball_x = x
                ball_y = y
                check = True
        if(check) :                 
            str_coord = str_coord+str(frame_cnt)+','+str(ball_x)+','+str(ball_y)+'\n'  # str_coord 스트링에 좌표값을 누적시킴
        else :
            str_coord = str_coord+'\n'


    cv2.imshow('frame',frame)
    cv2.imshow('gray',gray)
    
    if frame_cnt == 0 : # 첫 프레임인 경우
        cv2.waitKey(0)
 

    frame_cnt = frame_cnt+1

    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break
        
file.write(str_coord)
file.close()

cv2.destroyAllWindows()