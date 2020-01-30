/*회원가입시 필요한 정보들*/

CREATE TABLE PlayerSignUpInfo(  /*선수 모드*/
 
	id int NOT NULL AUTO_INCREMENT, /*아이디*/
	
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
		
	PRIMARY KEY(id)
	
);

/*테이블 전체 데이터 보기 */
SELECT * FROM CoachSignUpInfo;

/*데이터 전체 삭제 */
delete from CoachSignUpInfo;





