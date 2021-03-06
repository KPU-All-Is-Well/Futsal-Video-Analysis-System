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
import heatmap
from datetime import datetime
from PIL import ImageFont, ImageDraw, Image
from moviepy.editor import *                                     # moviepy 라이브러리 :
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip # 하이라이트 영상 추출을 위해 구간 자르는 라이브러리 

# 히트맵에 각기 다른 색상을 표현하기 위한 튜플로 된 리스트  12개를 정의
colors12 = [(0,0,0),(255,255,255),(255,0,0),(0,255,0),(0,0,255),(255,255,0),(0,255,255),(255,0,255),(192,192,192),(244,164,96),(128,128,0),(240, 50, 230)]

# 각 팀 선수들이 전체 경기 중 공을 점유한 프레임 수 
ball_share_A = [] 
ball_share_B = []

# 팀 단위로 경기 동안 공을 점유한 프레임 수 
sum_ball_A = 0
sum_ball_B = 0


def selectMultiROI(player_cnt, team_cnt, team) :
    global p, bboxes, colors

    while True:
        
        print('Select the Player')
        
        cv2.putText(frame, str(team)+' Team  ', (50, 30), cv2.FONT_HERSHEY_COMPLEX, 1, (255,255,255), 2, cv2.LINE_AA) 
        cv2.putText(frame, ' Done: '+str(player_cnt-1)+' / Total: '+str(team_cnt),(45, 60), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,255,255), 1, cv2.LINE_AA)  
        #now = datetime.now()
        #curTime = now.strftime('%H:%M:%S')
        videoLen = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
        videoFps = cap.get(cv2.CAP_PROP_FPS)
        videoTime = int((videoLen / videoFps))  # 동영상 재생 시간을 초로 반환
        
        # 분석하는데 남은 에상 소요시간
        analTime = videoTime * (team_cnt-player_cnt+1)
        if analTime < 60 :
            minute = 0
            second = analTime
        else :
            minute = int(analTime / 60) # 분
            second = analTime % 60 # 초 
            
        cv2.putText(frame, ' Processing times: '+str(minute)+'m '+str(second)+'s',(45, 85), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,255,255), 1, cv2.LINE_AA)  
        
        #finishTime = 
        #cv2.putText(frame, ' current time: '+str(curTime),(45, 90), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,0,0), 1, cv2.LINE_AA)  #Multitracker_Window
        #cv2.putText(frame, ' estimated finish time: '+str(videoTime),(45, 120), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,0,0), 1, cv2.LINE_AA)  #Multitracker_Window
        
        # 0:0 -> 1:0

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
    return

def readBallCoord() : # ball_coord.txt 파일에서 공 좌표 읽어오는 함수 
    y, x, z = np.genfromtxt('ball_coord.txt', delimiter=',', unpack=True,dtype=int)
    return (x,y, z)



