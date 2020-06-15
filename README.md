# Futsal-Video-Analysis-System

## 프로젝트 소개

### 드론으로 촬영한 풋살 경기 영상을 영상처리 기술로 분석하여 선수 개인의 데이터부터 경기 데이터까지 다양하고 의미 있는 데이터를 추출하여 시각화한다.&nbsp; 또한 감독 모드를 통해 선수들의 컨디션 관리와 경기 내용과 결과 등 팀을 운용을 하는데 유용하게 쓰일 수 있다.

## 연구 개발 목표

### 1. 누구나 사용 가능한 영상 분석 서비스

#### &nbsp;&nbsp;&nbsp; 고가의 특수 장비 없이 영상으로만 분석, 전문 리그를 상대로 하는 서비스가 아닌 누구나 사용가능한 프로그램 제공

### 2. 효율적이고 과학적인 팀 관리

####  &nbsp;&nbsp;&nbsp; 해당 경기를 데이터로 기록하고 축적된 데이터를 기반으로 팀에 알맞은 전술 설정과 피드백을 할 수 있도록 함

### 3. 활동에 불편함을 일으키는 특수장비 제거

####   &nbsp;&nbsp;&nbsp;기존의 GPS 장치를 이용한 분석 서비스에서 영상 하나만을 분석하여 다양한 정보를 제공



## 수행 시나리오

<img width="900" alt="scenario" src="https://user-images.githubusercontent.com/54341018/76286526-cdeb3c80-62e5-11ea-8256-939bb882ec44.png">


## 개발환경

### Programming Language

  - Web: HTML, CSS, Java Script, JSP   
  - Database: SQL   
  - Python3     

### Development Tool  
  - OS : Windows 10  

  - Tool : Visual Studio Code, Anaconda, Jupyter Notebook, Eclipse 
                        
  - Version Control System : Git, Github 

  - Software Development Process : Agile, Scrums

### Sever

  - Cloud Server : Amazone Web Service

  - Web Server : Apache Tomcat

  - DB : MySQL
  
  - Library : OpenCV, Highchart, Googlechart 


### Client
  - Browser : Chrome

  - Device : Galaxy A8 / Android Pie(9.0)

  - Drone : Parrot Bebop 2 (Drone), Dji Mavic Pro2(Drone), iPhone Xs


## 업무 분담

#### 권한길  
  - 웹페이지 감독모드 UI, 선수모드 UI 개발  
  - 드론으로 풋살 경기 영상 촬영  
  - 객체 인식 Test  
  - API 사용하여 그래프 표현  
#### 이길형   
  - 파이썬 영상 분석 프로그램 GUI 개발  
  - Pysql로 파이썬 프로그램에 DB 연동   
  - OpenCV 환경구축  
  - DB 설계       
#### 정수경  
  - 웹페이지 감독모드 UI, 선수모드 UI   
  - 서버 구축  
  - DB 서버 구축 및 연동   
  - API 사용하여 그래프 표현  
#### 정하림  
  - 선수 트래킹 및 선수 데이터 분석 알고리즘 개발  
  - 공 인식   
  - OpenCV 환경 구축   
  - DB 서버 구축 및 연동  
  - 서버 구축  

## 개발 일정   

  
<img width="841" alt="스크린샷 2020-03-10 오후 3 45 09" src="https://user-images.githubusercontent.com/54341018/76286705-228eb780-62e6-11ea-9cd6-c1425d3fd869.png">


## 프로그램 실행 방법  

### 파이썬 분석 프로그램   
(python 3.6 opencv4.1.2 설치)   
- clone 후 terminal 또는 cmd 창에서 라이브러리 설치    
-pip3 install numpy  
-pip3 install opencv  
-pip3 install opencv-contrib-python  
-pip3 install matplotlib  
-pip3 install imutils  
-pip3 install pillow  
-pip3 install pymsql
-pip3 install moviepy
- exe파일 실행  
- Website에 가입된 ID, Password 입력
- 분석할 영상 선택
- 원하는 선수에게 ROI를 쳐주고 'Enter'를  누르고 'q' 를 누르면 분석이 시작된다.


### web

- clone 후 eclipse 에 import   

- index.html 실행 -> sign in   or   sign up( 임의 아이디 -  ID : messi Password : 1234 ) 
 
- log in -> 선수 or 감독 모드 선택   

- home.jsp -> 선수 모드로 들어가 개인 경기 데이터(MyData.jsp)와 개인 스탯, 팀 스탯 , 감독 피드백(CoachNote.jsp) , 경기 일정 조회(Calendar.jsp) 경기 영상 조회(myVideo.jsp)   

- home_of_coach.jsp -> 감독모드로 들어가 선수단 정보(TeamData_Coach.jsp)와 팀 데이터, 경기 결과 및 데이터(MatchData_Coach.jsp), 선수 피드백(CoachNote.jsp), 경기 일정 조회(Calendar.jsp), 경기 영상 조회(myVideo.jsp) 





