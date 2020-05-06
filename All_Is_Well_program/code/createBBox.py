import cv2                                # 오픈cv 열기

def selectBBox(frame) :

    print('Select the Player')

    bbox = cv2.selectROI('MainWindow', frame) #roi 를 선택하는 함수

    print('Selected bounding boxes {}'.format(bbox))
    return bbox


def select_bbox(player_cnt, team_cnt, team, video_stream, frame) :
    print('Select the Player')
    cv2.putText(frame, str(team)+' Team  ', (50, 30), cv2.FONT_HERSHEY_COMPLEX, 1, (255,255,255), 2, cv2.LINE_AA) 
    cv2.putText(frame, ' done: '+str(player_cnt-1)+' / total: '+str(team_cnt),(45, 60), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,255,255), 1, cv2.LINE_AA)  
    
    videoLen = int(video_stream.get(cv2.CAP_PROP_FRAME_COUNT))
    videoFps = video_stream.get(cv2.CAP_PROP_FPS)
    videoTime = int((videoLen / videoFps))  # 동영상 재생 시간을 초로 반환
    
    # 분석하는데 남은 에상 소요시간
    analTime = videoTime * (team_cnt-player_cnt+1)
    if analTime < 60 :
        minute = 0
        second = analTime
    else :
        minute = int(analTime / 60) # 분
        second = analTime % 60 # 초 
        
    cv2.putText(frame, ' estimated time: '+str(minute)+'m '+str(second)+'s',(45, 85), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,255,255), 1, cv2.LINE_AA)  
    bbox = cv2.selectROI('MainWindow', frame) #roi 를 선택하는 함수
    print('Selected bounding boxes {}'.format(bbox))
    return bbox