if __name__ == '__main__':
    
    
    ######################################################
    
    A = int(input('Home팀의 인원 입력 : '))
    B = int(input('Away팀의 인원 입력 : '))   
    
    # 6명 vs 6명으로 뛴다고 입력 받았을 경우
    total_player = A + B # 경기에 참여하는 플레이어 수가 12명인 경우
    flag = A
    ######################################################
     
    
    for player in range(1, total_player+1): # 선수 1부터 total_player까지 반복문
            
        tracker = cv2.TrackerCSRT_create()  # CSRT tracker 초기화
        #videoPath = 'near_2.mov'   # 비디오를 읽어옴
        videoPath = 'TEST.mp4'   # 비디오를 읽어옴
        
        # Create a video capture object to read videos 
        cap = cv2.VideoCapture(videoPath)  #비디오를 읽는 함수-길
    
        # Set video to load
        success, frame = cap.read()
        
        fps = cap.get(cv2.CAP_PROP_FPS)
        fps = round(fps,0)

        frame = imutils.resize(frame, width=1000) # 리사이징
        print(frame.shape)
        
        
         
        # backSub = cv2.createBackgroundSubtractorMOG2() # cv에서 제공하는 배경제거를 위한 마스크 초기화
        # backSub = cv2.bgsegm.createBackgroundSubtractorGMG() 사람이 흰점이 되지만 꽤 괜찮음

    
        heatmap_background = cv2.imread('heatmap2.png')    # 히트맵창의 배경 지정
        original = cv2.imread('heatmap2.png')

        player_file = open( 'player_coord.txt', 'w' )  # 좌표값을 저장할 파일
    
    
        # 영상 읽기에 실패 예외처리
        if not success:
            print('Failed to read video')
            sys.exit(1)

        ## Select boxes 빈 리스트 선언
        bboxes = []
        colors = [] 
        p=0
        # OpenCV의 selectROI 함수는 다중 객체 선택을 지원하지 않으므로 반복문을 통해 다중 ROI 지정을 구현
        # while True:
        
        #     fgMask = backSub.apply(frame)   # frame에 배경제거 mask를 적용시켜 이미지 생성

        #     print('Select the Player')

        #     # ?draw bounding boxes over objects
        #     # ?selectROI's default behaviour is to draw box starting from the center
        #     # ?when fromCenter is set to false, you can draw box starting from top left corner
        #     bbox = cv2.selectROI('MultiTracker', frame) #roi 를 선택하는 함수-길
        #                                                 #roi 정보가 bbox 에 저장되어 사용된다-길
        #                                                 #tracker.init(frame123, bbox) # 오브젝트 트래커가 frame123과 bboc를 따라가게끔 설정한다.
        #     bboxes.append(bbox)
        #     if (p<6):
        #         colors.append((0,0,255))
        #     else:
        #         colors.append((255,0,0))
        #     print("Press q to quit selecting boxes and start tracking")
        #     print("Press any other key to select next object : ", p)
        #     p=p+1
        #     k = cv2.waitKey(0) & 0xFF
        #     if (k == 113):  # q is pressed
        #         break
        # print('Selected bounding boxes {}'.format(bboxes))
        
        
        if player <= flag : 
            team_name = 'Home'
            player_num = player
            selectMultiROI(player_num, A, team_name);
        else :
            team_name = 'Away'
            player_num = player-flag
            selectMultiROI(player_num, B, team_name);



        # Create MultiTracker object
        multiTracker = cv2.MultiTracker_create()
    
        #좌표를 표현할 이름있는 튜플
        Point = collections.namedtuple('Point',['x','y'])
        lastPoint = Point(x=-1, y=-1)   # 과거의 좌표값을 저장할 튜플, -1로 초기화
        estimate_distance = 0           # 영상기반 추정거리값을 저장
        distance = 0                    # 거리값을 저장
        frame_cnt = 0                   # 프레임을 카운팅함
        show_goal_frame = 0             # 골인 경우 화면에 fps 프레임수 동안 "골인입니다" 표시하기 위해
        ball_frame_cnt = 0              # 공을 인식한 프레임을 따로 저장 
        pre_frame_cnt =0                # 목적: 공이 인식된 현 프레임과 이전 프레임의 '차'를 계산
        ball_touch = 0                  # roi로 선택한 선수가 공을 점유한 프레임 수(볼 터치 수)를 카운팅함 
        moving_weight = 0               # 움직인 거리의 비중을 저장
        top_speed = 0                   # 최고 속도를 저장
        accumulate_speed = 0            # 속도들의 누적값
        temp_distance = 0               # 뛴 거리를 임시저장
        temp_speed = 0                  # 뛴 속도를 임시저장
        interval = 30                   # 특정 시간(초)
        interval_distance = 0           # 특정 시간마다의 뛴거리
        interval_acc_speed = 0          # 특정 시간마다의 속도 누적값
        interval_avg_speed = 0          # 특정 시간마다의 평균속도
        str_coord = ''
        walk_cnt=0
        jog_cnt=0
        sprint_cnt = 0
        highlight_goal_point = 0        # 하이라이트 추출시 골인인 프레임을 중심으로 앞뒤로 6초동안 보여주기
        
        blue_ROI = False                # ROI 색이 파란색으로 바뀐 경우 -> True
        red_ROI_cnt = 0                 # roi가 파란색에서 빨간색으로 바뀐 경우 빨간색을 유지하는 프레임 수를 카운팅함
        is_pass = False                 # roi 파 -> 빨 바뀌는 경우(1): 패스인 경우 
        is_dribble = False              # roi 파 -> 빨 바뀌는 경우(2): 선수가 드리블하는 중인 경우 
        pass_count = 0                  # 선수의 패스 횟수 실시간 카운팅
        
        
        coord_head=coord_tail= Point(x=0,y=0)
    
        ball_x,ball_y,ball_frame_cnt = readBallCoord() # 공의 좌표, 공이 인식된 프레임 읽어오기

        # Initialize MultiTracker 
        for bbox in bboxes:
            multiTracker.add(tracker, frame, bbox)
            # multiTracker.add(tracker, fgMask, bbox)

        
        ###################################################################################################################################################    
        ###################################################################영상을 열음#########################################################################
        
        while cap.isOpened():#비디오가 잘 열렸는지 확인하는 함수-길
            success, frame = cap.read()# cap.read() 는 동영상을 1프레임씩 읽어오는 것-길

            if not success:
                break

            frame = imutils.resize(frame, width=1000) # 리사이징
        
            #fgMask = backSub.apply(frame)   # 프레임에 마스크를 적용시켜 그레이스케일로 만들어줌


            # get updated location of objects in subsequent frames
            # success, boxes = multiTracker.update(frame)  #update() 따라가게 만드는 함수 - 길
            success, boxes = multiTracker.update(frame)
        
            if(frame_cnt==0) :  # 코드 속도개선을 위해 중복되는 코드는 한번만 수행되도록함
                height,width ,channels = frame.shape  #maintain all tabs in same shape
                heatmap_background = cv2.resize(heatmap_background,(width,height))
                original = cv2.resize(original,(width,height))
            radar = original.copy()        
        
            # draw tracked objects
            for i, newbox in enumerate(boxes):
            
                p1 = (int(newbox[0]), int(newbox[1]))
                p2 = (int(newbox[0] + newbox[2]), int(newbox[1] + newbox[3]))
                
              
                ################################################### 공 점유율 계산 알고리즘 ########################################################
                
                # 예외처리 (사람이 경기장 끝으로 갔을 경우 -> out of index error 발생)
                player_x1 = p1[0]-10 
                player_x2 = p2[0]+10
                player_y1= p1[1]-10 
                player_y2= p2[1]+10
                
                if player_x1 < 0 :
                    player_x1 = 0 
                if player_x2 > frame.shape[1] :  # 가로 길이를 초과할 경우 
                    player_x2 = frame.shape[1]
                
                if player_y1 < 0 :
                    player_y1 = 0 
                if player_y2 > frame.shape[0] :  # 세로 길이를 초과할 경우
                    player_y2 = frame.shape[0]
                
                
                # 공 점유 인식 (공이 선수 roi 박스 안으로 들어올 경우지정해준 선수와 가까이 있을 경우)
                # roi 파란색
                if( player_x1 <ball_x[frame_cnt]< player_x2 and player_y1 <ball_y[frame_cnt]< player_y2) : 
                    cv2.rectangle(frame, p1, p2, (255,0,0), 2, 1) #파란색으로 roi 색 바꿔주기
                    ball_touch += 1
                    blue_ROI = True 
                    
                                        
                else : # roi 빨간색
                    cv2.rectangle(frame, p1, p2, (0,0,255), 2, 1) #그렇지 않으면 빨간색 
                    
                    ########################패스 인식 알고리즘#############################
                    if blue_ROI == True :
                        red_ROI_cnt += 1 # ROI가 파란색에서 빨간색으로 바뀐 이후 빨간색 ROI를 유지하는 프레임 수 카운팅 
                        
                        if red_ROI_cnt > fps : # 일정 시간 이상동안 roi가 빨간색이라면 '선수의 드리블'이 아니라 '패스'임
                           pass_count += 1 # 선수에게 공을 뺏기거나(패스실패) 패스 성공해서 공 점유 끝남
                           red_ROI_cnt = 0 
                           blue_ROI = False 
              
                    ##################################################################
            
                ########################################################################################################
                
                if(ball_x[frame_cnt] > -1):
                
                    ###################################################골 인식 알고리즘 #############################################################                          
                    
                    # 공이 슬로우모션으로 쫓아가는 현상 해결(현재 프레임과 공이 인식된 프레임 번호가 같을 경우만 화면에 공 출력)
                    if ball_frame_cnt[frame_cnt] == frame_cnt :
                    
                        # Home팀의 '골 에어리어'에 공이 진입한 경우 초록색으로 표시 (가로 1000일 경우: 100이하, 900이상)
                        if ball_x[frame_cnt] >= width * 0.9 : 
                            
                            isInGoalNet = False 
                            invisible = frame_cnt - pre_frame_cnt
                                
                            if invisible > fps :# '골 에어리어' 영역에서 영상의 '프레임률(fps)' 이상 보이지 않는다면 공은 골 안에 있음 
                                isInGoalNet = True
                        
                            # '골'인 경우 노란색으로 표시
                            if isInGoalNet == True  :         #if ball_x == 947 and ball_y ==289 :
                                print('Home팀 골인입니다!!!!!', frame_cnt)
                                print('invisible term: ', invisible)
                                #cv2.waitKey(0)     # 화면 정지하고 키 입력을 기다리도록 
                                
                                cv2.putText(frame, 'Home team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                                show_goal_frame = 1
                                highlight_goal_point = frame_cnt # 골인을 인식한 프레임을 하이라이트 기준으로 삼음 
                                
       
                                cv2.circle(frame, (ball_x[frame_cnt], ball_y[frame_cnt]), 5, (0, 228, 255), 2) # 노란색으로 표시
                                pre_frame_cnt = frame_cnt
                                
                                

                            else :
                                print("Home팀 골에어리어에 공이 진입했습니다.", frame_cnt)                      
                                cv2.circle(frame, (ball_x[frame_cnt], ball_y[frame_cnt]), 5, (22, 219, 29), 2) # 초록색으로 표시
                                pre_frame_cnt = frame_cnt
                    
                        # Away팀의 '골 에어리어'에 공이 진입한 경우 초록색으로 표시 (가로 1000일 경우: 100이하, 900이상)
                        elif ball_x[frame_cnt] <= width * 0.1 : 
                            
                            isInGoalNet = False 
                            invisible = frame_cnt - pre_frame_cnt
                           
                                
                            if invisible > fps :# '골 에어리어' 영역에서 영상의 '프레임률(fps)' 이상 보이지 않는다면 공은 골 안에 있음 
                                isInGoalNet = True
                        
                            # '골'인 경우 노란색으로 표시
                            if isInGoalNet == True  :         #if ball_x == 947 and ball_y ==289 :
                                print('Away팀 골인입니다!!!!!', frame_cnt)
                                print('invisible term: ', invisible)
                                    
                                cv2.circle(frame, (ball_x[frame_cnt], ball_y[frame_cnt]), 5, (0, 228, 255), 2) # 노란색으로 표시
                                pre_frame_cnt = frame_cnt
                                highlight_goal_point = frame_cnt # 골인을 인식한 프레임을 하이라이트 기준으로 삼음
                                
             
                            else :
                                print("Away팀 골에어리어에 공이 진입했습니다.", frame_cnt)
                                cv2.circle(frame, (ball_x[frame_cnt], ball_y[frame_cnt]), 5, (22, 219, 29), 2) # 초록색으로 표시
                                pre_frame_cnt = frame_cnt
                        
                    
                        # 골에어리어에 공이 진입하지도 않았고, '골'도 아닌 경우
                        else : 
                    
                            cv2.circle(frame, (ball_x[frame_cnt], ball_y[frame_cnt]), 5, (0, 0, 255), 2)
                            pre_frame_cnt = frame_cnt

                            # rectangle(): 직사각형을 그리는 함수-길
                            #파라미터 (이미지, 왼쪽 위 좌표, 오른쪽 아래 좌표, 사각형 색깔, 사각형의 두께, ?? ) -길
                        
                    ################################################################################################################################################

                cv2.putText(frame, team_name+' '+str(player_num), (int(newbox[0])-27, int(newbox[1])-5), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window

                cv2.circle(radar,(int(newbox[0]), int(newbox[1])), 10, (0,0,255), -1)
                
                
                if(ball_x[frame_cnt] > -1):
                    cv2.circle(radar, (ball_x[frame_cnt], ball_y[frame_cnt]), 7, (0, 0, 0), -1)
                #Radar_Window

                overlay=heatmap_background.copy()
                alpha = 0.5  # Transparency factor.
                # cv2.circle(overlay,(int(newbox[0]), int(newbox[1])), 3, colors12[i], -1)   #Heatmap_Window
                # Following line overlays transparent rectangle over the imagex
                # heatmap_background = cv2.addWeighted(overlay, alpha, heatmap_background, 1 - alpha, 0)  #Heatmap_Window
            
                # 거리와 속도 추정치를 계산하기 위한 코드들
                if(frame_cnt==0) :
                    lastPoint = Point(x = int(newbox[0]), y = int(newbox[1]))   # 첫 프레임에서는 과거 좌표를 현재좌표와 동일하게 초기화함
                    coord_head = coord_tail = Point(x = int(newbox[0]), y = int(newbox[1])) # 히트맵을 위한 좌표값들 초기화
                
                if((frame_cnt%fps)==0) :     # 프레임기반 1초(fps)마다 동작하는 코드
                    # 초당 프레임간 발생한 거리차이를 a, b에 누적시킴 
                    a = (int)(newbox[0]) - lastPoint.x
                    b = (int)(newbox[1]) - lastPoint.y
                
                    moving_weight=math.sqrt(math.pow(a,2) + math.pow(b,2)) # 초당 움직인 거리(즉 속도) - 유클리디안 거리측정 사용
                    
                    # 트레커 추적중 발생하는 진동을 최소화하기위한 코드
                    if(moving_weight < 2) :
                        moving_weight=0
                    estimate_distance = estimate_distance + moving_weight   # 추정거리값을 누적시킴
                
                    distance = 4 * estimate_distance / 100      # 추정거리에서 도출된 값에 가중치를 두고 m단위로 변환 
                    distance = round(distance,2)                # 반올림 처리           
                    speed = (4 * moving_weight / 100)*3.6       # moving_weight를 통해 구해진 m/s에 3.6을 곱해 속도를 k/h로 바꿔줌
                    speed = round(speed,2)
                
                    if( speed < 5 ) :
                        walk_cnt = walk_cnt+1
                    elif( speed < 10 ) :
                        jog_cnt = jog_cnt+1
                    else :
                        sprint_cnt = sprint_cnt+1
                
                    if(speed > top_speed) :                     # 최고속도를 top_speed에 저장
                        top_speed = speed
                    
          
                
                    accumulate_speed = accumulate_speed+speed   # 속도값들을 전부 누적시킴
                    
                    if(frame_cnt!=0):
                        avg_speed = accumulate_speed / (frame_cnt/fps)
                        avg_speed = round(avg_speed,1)
                    else :
                        avg_speed = 0
                        
                    
                    lastPoint = Point(x = int(newbox[0]), y = int(newbox[1]))   # 과거 좌표 갱신
                
                    #txt 로그로 남겨주는 부분
                    # f.write( 'Player '+str(i)+' x,y: '+str(int(newbox[0]))+','+str(int(newbox[1])) + '\n' )
                    # fTemp.write(str(int(newbox[1]))+','+str(int(newbox[0]))+'\n')  히트맵에 더많은 로그를 찍기위해 이동
            
                #if(frame_cnt % (fps*3)==0) :
                    if(coord_head == coord_tail) :
                        coord_head = Point(x = int(newbox[0]), y = int(newbox[1]))
                    else :
                        coord_tail = coord_head
                        coord_head = Point(x = int(newbox[0]), y = int(newbox[1]))
                        cv2.arrowedLine(overlay,coord_tail, coord_head, (0,0,0),2,cv2.LINE_AA)
                        cv2.arrowedLine(overlay,coord_tail, coord_head, (0,0,0),2,cv2.LINE_AA)

                        heatmap_background = cv2.addWeighted(overlay, alpha, heatmap_background, 1 - alpha, 0)  #Heatmap_Window

                
            
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
                

                if((frame_cnt % (fps*interval))==0) :     # 프레임기반 interval[현재는 30초(fps)]마다 동작하는 코드
                    interval_distance = distance - temp_distance
                    temp_distance = distance
                    interval_distance = round(interval_distance,2)
                
                    interval_acc_speed = accumulate_speed - temp_speed;
                    temp_speed = accumulate_speed
                
                    interval_avg_speed = interval_acc_speed / interval
                    interval_avg_speed = round(interval_avg_speed,1)
                    # 30초마다 DB로 전송할 부분
                    ##########################################################################################
                    # interval_distance = 30초마다 뛴 거리
                    # interval_avg_speed = 30초마다 뛴 속도
                    ##########################################################################################
                    print('5분 뛴 거리 추정치 : ', interval_distance, ' / 5분 뛴 속도 추정치 : ',interval_avg_speed,' km/h')
                #f.write(str(int(newbox[1]))+','+str(int(newbox[0]))+'\n')
                str_coord = str_coord+str(int(newbox[1]))+','+str(int(newbox[0]))+'\n'  # str_coord 스트링에 좌표값을 누적시킴
                
                
                #골인 경우 2초 동안 화면에 보여주기 위함######################### 
                
                if 1 <=show_goal_frame <= fps * 2 :
                    if show_goal_frame != 1 :
                        cv2.putText(frame, 'Home team Goal!! ',(250, 276), cv2.FONT_HERSHEY_COMPLEX, 1.5, (0,0,255), 2, cv2.LINE_AA)
                    show_goal_frame += 1
                ####################################################
                
                frame_cnt=frame_cnt+1   # 프레임 갯수를 세어줌
                
  
                
                # print('거리 추정치 : ', distance, ' / 속도 추정치 : ',speed,' km/h')
            
                # 누적 거리값을 레이더의 플레이어 머리위에 띄워줌
                cv2.putText(radar, str(speed)+'km/h '+str(distance)+'m', (int(newbox[0]-60), int(newbox[1])-20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window
                # 레이더창에 실시간으로 선수의 볼터치 비율 보여주기 
                cv2.putText(radar, 'Speed : '+str(speed)+'km/h'+ ', Top speed : '+str(top_speed)+ 'km/h',(55, 40), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                cv2.putText(radar, 'Average speed : '+str(avg_speed)+'km/h'+', Running Distance : '+str(distance)+'m', (55, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                cv2.putText(radar, 'Walk / Jog / Sprint Count: '+str(walk_cnt)+' / '+str(jog_cnt)+' / '+str(sprint_cnt), (55, 80), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                cv2.putText(radar, 'Ball Touch Count: '+str(ball_touch), (55, 100), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                cv2.putText(radar, 'Pass Count: '+str(pass_count), (55, 120), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1, cv2.LINE_AA)
                

            # show all windows
            cv2.imshow('frame', frame)
            # cv2.imshow('fgMask', fgMask)
            cv2.imshow('HeatMap',heatmap_background)
            cv2.imshow('Radar',radar)
        
            # quit on ESC button
            if cv2.waitKey(1) & 0xFF == 27:  #incase Esc is pressed
                cv2.destroyAllWindows() # 화면 종료해주기
                break
                
            ################################################################영상 닫힘################################################################    
            
    
        avg_speed = accumulate_speed / (frame_cnt/fps)
        avg_speed = round(avg_speed,1)
        
        # 처음에 관리자가 A팀 선수와 B팀 몇 명씩 뛰는지 입력
        #player = 1, 2 
        #i = 0, 1

        #player = 3, 4
        # i = 2, 3 -> i = 0, 1 (flag만큼 뺴줘야 함)
        #flag = 2 
        
        ########################## 공 점유율 계산 알고리즘 ###############################################
        if player >= flag + 1 : # A팀 3명, B팀 5명으로 경기할 경우 -> flag = 3 
            ball_share_B.append(ball_touch)   
            print('B팀 ', player-flag, '번째 선수 개인의 공 점유 프레임 수 : ', ball_share_B[player-flag-1]) # 0, 1...
            sum_ball_B += ball_share_B[player-flag-1]
            print('B팀 공 점유 프레임 수 누적값: ', sum_ball_B)
        else :
            ball_share_A.append(ball_touch) 
            print('A팀 ', player, '번째 선수 개인의 공 점유 프레임 수 : ', ball_share_A[player-1])
            sum_ball_A += ball_share_A[i]
            print('A팀 공 점유 프레임 수 누적값: ', sum_ball_A)
            
        #############################################################################################

        print('총 뛴 거리 : ', distance,'m')
        print('최고 속도 : ', top_speed,'km/h')
        print('평균 속도 : ', avg_speed,'km/h')
        print('볼 터치 횟수 : ', ball_touch)
        print('패스 횟수 : ', pass_count,'개')
        #print('영상 총 프레임 수 : ', frame_cnt)

    
        move_sum = walk_cnt+jog_cnt+sprint_cnt
        walk_weight = round(walk_cnt / move_sum * 100,1)
        jog_weight = round(jog_cnt / move_sum * 100,1)
        sprint_weight = round(sprint_cnt / move_sum * 100,1)
        print('걸음 : ', walk_weight,'%, 뜀 : ', jog_weight,'%, 스프린트 : ', sprint_weight,'%')


        # 산소 소비량으로 측정하는 대략적인 칼로리 계산법   평균 속도 * (3.5 * 몸무게 * 시간(분) * 5 / 1000
        # 몸무게는 성인 남성 평균체중인 75kg로 가정
        cal = round(avg_speed * (3.5 * 75 *( 0.0167 * move_sum )) * 5 / 1000,1)
        print('소모 칼로리 : ',cal)
    
        player_file.write(str_coord)
        player_file.close()
        if(not(str_coord=='')) :
            heatmap.printHeatMap(height,width)
    

        # 최종 데이터를 DB로 전송할 부분
        ##########################################################################################
        # distance = 최종 뛴 거리, avg_speed = 평균속도, top_speed = 최고 속도
        # walk_weight = 걷기 비중, jog_weight = 조깅 비중, sprint_weight = 스프린트 비중
        # cal = 소모 칼로리
        # result_heatmap.png = 최종 히트맵 파일명
        ##########################################################################################
    
    
    
    ########################################공 점유율 계산 알고리즘################################################
    
    #for문이 다 돌은 뒤 공 점유율 계산
    ball_share_A_res = sum_ball_A / (sum_ball_A + sum_ball_B) * 100
    ball_share_B_res = sum_ball_B / (sum_ball_A + sum_ball_B) * 100
    
    print('\n')
    print('---------------------------------------------------------------------------------------------------')
    print('A팀 공 점유율: ', sum_ball_A, ' % (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_A_res, '%')
    print('B팀 공 점유율: ', sum_ball_B, ' % (', sum_ball_A, '+', sum_ball_B, ') x 100 = ', ball_share_B_res, '%')
    print('---------------------------------------------------------------------------------------------------')
    
    print('DB에 분석데이터가 저장되었습니다.')
    
    
    
    ##########################################################################################################

    
    ##########################################하이라이트 추출 알고리즘#################################################
    
    
    print('\n')
    print('하이라이트 추출 시작.....')
    
    ########################Goal.mov영상 생성#######################
    # 골을 인식한 프레임이 영상에서 몇 초쯤인지 계산
    videoFps = cap.get(cv2.CAP_PROP_FPS)   # 1초에 지나가는 프레임 수(fps)
    point1 = int (highlight_goal_point / videoFps )
    
    # 골을 인식한 프레임 앞으로 3초, 뒤로 2초
    start = point1 - 3
    end = point1 + 2
    
    # 영상의 start부터 end까지 영역을 자름 (초 기준)
    ffmpeg_extract_subclip("TEST.mp4", start, end, targetname="Goal.mov") 
    
    ####################Goal_zoom.mov 영상 생성######################
    cap = cv2.VideoCapture('Goal.mov')

    #재생할 파일의 넓이와 높이
    width = cap.get(cv2.CAP_PROP_FRAME_WIDTH)
    height = cap.get(cv2.CAP_PROP_FRAME_HEIGHT)

    #print("재생할 파일 넓이, 높이 : %d, %d"%(width, height))

    fourcc = cv2.VideoWriter_fourcc(*'DIVX')
    out1 = cv2.VideoWriter('Goal_zoom1.mov', fourcc, 30.0, (int(width), int(height)))
    out2 = cv2.VideoWriter('Goal_zoom2.mov', fourcc, 30.0, (int(width), int(height)))
    
    while(cap.isOpened()):
        ret, frame = cap.read()
    
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
    
    cap.release()
    out1.release()
    out2.release()
    cv2.destroyAllWindows()
    ######################################Highlight.mov###################################
    
    # concat함수를 이용해 비디오를 합쳐주기
    clip1 = VideoFileClip('Goal.mov')
    clip2 = VideoFileClip('Goal_zoom1.mov')
    clip3 = VideoFileClip('Goal_zoom2.mov')
    
    final_clip = concatenate_videoclips([clip1, clip2, clip3])
    final_clip.write_videofile('Highlight.mov', codec='libx264') # 코텍 적어줘야

    
    print('하이라이트 영상 생성 완료.....')
    #test용 코드
    #print(highlight_goal_point, ' ', start, ' ', end) 
    
    ##########################################################################################################




#v2.2 5분동안 뛴 속력 측정, 걸음/조깅/스프린트 비중 측정, 칼로리 측정 기능 추가


# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571


# 10초 히트맵 사진

# 30초마다 뛴거리
 
# 최종 뛴거리, 평균속도, 최고속도


# 30초마다 평균속도, 최종 히트맵, 칼로리, 비율 추가해야함
