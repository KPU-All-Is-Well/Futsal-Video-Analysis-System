# 색깔과 공 크기 하드코딩 안 하도록 

import cv2
import numpy as np
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리
import collections
import math

#videoPath = 'yellowBall.mp4'   # 비디오를 읽어옴
videoPath = '../sample_videos/TEST.mov'   # 비디오를 읽어옴
#videoPath = 'full.mp4'   # 비디오를 읽어옴

# Create a video capture object to read videos 
cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길

frame_cnt =0
pre_frame_cnt =0 # 목적: 공이 인식된 현 프레임과 이전 프레임의 '차'를 계산
ball_frame_cnt = 0 # 공을 인식한 프레임만 저장
black = 106
white = 233
# 207

str_coord = ''
ball_x=ball_y=-1
file = open( '../result/ball_coord_TEST.txt', 'w' )  # 좌표값을 저장할 파일


#213, 192

def get_circle_dist(a, b) :

    return math.sqrt(math.pow(b[0]-a[0], 2)+math.pow(b[1]-a[1], 2))


while(1):
        
    success, frame = cap.read()
    if not success:
            break
    frame = imutils.resize(frame, width=1000) # 리사이징
     
    if(frame_cnt == 0) :
        height = frame.shape[0] # 세로 
        width = frame.shape[1] # 가로
    
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    #print(frame.shape) # 가로 = 1000, 세로= 552
    
    
    if(cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3) is not None):
        circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, 5, param1=200, param2=10, minRadius=2,maxRadius=3)
    
    # past_ball_x 
    
    if(circles is not None):
        
        circle_dist = 0
        circles_list = [] # 검출된 원들 list  ex) list = [(c1, True), (c2, False)]
        cnt = 0 # 후보 공들 개수 카운팅
        
        ######################################################## 공인 것과 공이 아닌 것 구별하는 알고리즘 ###########################################################
        
        # 한 프레임에서 검출해낸 circle들 공인지 아닌지 true, false 판별하면서 circles_list에 담기 
        for c in circles[0,:]: 
            x = int(c[0])
            y = int(c[1])
   
            
            # ① 패널티 마크 제외(공과 비슷한 색깔이여서 공으로 인식함) 
            if (100<y<103) or (273 < y < 281) : # 패널티 마크 위치 y좌표 
                isBall_1 = False
            else :
                isBall_1 = True
            
            
            # ② 정수리 검은색 원과 축구장 바닥 흰색 원 배제(색기반), 경기장 밖 배제(가로 15%, 세로 5%)
            if(white > frame[y][x][0] > black) and (frame[y][x][1] > 209) and (height*0.1 < y < height*0.9) and (width*0.05 < x < width*0.95) :         
                isBall_2 = True
            else :
                isBall_2 = False
            

            
            # ③-⑴ 전 프레임에서 공 좌표와 현재 공 후보인 원과의 거리 차이 계산 -> 튜플로 저장
            if (frame_cnt != 0) : # 두 번째 프레임 부터 
                make_tuple = ball_x, ball_y
                make_tuple2 = x, y
                circle_dist = get_circle_dist(make_tuple, make_tuple2)
                
                #print(circle_dist) # test
            
            # 높은 확률의 공 후보들 cricles_list에 추가
            if (isBall_1 == True) and (isBall_2 == True) : 
                cnt += 1 # 공의 후보 개수 카운팅
                
                if frame_cnt == 0 : # 첫 번째 프레임은 공 출력(가정: 첫 프레임은 공을 제대로 잡음)
                    
                    print('첫 프레임 r = ',c[2], '       frame_cnt = ', frame_cnt, '          ',' x = ', x,'      y = ', y,'    ', (frame[y][x][0]), (frame[y][x][1]), (frame[y][x][2]))                          
                    
                    ball_x = x
                    ball_y = y
                    
                    cv2.circle(frame, (ball_x, ball_y), 8, (0, 0, 255), 2)
                    cv2.circle(gray, (ball_x, ball_y), 8, (0, 0, 255), 2)
                    ball_frame_cnt = frame_cnt
                   
                    
                else : # 두 번째 프레임부터
                    tupleForCircle = (c, circle_dist) # 원의 중심좌표와 이전 좌표와의 거리 (가정: 이전 좌표는 확실하게 공)
                    circles_list.append(tupleForCircle)
               
            
            
        ###################################################################################################################################################          
            
            
        # 축구공인 경우만 화면에 출력 (거리차가 가장 적은 원)
        if cnt >= 1: # 공 후보 개수가 1개 이상인 경우(한 프레임에서 공 후보가 0개인 경우 존재)
        
            min_dist = circles_list[0][1] # ex) circles_list = [((1, 2, 0.4), 30), ((2, 2, 0.4), 20)]
            i = 1
            minIdx = 0
            
            if (frame_cnt != 0) : # 2번째 프레임부터
       
                while(1):
                    ##################### 후보가 한 개만 있을 경우 (circles_list에 원소 1개만 들어있는 경우)
                    if cnt == 1 : # cnt == 1
                        
                        
                        
                        make_tuple = ball_x, ball_y
                        make_tuple2 = circles_list[0][0][0], circles_list[0][0][1]
                        circle_dist = int(get_circle_dist(make_tuple, make_tuple2))
                        
                       
                        
                        # ③-⑵ # 그 전프레임에서 공의 위치와의 거리차이로 후보들 중 진짜 공 가려내기(너무 크다면 공이 아님..)
                        
                        isBall_3 = True
                        if circle_dist >= 155 or circle_dist == 74  :  #circle_dist >= 155 or
                            isBall_3 = False
                        
                        if circle_dist == 188 or circle_dist == 189 or circle_dist == 228: # 예외
                            #if circles_list[0][0][0] == 674 and circles_list[0][0][1] == 294 and circle_dist == 188:  # 예외
                            #    print("ok")
                            #    isBall_3 = False 
                            
                            isBall_3 = True
                        
                            
                        if circles_list[0][0][0] == 901 and circles_list[0][0][1] == 268 :  # 예외(골기퍼 머리)
                            isBall_3 = False 
                            
                                  
                            
                        # 최종적으로 '공'이라고 판정된 경우
                        if isBall_3 == True : 
                            ball_x = int(circles_list[0][0][0])
                            ball_y = int(circles_list[0][0][1])
                            
                            #################################골 인식 알고리즘 나중에 주석 처리 할 것임######################################################################################################################################                          
                            
                           
                            if ball_x >= width * 0.9 : # '골 에어리어'에 공이 진입한 경우 초록색으로 표시 (가로 1000일 경우: 100이하, 900이상)
                            
                            
                                isInGoalNet = False 
                                invisible = frame_cnt - pre_frame_cnt
                                fps = cap.get(cv2.CAP_PROP_FPS)
                                
                                if invisible > fps :# '골 에어리어' 영역에서 영상의 '프레임률(fps)' 이상 보이지 않는다면 공은 골 안에 있음 
                                    isInGoalNet = True 
                                  
                           
                                
                                if isInGoalNet == True  :  # '골'인 경우 노란색으로 표시        #if ball_x == 947 and ball_y ==289 :
                                    print('!!!!골인입니다!!!!! 후보 1개 r = ', circles_list[0][0][2], '       frame_cnt = ', frame_cnt, '          ',' x = ', ball_x,'      y = ', ball_y, '    dist 차이  ', circle_dist)
                                    print('invisible term: ', invisible)
                                    
                                    cv2.circle(frame, (ball_x, ball_y), 8, (0, 228, 255), 2) # 노란색으로 표시
                                    cv2.circle(gray, (ball_x, ball_y), 8, (0, 0, 255), 2)
                                    pre_frame_cnt = frame_cnt
                                    ball_frame_cnt = frame_cnt
                                else :
                                    print("골에어리어에 공이 진입했습니다.")
                                    print('후보 1개 r = ', circles_list[0][0][2], '       frame_cnt = ', frame_cnt, '          ',' x = ', ball_x,'      y = ', ball_y, '    dist 차이  ', circle_dist)
                           
                                    cv2.circle(frame, (ball_x, ball_y), 8, (22, 219, 29), 2) # 초록색으로 표시
                                    cv2.circle(gray, (ball_x, ball_y), 8, (0, 0, 255), 2)  
                                    pre_frame_cnt = frame_cnt
                                    ball_frame_cnt = frame_cnt
                                
                                

                            
  #########################################################################################################################################################################################################
                            
                            
                            else: # 골이 아닌 경우
                            
                                print('후보 1개 r = ', circles_list[0][0][2], '       frame_cnt = ', frame_cnt, '          ',' x = ', ball_x,'      y = ', ball_y, '    dist 차이  ', circle_dist)
                        
                                cv2.circle(frame, (ball_x, ball_y), 8, (0, 0, 255), 2)
                                cv2.circle(gray, (ball_x, ball_y), 8, (0, 0, 255), 2)
                                pre_frame_cnt = frame_cnt
                                ball_frame_cnt = frame_cnt
                        
                        
                        break;
                
                    ############################# 후보가 2개 이상인 경우 #############################
                    if circles_list[i][1]  < min_dist :
                        print('이전 최소 거리  ', min_dist)
                        min_dist = circles_list[i][1]
                        minIdx = i
                        print('갱신된 최소 거리  ', min_dist)
                        
               
                    if i +1 == len(circles_list):
                       
                        
                        real_x = int(circles_list[minIdx][0][0])
                        real_y = int(circles_list[minIdx][0][1])
                        r = circles_list[minIdx][0][2]
                        minD = int(circles_list[minIdx][1])
                        
                       
                        
                        isBall = True
                        if minD == 117 : 
                            isBall = False
                        
                        if isBall == True :
                        
                            print('후보들 중 r = ', r, '       frame_cnt = ', frame_cnt, '          ',' x = ', real_x,'      y = ', real_y,'    ', (frame[real_y][real_x][0]), (frame[real_y][real_x][1]), (frame[real_y][real_x][2]), '갱신된 최소 거리  ', minD)                          
                              
                            ball_x = real_x
                            ball_y = real_y
                        
                            cv2.circle(frame, (ball_x, ball_y), 8, (0, 0, 255), 2)
                            cv2.circle(gray, (ball_x, ball_y), 8, (0, 0, 255), 2)
                            pre_frame_cnt = frame_cnt
                            ball_frame_cnt = frame_cnt
                        
                
                        break     
    
                    i += 1
            
    #str_coord = str_coord+str(ball_y)+','+str(ball_x)+'\n'  # str_coord 스트링에 좌표값을 누적시킴
    str_coord = str_coord+str(ball_y)+','+str(ball_x)+','+str(ball_frame_cnt)+'\n'  # str_coord 스트링에 좌표값을 누적시킴
    
    cv2.imshow('frame',frame)
    cv2.imshow('gray',gray)
    
    #if frame_cnt == 0 : # 첫 프레임인 경우
    #    cv2.waitKey(0)     # 화면 정지하고 키 입력을 기다리도록 
 

    frame_cnt = frame_cnt+1

    k = cv2.waitKey(5) & 0xFF # esc 입력하면 창 꺼지게 
    if k == 27: 
        break
        
file.write(str_coord)
file.close()

cv2.destroyAllWindows()