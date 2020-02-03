from __future__ import print_function   # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                  # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                        # 오픈cv 열기
import os                        # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                        # 환경변수같은 인수를 입력받는 모듈
import random                     # 난수 생성할때 사용하는 모듈
import imutils                          # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리

#import pycuda
import math
import collections


# 여러 트레커를 사용할 수 있게 트레커들의 이름을 저장한 준비리스트 - 엘레먼트를 계속 추가할 수 있음
# 튜플은 변경이 불가
trackerTypes = ['BOOSTING', 'MIL', 'KCF','TLD', 'MEDIANFLOW', 'GOTURN', 'MOSSE', 'CSRT']

# to have different colours in plotting heatmaps for different players
# 히트맵에 각기 다른 색상을 표현하기 위한 튜플로 된 리스트  12개??
colors123 = [(0,0,0),(255,255,255),(255,0,0),(0,255,0),(0,0,255),(255,255,0),(0,255,255),(255,0,255),(192,192,192),(244,164,96),(128,128,0),(240, 50, 230)]

cnt = 0
 
# 트레커를 지정하는 함수
def createTrackerByName(trackerType):
   # Create a tracker based on tracker name
   if trackerType == trackerTypes[0]:
      tracker = cv2.TrackerBoosting_create()
   elif trackerType == trackerTypes[1]:  
      tracker = cv2.TrackerMIL_create()
   elif trackerType == trackerTypes[2]:
      tracker = cv2.TrackerKCF_create()
   elif trackerType == trackerTypes[3]:
      tracker = cv2.TrackerTLD_create()
   elif trackerType == trackerTypes[4]:
      tracker = cv2.TrackerMedianFlow_create()
   elif trackerType == trackerTypes[5]:
      tracker = cv2.TrackerGOTURN_create()
   elif trackerType == trackerTypes[6]:
      tracker = cv2.TrackerMOSSE_create()
   elif trackerType == trackerTypes[7]:
      tracker = cv2.TrackerCSRT_create()
   else: #사용자가 트래킹 모드 입력 안 했을 경우
      tracker = None
      print('Incorrect tracker name')
      print('Available trackers are:')
      for t in trackerTypes:
         print(t)
   return tracker

if __name__ == '__main__':

   #print("Default tracking algoritm is CSRT \n"
   #      "Available tracking algorithms are:\n")
   #for t in trackerTypes:
   #    print(t)      
  
   trackerType = 'CSRT'
   videoPath = sys.argv[1]   # Read video. here it is pano.mp4 in the same directory
 #videoPath='drone.mp4' 이런식으로 패스를 정해줘도 됨-길
 
  
   # Create a video capture object to read videos 
   cap = cv2.VideoCapture(videoPath)#비디오를 읽는 함수-길
   # Set video to load
   success, frame123 = cap.read()

   frame123 = imutils.resize(frame123, width=600) # 리사이징
   heatmap_background = cv2.imread('heatmap.png')    # heatmap.png as heatmap window's background
   original = cv2.imread('heatmap.png') # 
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
      # apply perspective transform for pano.mp4 to improve player detection accuracy
      # here its done for first frame to enable better selection of ROI.
      # hardcoded for pano.mp4 

      # cv2.circle(frame123, (583, 50), 5, (0, 0, 255), -1)
      # cv2.circle(frame123, (1342, 50), 5, (0, 0, 255), -1)
      # cv2.circle(frame123, (11, 390), 5, (0, 0, 255), -1)
      # cv2.circle(frame123, (1911, 390), 5, (0, 0, 255), -1)
      # pts1 = np.float32([[583, 50], [1342, 50], [25, 390], [1911, 390]])
      # pts2 = np.float32([[0, 0], [1800, 0], [0, 600], [1800, 600]])
      # matrix = cv2.getPerspectiveTransform(pts1, pts2)

      # frame = cv2.warpPerspective(frame123, matrix, (1800, 600))

      frame = frame123

      print('Select the 6 Home Team Players')
      print('Select the 6 Away Team Players')

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

   ## Initialize MultiTracker   
   # There are two ways you can initialize multitracker
   # 1. tracker = cv2.MultiTracker("CSRT")
   # All the trackers added to this multitracker
   # will use CSRT algorithm as default
   # 2. tracker = cv2.MultiTracker()
   # No default algorithm specified

   # Initialize MultiTracker with tracking algo
   # Specify tracker type
  
   # Create MultiTracker object
   multiTracker = cv2.MultiTracker_create()
   #좌표를 표현할 이름있는 튜플
   Point=collections.namedtuple('Point',['x','y'])
   lastPoint=Point(x=-1, y=-1)
   estimate_distance=0
   distance = 0
   cnt = 0
    
    

   # Initialize MultiTracker 
   for bbox in bboxes:
      multiTracker.add(createTrackerByName(trackerType), frame, bbox)

   # Process video and track objects
   while cap.isOpened():#비디오가 잘 열렸는지 확인하는 함수-길
      success, frame123 = cap.read()# cap.read() 는 동영상을 1프레임씩 읽어오는 것-길
      frame123 = imutils.resize(frame123, width=600) # 리사이징
