-- [mysql]

-- cmd
-- mysql -u root -p
-- 1234
-- mysql> status
-- mysql> show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | mysql              | * 건드리면 안됨!
-- | performance_schema |
-- | test               |
-- +--------------------+

-- mysql> use test;
-- Database changed
-- mysql> show tables;
-- Empty set (0.00 sec)

-- mysql> create database bit901;
-- mysql> create database bitcamp;
-- mysql> show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | bit901             |
-- | bitcamp            |
-- | mysql              |
-- | performance_schema |
-- | test               |
-- +--------------------+

-- mysql> use bitcamp;
-- Database changed
-- mysql> status;

SELECT now() FROM dual;
SELECT current_timestamp() FROM dual;
SELECT year(now()) FROM dual;
SELECT month(now()) FROM dual;
SELECT monthname(now()) FROM dual;
SELECT dayname(now()) FROM dual;
SELECT dayofmonth(now()) FROM dual;
SELECT date_format(now(), 'yyyy-mm-dd') FROM dual;
SELECT date_format(now(), '%Y%m%d') from dual; 
SELECT date_format(now(), '%Y-%m-%d') from dual; 

CREATE TABLE test01 (
	num 		tinyint auto_increment primary key,
    name 		varchar(20), 
    age 		smallint,
    height 		decimal(5,1),
   	birthday 	datetime, 
   	ipsaday 	date
);

DESC test01;

-- mysql은 자동커밋함(autocommit)
INSERT INTO test01 (
		name,age,height,birthday,ipsaday) 
VALUES ('kim',23,167.8,'1989-12-12','2020-10-10');


create table student (
	num 		smallint auto_increment primary key,
	name 		varchar(20),
	hp 			varchar(20),
	birthday 	date
);

insert into student (name, 		hp, 			 birthday) values
					('이미자', '010-1234-5678',  now());
insert into student (name, 		hp, 			 birthday) values
					('강호동', '010-3333-4444', '1980-12-12');				
insert into student (name, 		birthday) values
					('유재석', '1978-03-12');	

-- 테이블 수정 

-- score    컬럼 추가하기
alter table student add score smallint default 10;

-- birthday 컬럼 삭제
alter table student drop column birthday;

-- name을 varchar(30)으로 수정
desc student;
alter table student modify name varchar(30);
desc student;
				
-- hp컴럼명을 phone로 변경
-- 5버전
alter table student change hp phone varchar(20);
-- 8버전
alter table student rename column hp to phone;

-- 오라클의 NVL이 mysql에서는 ifnull
select num, name, phone from student;
select num, name, ifnull(phone, '핸드폰없음') phone from student;

-- 삭제
delete from student where name = '유재석';

-- 점수 수정
update student 
set score = 80
where name = '이미자';

update student 
set score = 60
where name = '강호동';

-- 데이터 추가
insert into student (name, phone, score) values ('송혜교', '010-1111-2222', 100);
insert into student (name, phone, score) values ('송승헌', '010-3333-2222', 78);
insert into student (name, phone, score) values ('김미자', '010-5555-2222', 89);
insert into student (name, phone, score) values ('김말자', '010-7777-2222', 56);

-- 그룹함수
select count(*) from student; 
select avg(score) from student;
-- 소수 한자리
select round(avg(score), 1) 평균점수 from student; 

-- 페이징 처리(limit 시작, 개수)
select * from student limit 0, 2;
select * from student limit 3, 2;

-- 조건함수
select name, phone, score, 
	if(score >= 90, '우등생', '노력하세요') 등급 
from student;

-- [group by 연습]
-- 컬럼추가
alter table student add gender varchar(20) default '남자';
-- 수정
update student 
set gender = '여자'
where name in ('이미자', '송혜교', '김미자', '김말자');

-- 남녀 그룹별로 인원수와 평균점수 구하기
select gender 성별, count(*) 인원수, round(avg(score), 1) 평균점수 
from student
group by gender;

-- 평균점수보다 더 높은 점수를 받은 사람의 전체 컬럼 조회
select * 
from student
where score > (select avg(score) from student);


select * from student;
