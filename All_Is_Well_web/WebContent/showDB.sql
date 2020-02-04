/*회원가입시 필요한 정보들*/

CREATE TABLE PlayerSignUpInfo(  /*선수 모드*/
 
	id VARCHAR(15) NOT NULL , /*아이디*/
	
	name VARCHAR(10) not null, /*이름*/
	passwd VARCHAR(15) not null, /*비밀번호*/
	email VARCHAR(30) not null, /*메일*/
	height float not null, /*키*/
	weight float not null, /*몸무게*/
	age int not null, /*나이*/
	team VARCHAR(15) not null, /*팀명*/ 
	mainPosition VARCHAR(15) not null, /*주포지션*/
	subPosition VARCHAR(15) not null, /*부포지션*/
	
	PRIMARY KEY(id)
	
);


CREATE TABLE CoachSignUpInfo( /*감독 모드*/

	/*회원가입시 필요한 정보들-선수 모드*/ 
	id VARCHAR(15) NOT NULL , /*아이디*/
	
	name VARCHAR(10) not null, /*이름*/
	passwd VARCHAR(15) not null, /*비밀번호*/
	email VARCHAR(30) not null, /*메일*/
	team VARCHAR(15) not null, /*팀명*/ 
		
	PRIMARY KEY(id)  /*기본키*/
	
);


CREATE TABLE PlayInfo(  /*개개인 선수의 경기에 대한 정보*/
 
	id VARCHAR(15) NOT NULL , /*아이디*/
	
	avgSpeed float not null, /*평균 속도*/
	maxSpeed float not null, /*최고 속도*/
	distance_5 float not null, /*0~5분 뛴 거리*/
	distance_10 float not null, /*5~10분 뛴 거리*/ 
	distance_15 float not null, /* 10~15분 뛴 거리*/
	distance_20 float not null, /*15~20분 뛴 거리*/
	totalDistance float not null, /*뛴 총 거리*/
	calorie int not null, /*20분 동안 소모한 칼로리*/
	
	PRIMARY KEY(id),
	FOREIGN KEY (id) REFERENCES PlayerSignUpInfo(id)
	
	
);

/*칼럼 추가 명령어*/
alter table PlayInfo add calorie int not null; /*칼로리*/
alter table PlayInfo add walk int not null; /*걷기, 조깅, 스프린트 비율*/
alter table PlayInfo add jog int not null;
alter table PlayInfo add sprint int not null;


/*임시로 데이터 넣어놓기*/
INSERT INTO PlayInfo values('a', '2.5', '5', '2', '1', '3', '0.5', '1.5', '800', '10', '50', '40');
INSERT INTO PlayInfo values('b', '2', '4', '1.5', '2', '4', '1', '3', '650', '50', '20', '30');
INSERT INTO PlayInfo values('c', '2', '4', '1.5', '2', '4', '1', '3', '1250', '50', '20', '30');
INSERT INTO PlayInfo values('d', '2', '4', '1.5', '2', '4', '1', '3', '2000', '35', '10', '55');


/*
 * 칼로리 
 * 
 *  55~65 -> 122kcal
 * 65~75 -> 142kcal
 * 75~85 -> 162kcal
 * 85~ -> 183kcal
 * 
 * 뛴 거리 
 * 
 * */


/*테이블 전체 데이터 보기 원할 때*/
SELECT * FROM CoachSignUpInfo;
SELECT * FROM PlayerSignUpInfo;
SELECT * FROM PlayInfo;

/*데이터 전체 삭제 원할 때*/
delete from PlayInfo;

/*테이블 자체 삭제 원할 때*/
drop table PlayerSignUpInfo;

/*DB에 있는 모든 테이블 출력*/
SHOW TABLES;

/*테이블 내  조회시*/
DESC PlayInfo;




/*PlayerSignUpInfo의 이름과 PlayerInfo의 maxSpeed와 totalDistance*/