# if not success:
#    exit()     #영상이 읽히지 않으면 종료한다.-길
      # apply perspective transform for pano.mp4 to improve player detection accuracy
      # hardcoded for pano.mp4 
      cv2.circle(frame123, (583, 50), 5, (0, 0, 255), -1)
      cv2.circle(frame123, (1342, 50), 5, (0, 0, 255), -1)
      cv2.circle(frame123, (11, 390), 5, (0, 0, 255), -1)
      cv2.circle(frame123, (1911, 390), 5, (0, 0, 255), -1)
      pts1 = np.float32([[583, 50], [1342, 50], [25, 390], [1911, 390]])
      pts2 = np.float32([[0, 0], [1800, 0], [0, 600], [1800, 600]])
      matrix = cv2.getPerspectiveTransform(pts1, pts2)

      #frame = cv2.warpPerspective(frame123, matrix, (1800, 600))
      frame = frame123
      if not success:
         break

      # get updated location of objects in subsequent frames
      success, boxes = multiTracker.update(frame)#update() 따라가게 만드는 함수 - 길
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
            
            if(lastPoint.x!=-1 and lastPoint.y!=-1) :
               a = (int)(newbox[0]) - lastPoint.x
               b = (int)(newbox[1]) - lastPoint.y
               estimate_distance = estimate_distance + math.sqrt(math.pow(a,2) + math.pow(b,2))
               distance = 4 * estimate_distance / 100
               distance = round(distance,2)
            lastPoint = Point(x = int(newbox[0]), y = int(newbox[1]))
                
                
            print('거리 추정치 : ',distance)
            cv2.putText(radar, str(distance)+'m', (int(newbox[0]), int(newbox[1])), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,0,255), 1, cv2.LINE_AA)  #Multitracker_Window

                #풋살장 국제규격 길이 
                
                
            f.write( 'Home: Player '+str(i)+' x,y: '+str(int(newbox[0]))+','+str(int(newbox[1])) + '\n' )      #save location coords for future use
            
         else:
            cv2.putText(frame, str(i), (int(newbox[0])-2, int(newbox[1])-2), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255,0,0), 1, cv2.LINE_AA)  #Multitracker_Window

            cv2.circle(radar,(int(newbox[0]), int(newbox[1])), 10, (255,0,0), -1)#Radar_window

            overlay=heatmap_background.copy()
            cv2.circle(overlay,(int(newbox[0]), int(newbox[1])), 10, colors123[i-11], -1) #Heatmap_Window
            alpha = 0.1  # Transparency factor.
            # Following line overlays transparent rectangle over the image
            heatmap_background = cv2.addWeighted(overlay, alpha, heatmap_background, 1 - alpha, 0) #Heatmap_Window
            
            if(cnt>10):
               f.write( 'Away: Player '+str(i)+' x,y: '+str(int(newbox[0]))+','+str(int(newbox[1])) + '\n' )      #save location coords for future use
               cnt=0

      # show all windows
      cv2.imshow('MultiTracker', frame)
      cv2.imshow('HeatMap',heatmap_background)
      cv2.imshow('Radar',radar)
      
      # quit on ESC button
      if cv2.waitKey(1) & 0xFF == 27:  #incase Esc is pressed
         break
f.close()




# 사각형의 중심 좌표
# center_x = left+w / 2
# center_y = top+h / 2
# 풋살장 국제규격 길이(가로) 38m ~ 42m / 너비(세로) 20 ~ 25m  계산하기 쉽도록 가로 40m 세로 20m로 가정함 4000 2000 / 1000 571