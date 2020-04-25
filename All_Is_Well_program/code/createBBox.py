import cv2                                # 오픈cv 열기

def selectBBox(frame) :

    print('Select the Player')

    bbox = cv2.selectROI('MainWindow', frame) #roi 를 선택하는 함수

    print('Selected bounding boxes {}'.format(bbox))
    return bbox
