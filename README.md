# Futsal Video Analysis System For Amateur

## Introduction

**아마추어 풋살 분석 시스템**은 드론으로 촬영한 풋살 경기 영상을 영상처리 기술과 **All Is Well** 팀원들이 개발한 분석 알고리즘을 통해 선수와 팀 경기를 분석한다. 시스템은 크게 파이썬 분석 프로그램과 웹 서비스로 구성되어 있다. 파이썬 분석 프로그램을 통해 선수 개인의 데이터부터 경기 데이터까지 다음과 같은 다양하고 의미 있는 데이터를 추출한다.

  - **선수 개인의 최고 속도**
  - **평균 속도**
  - **실시간 속도** 
  - **스프린트 비율** 
  - **경기 중 소모한 칼로리**
  - **경기 중 뛴 거리**
  - **포지션별 활동 반경 히트맵**
  - **팀 공 점유율**
  - **선수 개인의 팀 기여도**
  - **선수 스탯**
  - **하이라이트 영상 자동 추출**


사용자는 [All Is Well](http://15.164.30.158:8080/All_Is_Well_Web/index.html) 웹 서비스 통해 분석된 데이터를 시각화된  그래프로 제공받는다. 웹은 감독 UI와 선수 UI를 분리하여 선수들은 개인의 역량을 분석 받고, 감독은 팀 운용과 전술을 세울 때 도움받을 수 있다.


## 연구 개발 목표

### 1. 누구나 사용 가능한 영상 분석 서비스

#### &nbsp;&nbsp;&nbsp; 고가의 특수 장비 없이 영상으로만 분석, 전문 리그를 상대로 하는 서비스가 아닌 누구나 사용가능한 프로그램 제공

### 2. 효율적이고 과학적인 팀 관리

####  &nbsp;&nbsp;&nbsp; 해당 경기를 데이터로 기록하고 축적된 데이터를 기반으로 팀에 알맞은 전술 설정과 피드백을 할 수 있도록 함

### 3. 활동에 불편함을 일으키는 특수장비 제거

####   &nbsp;&nbsp;&nbsp;기존의 GPS 장치를 이용한 분석 서비스에서 영상 하나만을 분석하여 다양한 정보를 제공



## System Scenario
<img width="900" alt="scenario" src="https://user-images.githubusercontent.com/54341018/76286526-cdeb3c80-62e5-11ea-8256-939bb882ec44.png">


## Installation

### Python Analysis Program   
 
우선 이 repository를 클론:

```bash
git clone https://github.com/KPU-All-Is-Well/Futsal-Video-Analysis-System.git
```

clone 후 terminal에서 라이브러리 설치:    

```bash
pip3 install numpy  
```
```bash
pip3 install opencv  
```
```bash
pip3 install opencv-contrib-python  
```
```bash
pip3 install matplotlib  
```
```bash
pip3 install imutils  
```
```bash
pip3 install pillow  
```
```bash
pip3 install pymsql
```
```bash
pip3 install moviepy
```

NOTE: python 3.6 환경이므로 pip3로 설치하도록 한다. 

## Using Futsal Video Analysis System

### All Is Well Web
1. [All Is Well](http://15.164.30.158:8080/All_Is_Well_Web/index.html) 웹 접속

2. 회원가입 (선수 or 감독) 

3. 로그인 (선수 or 감독)
 

### Python Analysis Program   
1. main.py 파일이 있는 디렉토리로 이동:

```bash
cd Futsal-Video-Analysis-System\All_Is_Well_program\src 
```

2. main.py 실행:

```bash
python main.py
```

3. 분석할 영상 선택

4. 분석할 팀과 선수 선택

5. 분석할 선수에게 ROI 지정 후 'Enter' 입력

## Our Development Environment

### Programming Language

  - Web: HTML, CSS, Java Script, JSP   
  - Database: SQL   
  - Python3     

### Development Tool  
  - OS : Windows 10  

  - Tool : Visual Studio Code, Anaconda, Jupyter Notebook, Eclipse 
                        
  - Version Control System : Git, Github 

  - Software Development Process : Agile, Scrums

### Server

  - Cloud Server : Amazone Web Service

  - Web Server : Apache Tomcat

  - DB : MySQL
  
  - Library : OpenCV, Highchart

### Client
  - Browser : Chrome
  
  - Drone : Parrot Bebop 2 (Drone), Dji Mavic Pro2(Drone), iPhone Xs


## Team Member 

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
  - 웹 서버 및 DB 구축
  - 웹 선수UI와 감독UI 개발
  - 웹 데이터 시각화 모듈 개발    
  - 공 트래킹 모듈 개발
  - 데이터 분석 알고리즘 개발 : 하이라이트 자동 추출, 공 점유율, 선수의 팀 기여도
#### 정하림  
  - 선수 트래킹 및 선수 데이터 분석 알고리즘 개발  
  - 공 인식   
  - OpenCV 환경 구축   
  - DB 서버 구축 및 연동  
  - 서버 구축  

## 개발 일정   

  
<img width="841" alt="스크린샷 2020-03-10 오후 3 45 09" src="https://user-images.githubusercontent.com/54341018/76286705-228eb780-62e6-11ea-9cd6-c1425d3fd869.png">







