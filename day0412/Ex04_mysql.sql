-- [mysql 함수]

-- 오라클에서는 2개 이하만 적용   
select concat('Happy', 'Day', '!!');

select replace('Happy Day', 'Happy', 'Nice');
select instr('happy', 'a'); -- 2(인덱스 번호)
select instr('happy', 'k'); -- 0(없으면)

-- 일정갯수 가져오기
select left('abcdefg', 4);				-- abcd
select mid('abcdefghijklmn', 8, 4);		-- hijk
select right('abcdefghijklmn', 4);      -- klmn 

-- select substr(str, pos, len) : str(원본문자열), pos(시작위치값), len(가져올 길이값)
select substr('동해물과백두산이', 5); 		-- 5번째부터 읽기
select substr('동해물과백두산이', 5, 3); 	-- 5번째부터 3개 글자읽기

select right('have a nice day', 4) from dual;
select left('아이고 반가워라~', 3) from dual;
select lower('hAppY'), upper('hAppY') from dual;
select round(2.5,  0);    -- 반올림
select round(2.46, 1);
select truncate(2.46, 1); -- 반내림 
select floor(2.9);		  -- 무조건 내림	
select ceil(2.1);		  -- 무조건 올림	
    
-- 테이블 생성
create table bitclass (
	idx 	smallint primary key,
	class 	varchar(30),
	price 	int,
	gigan 	smallint
);   

create table stu (
	num 	  smallint auto_increment primary key,
	name 	  varchar(20),
	idx 	  smallint,
	sugangday date,
	constraint stu_fk_idx foreign key(idx) references bitclass(idx)
);
    
-- 데이터 삽입    
insert into bitclass values (100, 'Java',   110000, 10);  
insert into bitclass values (200, 'HTML5',   90000,  8);  
insert into bitclass values (300, 'JQuery', 130000, 12);  
insert into bitclass values (400, 'Oracle', 180000, 20);  
    
insert into stu (name, idx, sugangday) values ('kim', 200, now());  
insert into stu (name, idx, sugangday) values ('lee', 100, now());   
insert into stu (name, idx, sugangday) values ('son', 300, now());   
insert into stu (name, idx, sugangday) values ('min', 400, now());   

select * from bitclass;
select * from stu;

-- 조인  
-- join 1  
select * 
from bitclass bc, stu
where bc.idx = stu.idx;

-- join 2
select name, class, price, gigan, sugangday 
from bitclass bc, stu
where bc.idx = stu.idx;

-- join 3
select name, class, price, gigan, sugangday 
from bitclass bc
inner join stu 
on bc.idx = stu.idx;