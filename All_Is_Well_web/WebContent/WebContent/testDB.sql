select id, name from playerSignUpInfo;

delete from playerSignUpInfo where id ='hangil';

select mainPosition from playerSignUpInfo;

select COUNT(*) from ki;

select play_id from ki;

desc coachSignUpInfo;

select * from playerSignUpInfo;
select * from coachSignUpInfo;

UPDATE playerSignUpInfo SET  technic = 90 where id = 'ki';
UPDATE coachSignUpInfo SET  team = 'pep' where id = 'pep';

delete from playerSignUpInfo where id = 'DBtest2'; 

select team from coachSignUpInfo where id = 'kwon';

desc playerSignUpInfo;

create table 'feedback'(
	'num'  int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	'title' varchar(50),
	'memo' varchar(500),
	'time' datetime comment,
	foreign key 'name' references playerSignUpInfo 'name'

)

