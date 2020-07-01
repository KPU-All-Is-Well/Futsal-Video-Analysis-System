from __future__ import print_function       # print_function 이라는 모듈에서 future만 뽑아서 사용 # python 2에서 python3의 문법을 사용하기 위해
import numpy as np                          # np numarray 이미지 파일을 배열형식으로 뽑아낼때 사용 
import cv2                                  # 오픈cv 열기
import os                                   # 운영체제 기능을 파이썬에서 사용 ex 파일입출력
import sys                                  # 환경변수같은 인수를 입력받는 모듈
import imutils                              # image utils 이미지 관련된 유틸리티 - opencv와 관련된 라이브러리

import math
import collections

from moviepy.editor import *                                     # moviepy 라이브러리 :
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip # 하이라이트 영상 추출을 위해 구간 자르는 라이브러리 


def makeHighlight(video_stream, video_path, highlight_goal_point) :

    ########################Goal.mov영상 생성#######################
    
    # 골을 인식한 프레임이 영상에서 몇 초쯤인지 계산
    videoFps = video_stream.get(cv2.CAP_PROP_FPS)   # 1초에 지나가는 프레임 수(fps)
    
    
    point1 = int (highlight_goal_point / videoFps )
    
    # 골을 인식한 프레임 앞으로 3초, 뒤로 2초
    start = point1 - 3
    end = point1 + 2
    
    # 영상의 start부터 end까지 영역을 자름 (초 기준)
    ffmpeg_extract_subclip(video_path, start, end, targetname="../result/Goal.mov") 
    
    ####################Goal_zoom1.mov, Goal_zoom2.mov 영상 생성######################
    video_stream = cv2.VideoCapture('../result/Goal.mov')

    #재생할 파일의 넓이와 높이
    width = video_stream.get(cv2.CAP_PROP_FRAME_WIDTH)
    height = video_stream.get(cv2.CAP_PROP_FRAME_HEIGHT)

    #print("재생할 파일 넓이, 높이 : %d, %d"%(width, height))

    fourcc = cv2.VideoWriter_fourcc(*'DIVX')
    out1 = cv2.VideoWriter('../result/Goal_zoom1.mov', fourcc, 30.0, (int(width), int(height)))
    out2 = cv2.VideoWriter('../result/Goal_zoom2.mov', fourcc, 30.0, (int(width), int(height)))


    while(video_stream.isOpened()):
        ret, frame = video_stream.read()
    
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
        centerX2, centerY2 = int(height2*0.5), int(width2*0.8)  #골인식 줌 위치 
        radiusX2, radiusY2 = int(scale2*height2/100), int(scale2*width2/100)
    
        minX2,maxX2=centerX2-radiusX2,centerX2+radiusX2
        minY2,maxY2=centerY2-radiusY2,centerY2+radiusY2
    
        cropped2 = frame[minX2:maxX2, minY2:maxY2]
        resized_cropped2 = cv2.resize(cropped2, (width2, height2))    
        
        out2.write(resized_cropped2)

       
    
    video_stream.release()
    out1.release()
    out2.release()
    cv2.destroyAllWindows()
    
    
    
    ######################################Highlight.mov###################################
    
    # concat함수를 이용해 비디오를 합쳐주기
    clip1 = VideoFileClip('../result/Goal.mov')
    clip2 = VideoFileClip('../result/Goal_zoom1.mov')
    clip3 = VideoFileClip('../result/Goal_zoom2.mov')
    
    final_clip = concatenate_videoclips([clip1, clip2, clip3])
    final_clip.write_videofile('../result/Highlight.mov', codec='libx264') # 코텍 적어줘야

    
    print('하이라이트 영상 생성 완료.....')
    #test용 코드
    #print(highlight_goal_point, ' ', start, ' ', end) 
    
    