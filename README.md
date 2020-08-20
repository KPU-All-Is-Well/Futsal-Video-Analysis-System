# Futsal Video Analysis System for Amateur Players

## Introduction

**아마추어 풋살 분석 시스템**은 드론으로 촬영한 풋살 경기 영상을 영상처리 기술과 **All Is Well** 팀원들이 개발한 분석 알고리즘을 통해 선수와 팀 경기를 분석한다. 시스템은 크게 **파이썬 분석 프로그램**과 **웹 서비스**로 구성되어 있다. 파이썬 분석 프로그램을 통해 선수 개인의 데이터부터 경기 데이터까지 아래와 같이 다양하고 의미 있는 데이터를 추출한다. 사용자는 [All Is Well](http://15.164.30.158:8080/All_Is_Well_Web/index.html) 웹을 통해 서비스를 제공받는다. 웹은 감독 UI와 선수 UI를 분리하여 선수 개인의 역량을 분석 받고, 감독은 팀 운용과 전술을 세울 때 도움받을 수 있다.

  - **선수 개인의 최고 속도**
  - **평균 속도**
  - **실시간 속도** 
  - **스프린트,걷기,뛴 비율** 
  - **경기 중 소모한 칼로리**
  - **경기 중 뛴 거리**
  - **포지션별 활동 반경 히트맵**
  - **포지션별 이동 경로 패스맵**
  - **팀 공 점유율**
  - **선수 개인의 팀 기여도**
  - **선수 스탯**
  - **하이라이트 영상 자동 추출**
  
'아마추어 풋살 분석 시스템'은 다음과 같은 3가지 측면에서 기존 서비스와 차별성을 두고 있다. 
  
**무거운 GPS 장치 부착 X**: 기존 서비스 중 하나로 무거운 GPS가 부착된 옷을 착용하여 축구 경기를 분석하는 방법이 있다. 그러나 이는 선수의 원활한 경기를 방해할 뿐만 아니라 일반 아마추어 축구 선수들이 구매하기에는 합리적이지 않은 가격이다. 따라서 ‘아마추어 풋살 분석 시스템’은 영상처리 기술의 csrt 트래커를 사용하여 고가의 GPS 필요 없이도 선수를 추적하고 다양한 분석 데이터를 추출한다.

**고가의 고화질 카메라 사용 X**: 축구 분석 서비스를 제공하기 위해 사용자가 이용하는 경기장에 고가의 고화질 카메라를 설치하는 방법이 있다. 하지만 이 점 때문에 사용자가 특정 공간에서만 제한적으로 경기를 해야 한다는 한계점이 있다. 따라서 ‘아마추어 풋살 분석 시스템’은 드론을 사용함으로써 사용자가 원하는 장소에서 어디서든 경기를 촬영하고 분석 서비스를 제공받을 수 있다.

**축구 분석 전문가 인력 사용 X**: 현재 전문 리그를 상대로 하는 축구 분석 서비스는 분석 소프트웨어뿐만 아니라 축구 전문가를 추가적으로 배치하여 서비스를 제공한다. 이 점을 보았을 때 현 축구 분석 시장은 여전히 전문 인력에 의존하는 소프트웨어를 사용하는 것으로 보인다. 하지만 ‘아마추어 풋살 분석 시스템’은 축구 전문 인력 필요 없이 오직 소프트웨어만을 통해서 분석 데이터가 산출되어 인력 비용을 절약할 수 있다.
  

## System Scenario
![시나리오](https://user-images.githubusercontent.com/50011528/89124482-3b586d80-d512-11ea-8253-490af23f31fc.png)



## Purpose

**1. 프로 뿐만 아니라 아마추어도 사용 가능한 서비스**

전문 리그를 상대로 하는 서비스가 아닌 누구나 사용가능한 프로그램을 제공한다.

**2. 효율적이고 과학적인 팀 관리**

해당 경기를 데이터로 기록하고 축적된 데이터를 기반으로 팀에 알맞은 전술 설정과 피드백을 할 수 있다.

**3. 분석 비용 절감**

기존의 축구 분석 서비스는 선수와 팀 분석을 위해 많은 물리적 비용과 인적 비용을 필요로한다. 하지만 영상처리기술과 드론만을 활용하여 다양한 데이터를 분석해서 제공하는 것을 목표로한다.
  





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
 

## Using Futsal Video Analysis System

### Web

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

## Development Environment

**Programming Language**

  - Web: HTML, CSS, Java Script, JSP   
  
  - Database: SQL   
  
  - Python3     

**Development Tool**  
  
  - OS : Windows 10  

  - Tool : Visual Studio Code, Anaconda, Jupyter Notebook, Eclipse 
                        
  - Version Control System : Git, Github 

  - Software Development Process : Agile, Scrums

**Server**

  - Cloud Server : Amazone Web Service

  - Web Server : Apache Tomcat

  - DB : MySQL
  
  - Library : OpenCV, Highchart

**Client**

  - Browser : Chrome
  
  - Drone : Parrot Bebop 2 (Drone), Dji Mavic Pro2(Drone), iPhone Xs


## Contributors

**[권한길](https://github.com/navigator515)**  
  - 웹 선수UI와 감독UI 개발
  - 웹 데이터 시각화 모듈 개발
  - 풋살 경기 영상 제작  
  - 선수 트래킹 모듈 개발   
  
**[이길형](https://github.com/2Gily)**   
  - 파이썬 영상 분석 프로그램 GUI 개발  
  - 파이썬 프로그램 DB 연동 모듈 개발   
  - 선수 트래킹 모듈 개발  
  - DB 설계 및 구축       
  
**[정수경](https://github.com/Soogyung1106)**  
  - 웹 서버 및 DB 구축
  - 웹 선수UI와 감독UI 개발
  - 웹 데이터 시각화 모듈 개발    
  - 공 트래킹 모듈 개발
  - 하이라이트 추출 모듈 개발
  - 데이터 분석 알고리즘 개발 : 공 점유율, 선수의 팀 기여도, 골인 탐지 
  
**[정하림](https://github.com/LightLamp1101)**  
  - 웹 서버 및 DB 구축
  - 선수 트래킹 모듈 개발  
  - 공 트래킹 모듈 개발      
  - 데이터 분석 알고리즘 개발 : 최고 속도, 평균 속도, 뛴 거리, 활동 반경 히트맵/패스맵, 칼로리
  - 실시간 분석 그래프 모듈 개발
    








