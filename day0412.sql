--join 연습용 테이블 생성 
--부모 테이블 : 음식 목록 

create table food (
    idx number(5) CONSTRAINT food_pk_idx PRIMARY KEY, --pk : PRIMARY KEY
    foodname VARCHAR2(20) not null, 
    price NUMBER(7) not null); 

--자식 테이블 : on delete cascade : 부모테이블의 데이터를 지우면 자식테이블의 데이터가 자동으로 지웓진다

create table foodjumun (
    num number(5) CONSTRAINT foodjumun_pk_num PRIMARY KEY,
    name VARCHAR2(20),
    idx number(5),
    foodtime date,
    CONSTRAINT foodjumun_fk_idx FOREIGN KEY(idx) REFERENCES food(idx) ON DELETE CASCADE);
    
--사용할 시퀀스 생성 
create SEQUENCE seq_food START WITH 1 INCREMENT by 1 NOCACHE;

--food의 foodname을 넉넉히 50bite로 변경
alter table food modify foodname VARCHAR2(50);

--food 테이블에 데이터 넣기
insert into food values (10,'봉골레스파게티',17000); 
insert into food values (20,'새우볶음밥',11000); 
insert into food values (30,'된장찌개',8000); 
insert into food values (40,'크림스파게티',12000); 
insert into food values (50,'짜장면',8000); 
insert into food values (60,'순두부찌개',9000); 

--확인
select * from food;

--음식 주문 테이블에 데이터 넣기
insert into foodjumun values (seq_food.nextval,'유재석',20,'2022-04-15');
insert into foodjumun values (seq_food.nextval,'강호동',10,'2022-05-10');
insert into foodjumun values (seq_food.nextval,'이영자',50,SYSDATE);
insert into foodjumun values (seq_food.nextval,'유진',60,'2022-04-10');
insert into foodjumun values (seq_food.nextval,'한지혜',20,'2022-03-15');
commit;

--확인
select * from food;
select * from foodjumun;

--join 
--방법 1
select name 주문자, foodname 음식명, price 가격, to_char(foodtime,'yyyy-mm-dd') 예약일
from food, foodjumun
where food.idx = foodjumun.idx;

--방법 2
select name 주문자, foodname 음식명, price 가격, to_char(foodtime,'yyyy-mm-dd') 예약일
from food inner join foodjumun
on food.idx = foodjumun.idx;

--outer join: foodjumun에 없는 food 데이터 : 아무도 주문하지 않은 음식을 알고 싶다
select foodname 인기없는음식 
from food,foodjumun
where food.idx = foodjumun.idx(+) and num is null; --(+) : 조건을 줄때

--null이 나온 데이터는 food에는 있는데 foodjumun에 없는 데이터 
select *
from food,foodjumun
where food.idx = foodjumun.idx(+) and num is null; 

--food에서 idx가 20인 음식을 삭제시 foodjumun도 확인하기 
delete from food where idx = 20;













