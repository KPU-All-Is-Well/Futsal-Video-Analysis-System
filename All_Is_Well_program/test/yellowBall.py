import cv2
import numpy as np
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
import collections


videoPath = 'yellowBall.mp4'   # 비디오를 읽어옴
 
# Create a video capture object to read videos 
cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길

frame_cnt =0
Point = collections.namedtuple('Point',['x','y'])
lastPoint = Point(x=-1, y=-1)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
currentPoint = Point(x=-1, y=-1)   # 현재의 좌표값을 저장할 튜플, -1로 초기화
black = 100
white = 220

while(1):
        
    _, frame = cap.read()
    frame = imutils.resize(frame, width=1000) # 리사이징
     
    if(frame_cnt == 0) :
        height = frame.shape[0] # 세로 
        width = frame.shape[1] # 가로
    
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    #print(frame.shape) # 가로 = 1000, 세로= 571 
    
    
    if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=3) is not None):
        circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=1,maxRadius=3)[0]
    
    
    if(circles is not None):
        for c in circles:
            x = int(c[0])
            y = int(c[1])
            currentPoint = Point(x = int(c[0]), y = int(c[1]))
            
            # 공인식 부분
            if(white > frame[y][x][0] > black) and (height*0.15 < y < height*0.85) and (width*0.05 < x < width*0.95):     
                # 정수리 검은색 원과 축구장 바닥 흰색 원 배제(색기반), 경기장 밖 배제(가로 15%, 세로 5%)
                       
                print('r = ',c[2], '       frame_cnt = ', frame_cnt, '          ',' x = ', x,'      y = ', y,'    ', (frame[y][x][0]))                          
                
                cv2.circle(frame, (c[0], c[1]), c[2], (0, 0, 255), 2)
                cv2.circle(gray, (c[0], c[1]), c[2], (0, 0, 255), 2)
                
                

  

    cv2.imshow('frame',frame)
    cv2.imshow('gray',gray)

    #cv2.imshow('mask',mask)
    #cv2.imshow('res',res)

    frame_cnt = frame_cnt+1

    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()