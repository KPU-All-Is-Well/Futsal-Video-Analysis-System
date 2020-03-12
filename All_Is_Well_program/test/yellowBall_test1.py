# 색깔과 공 크기 하드코딩 안 하도록 

import cv2
import numpy as np
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
import collections


videoPath = 'yellowBall_cut.mp4'   # 비디오를 읽어옴
 
# Create a video capture object to read videos 
cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길

frame_cnt =0
Point = collections.namedtuple('Point',['x','y'])
#lastPoint = Point(x=-1, y=-1)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
#currentPoint = Point(x=-1, y=-1)   # 현재의 좌표값을 저장할 튜플, -1로 초기화
black = 100
white = 220
initial_radius = 0


while(1):
        
    _, frame = cap.read()
    frame = imutils.resize(frame, width=1000) # 리사이징
     
    if(frame_cnt == 0) :
        height = frame.shape[0] # 세로 
        width = frame.shape[1] # 가로
    
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    #print(frame.shape) # 가로 = 1000, 세로= 571 
        
    
    if (frame_cnt == 0) : #첫 프레임일 경우
    
        if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=10) is not None): 
            circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=10) # 한 프레임에서 찾은 원들이 circles에 담겨짐
        
       
   
        for c in circles[0,:]:
            x = int(c[0])
            y = int(c[1])
            
            if(white > frame[y][x][0] > black) and (height*0.15 < y < height*0.85) and (width*0.07 < x < width*0.93):     
                # 정수리 검은색 원과 축구장 바닥 흰색 원 배제(색기반), 경기장 밖 배제(가로 15%, 세로 5%)
                
                       
                print('r = ',c[2], '       frame_cnt = ', frame_cnt, '          ',' x = ', x,'      y = ', y,'    ', (frame[y][x][0]))                          
                
                cv2.circle(frame, (c[0], c[1]), c[2], (0, 0, 255), 2)
                cv2.circle(gray, (c[0], c[1]), c[2], (0, 0, 255), 2)
                
                initial_radius = c[2]
            
            # 첫 번째 프레임에서 읽은 원들 중 가장 작은 값을 공으로 인식            
            if initial_radius > c[2] :
                initial_radius = c[2]
        
        
        print('initial_radius= ', initial_radius)
     
    elif (frame_cnt > 0): # 두 번째 프레임부터
    
        if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=(int)(initial_radius-1),maxRadius=(int)(initial_radius+1)) is not None): 
            circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=(int)(initial_radius-1),maxRadius=(int)(initial_radius+1)) # 한 프레임에서 찾은 원들이 circles에 담겨짐
        
        #if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=3) is not None): 
        #    circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=3) # 한 프레임에서 찾은 원들이 circles에 담겨짐
        
        if(circles is not None):
            for c in circles[0,:]:
                x = int(c[0])
                y = int(c[1])
                #currentPoint = Point(x = int(c[0]), y = int(c[1]))
            
                # 공인식 부분(제약사항: 흰색이나 검은색 공만 아니면 됨)
                if(white > frame[y][x][0] > black) and (height*0.15 < y < height*0.85) and (width*0.05 < x < width*0.95):     
                    # 정수리 검은색 원과 축구장 바닥 흰색 원 배제(색기반), 경기장 밖 배제(가로 15%, 세로 5%)
                
                       
                    print('r = ',c[2], '       frame_cnt = ', frame_cnt, '          ',' x = ', x,'      y = ', y,'    ', (frame[y][x][0]))                          
                
                    cv2.circle(frame, (c[0], c[1]), c[2], (0, 0, 255), 2)
                    cv2.circle(gray, (c[0], c[1]), c[2], (0, 0, 255), 2)
  

    cv2.imshow('frame',frame)
    cv2.imshow('gray',gray)

    frame_cnt = frame_cnt+1

    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()