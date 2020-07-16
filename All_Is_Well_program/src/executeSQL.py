#import LoginDB
import pymysql                              # Python에서 MySQL을 사용할 수 있도록 하는 모듈
from io import BytesIO                      # Byte 형식의 파일을 다루기 위한 모듈
from PIL import Image                       # PIL 모듈 Image를 다루기 위한 모듈
import base64                               # base64 형식으로 인코딩 디코딩하기 위한 모듈

connect = pymysql.connect(host='15.164.30.158', user='sk', password='1234', db='AIWUserDB',charset='UTF8MB4')
cursor = connect.cursor()
# MySQL의 데이터베이스를 로그인하고 연결하는 메소드 pymysql.connect() connect는 관련된 정보를 저장하는 변수
# 데이터베이스의 데이터를 받아오는 메소드 .cursor()

# 데이터 변화 적용
# CREATE 혹은 DROP, DELETE, UPDATE, INSERT와 같이 Database 내부의 데이터에 영향을 주는 함수의 경우 .commit()을 해주어야 함.
# conn.commit()

def ConnectDataBase():
    return connect,cursor

def CreatePlayerTable(player_id):
    sql = """
    CREATE TABLE IF NOT EXISTS {0} (
    play_id INT NOT NULL AUTO_INCREMENT,
    speed_5 FLOAT NULL,
    speed_10 FLOAT NULL,
    speed_15 FLOAT NULL,
    speed_20 FLOAT NULL,
    avgSpeed FLOAT NULL,
    maxSpeed FLOAT NULL,
    distance_5 FLOAT NULL,
    distance_10 FLOAT NULL,
    distance_15 FLOAT NULL,
    distance_20 FLOAT NULL,
    totalDistance FLOAT NULL,
    calorie FLOAT NULL,
    walk FLOAT NULL,
    jog FLOAT NULL,
    sprint FLOAT NULL, 
    video_length FLOAT NULL,
    result_heatmap mediumblob NULL,
    PRIMARY KEY(play_id)
    );
    """.format(player_id) 
    # 선수 개인별 경기 관리 테이블 생성

    cursor.execute(sql)
    connect.commit()

def CreatePathmapTable(player_id):
    pathmap_table = player_id+"_pathmap"

    sql = """
    CREATE TABLE IF NOT EXISTS {0}(
        pathmap_number INT NOT NULL AUTO_INCREMENT,
        pathmap_data MEDIUMBLOB,
        play_id INT NOT NULL,
        PRIMARY KEY(pathmap_number)
    );
    """.format(pathmap_table)
    # pathmap_table 선수별 히트맵 테이블 생성

    cursor.execute(sql)
    connect.commit()

    return pathmap_table

def PlayID(player_id):
    sql = "SELECT * FROM {0}".format(player_id)

    cursor.execute(sql)
    number_check = cursor.fetchone() # 마지막으로 저장한 play_id를 저장하는 변수

    if number_check is None :
        play_id = 1
    else :
        sql = "SELECT * FROM {0} ORDER BY play_id DESC LIMIT 1".format(player_id)
        cursor.execute(sql)
        number_check = cursor.fetchone()
        play_id = number_check[0]+1

    sql = "INSERT INTO {0}(play_id) VALUES({1})".format(player_id,play_id)
    cursor.execute(sql)
    connect.commit()

    return play_id

def EngName(player_id):
    sql = 'SELECT en_name FROM playersignupinfo WHERE id = "{0}"'.format(player_id)

    cursor.execute(sql)
    Player_EngName = cursor.fetchone()

    return Player_EngName[0]


def CommitPathmap(pathmap_filename,pathmap_table,play_id):
    buffer = BytesIO()
    image=Image.open(pathmap_filename)
    image.save(buffer,format='png')
    encoded_image=base64.b64encode(buffer.getvalue())
    sql= "INSERT INTO {0}(pathmap_data,play_id) VALUES(%s,%s)".format(pathmap_table)
    insert_data = (encoded_image,play_id)
    cursor.execute(sql,insert_data)

def CommitInterval(player_id, distance_colum, interval_distance, speed_colum, interval_avg_speed, play_id):
    sql = """UPDATE {0}
    SET {1} = {2},
    {3} = {4}
    WHERE play_id = {5};
    """.format(player_id, distance_colum, interval_distance, speed_colum, interval_avg_speed, play_id)

    cursor.execute(sql)
    connect.commit()


def CommitResult(player_id, avg_speed, top_speed, distance, cal, walk_weight, jog_weight, sprint_weight, video_time, play_id):
    buffer = BytesIO()
    image=Image.open("../result/result_heatmap.png")
    image.save(buffer,format='png')
    encoded_image=base64.b64encode(buffer.getvalue())
    insert_image = (encoded_image)

    insert_data ="""
    UPDATE {0}
    SET avgSpeed = {1},
    maxSpeed = {2},
    totalDistance = {3},
    calorie = {4},
    walk = {5},
    jog = {6},
    sprint = {7},
    video_length = {8},
    result_heatmap = %s
    WHERE play_id = {9}
    ;""".format(player_id, avg_speed, top_speed, distance, cal, walk_weight, jog_weight, sprint_weight, video_time, play_id)

    # INSERT INTO {0} (avgSpeed, maxSpeed, distance_5, distance_10, distance_15, distance_20, totalDistance) SQL문법 나중에 적용

    cursor.execute(insert_data,insert_image)
    connect.commit()

def CloseConnect():
    connect.close()