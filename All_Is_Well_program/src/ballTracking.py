# 색깔과 공 크기 하드코딩 안 하도록 

import cv2
import numpy as np
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
import collections
import math

# 테스트 영상들
videoPath = '../sample_videos/YEONSU_44s.avi'   # 연수체육관에서 찍은 영상
#videoPath = 'TEST.mov'   # 3차 데모에서 사용한 영상
                           # 학교 풋살장에서 찍은 영상

# Create a video capture object to read videos 
cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길

pre_frame_cnt = 0
frame_cnt =0
succes_rate = 0 # test
black = 106
white = 213

str_coord = ''
check = True
ball_x=ball_y=0
file = open( '../result/ball_coord.txt', 'w' )  # 좌표값을 저장할 파일



def get_circle_dist(a, b) :

    return math.sqrt(math.pow(b[0]-a[0], 2)+math.pow(b[1]-a[1], 2))


while(1):
        
    success, frame = cap.read()
    if not success:
            break
            
    frame = imutils.resize(frame, width=1000) # 리사이징  
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    height = frame.shape[0] # 세로    
    width = frame.shape[1] # 가로
    
    #print(height, '\n') # test
    
    # 공 크기 2.4
    if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3) is not None):
        circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3)
    
    if(circles is None):
        str_coord = str_coord+'\n'
    else:
    
        ###################################for문 시작############################################
        # 한 프레임에서의 공 후보들 리스트에 담기 
        circle_dist = 0
        circles_list = [] # 검출된 원들 list  ex) list = [(c1, True), (c2, False)]
        circle_cnt = 0 # 후보 공들 개수 카운팅
        exception = False
        
        for c in circles[0,:]: 
            
            # 현재 원의 좌표
            x = int(c[0]) 
            y = int(c[1])
            
            
            # 흰색 라인 밖 왼쪽 하단 공 제외  
            if( 481 <= y <= 486 and 1 <=x <= 13) : # 연수체육관에서 찍은 영상에만 해당 
                exception = True
            
            #if( y >= 510) : # 데모에서 찍은 영상에만 해당 
            #    exception = True
            
                
            # 검은색 정수리 제외(제약 사항: 검은 공 사용 금지)
            if(frame[y][x][0] > black and exception == False) :  
                
                #패널티 마크 위치 제외
                penalty_mark = False  
                if (height*0.5 - 10 <= y <= height*0.5 + 7 ) :
                    if (width*0.25 -35 <= x <= width*0.25 + 35) or (width*0.5 -35 <= x <= width*0.5 + 35) or (width*0.75 -35 <= x <= width*0.75 + 35) : 
                        penalty_mark = True
                        
                if penalty_mark == False : 
                
                    # 1번째 프레임
                    if (frame_cnt == 0) : 
                        ball_x = x
                        ball_y = y
                        r = c[2] 
                        circle_cnt += 1
                        
                    # 2번째 프레임부터
                    if (frame_cnt != 0) : 
                        # 전 프레임에서 인식한 공 좌표와 현재 공 후보인 원과의 거리 차이 계산 -> 튜플로 저장
                        make_tuple = ball_x, ball_y
                        make_tuple2 = x, y
                        circle_dist = get_circle_dist(make_tuple, make_tuple2)
                        tupleForCircle = (c, circle_dist) 
                        circles_list.append(tupleForCircle)
                        circle_cnt += 1 # 공의 후보 개수 카운팅               
        ########################################for문 끝#######################################
        
        
        # 후보 공이 2개 이상인 프레임만 
        if (frame_cnt != 0 and circle_cnt >= 2) :
            
            min_dist = circles_list[0][1] # ex) circles_list = [((1, 2, 0.4), 30), ((2, 2, 0.4), 20)]
            min_idx = 0 
            # 전 프레임에서 검출된 원과 최소 거리의 원 찾기
            for i in range(0, circle_cnt) :
                print(circle_cnt, ' ', i)  # Test
                print( circles_list[i][1], '\n')  # Test
                if circles_list[i][1]  < min_dist :
                    min_dist = circles_list[i][1]
                    min_idx = i
                
                        
            # 공의 좌표 저장
            ball_x = int(circles_list[min_idx][0][0])
            ball_y = int(circles_list[min_idx][0][1])
            print(circles_list[min_idx][1], '\n')  # Test 
            #r = circles_list[min_idx][0][2]
            minD = int(circles_list[min_idx][1])
            check = True
            
            
            
            
        
        # 후보 공이 1개인 프레임만
        elif (circle_cnt == 1) : 
            check = True
            
            # 공의 좌표 저장
            if( frame_cnt != 0) :
                ball_x = int(circles_list[0][0][0])
                ball_y = int(circles_list[0][0][1])
              

        # 후보 공이 0개인 프레임만 
        elif (circle_cnt == 0) :
            check = False
            
            # 첫 프레임
            if(frame_cnt == 0) : 
                str_coord = str_coord+str(ball_y)+','+str(ball_x)+','+str(frame_cnt)+'\n'
                pre_frame_cnt = frame_cnt
            # 두번째 프레임부터
            else :
                #str_coord = str_coord+'\n' 
                str_coord = str_coord+str(ball_y)+','+str(ball_x)+','+str(pre_frame_cnt)+'\n' # 전 좌표 저장
            
       
       
        
        # 화면에 출력 및 좌표 저장
        if(check) :                 
            print('r = ', r, '     frame_cnt = ', frame_cnt, '          ',' x = ', ball_x,'      y = ', ball_y,'    ', (frame[ball_y][ball_x][0]), (frame[ball_y][ball_x][1]), (frame[ball_y][ball_x][2]))                          
            str_coord = str_coord+str(ball_y)+','+str(ball_x)+','+str(frame_cnt)+'\n'  # str_coord 스트링에 좌표값을 누적시킴
            pre_frame_cnt = frame_cnt
            
            cv2.circle(frame, (ball_x, ball_y), 7, (0, 0, 255), 2)
            cv2.circle(gray, (ball_x, ball_y), 7, (0, 0, 255), 2)
            succes_rate+= 1 #test
        


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

print(succes_rate, '\n') #test

cv2.destroyAllWindows()