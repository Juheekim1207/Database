--상품을 주문한 사람이 있는 상태에서 상품을 삭제해보자
DELETE FROM shop WHERE idx = 1;
--integrity constraint (BITCAMP.JUMUN_FK_IDX) violated - child record found
--삭제하려면 1번 주문정보를 모두 삭제해야 가능
--게시판 게시글의 댓글 : 댓글을 모두 삭제해야 게시글 삭제 가능

-- 위 문제를 해결하려면? 자동으로 지워지게 할 수 있을까?

----------------------------------------------------------------------------

--부모테이블(음식목록)
--food
--
--   idx         number(5)   기본키
--   foodname    varchar2(20) 음식명
--   price       number(7)    가격
--  
--자식테이블(음식주문)
--foodjumun
--   num       number(5)    기본키
--   name      varchar2(20)  주문자
--   idx       number(5)     외부키로 설정
--   time      date          예약시간

create table food (
    idx         number(5)       constraint food_pk_idx primary key,
    foodname    varchar2(20)    not null,
    price       number(7)       not null
);

create table foodjumun (
    num         number(5) constraint foodjumun_pk_num primary key,
    name        varchar2(20),
    idx         number(5),
    foodtime    date,
    CONSTRAINT foodjumun_fk_idx FOREIGN KEY(idx) REFERENCES food(idx) ON DELETE CASCADE
);
--ON DELETE CASCADE : 부모 테이블의 데이터를 지우면 자식테이블의 데이터가 자동으로 지워진다.

--사용할 시퀀스 생성
CREATE SEQUENCE seq_food START WITH 1 INCREMENT BY 1 NOCACHE;

--food 테이블에 데이터 넣기
insert into food values(10, '봉글레스파게티', 17000);
--value too large for column "BITCAMP"."FOOD"."FOODNAME" (actual: 21, maximum: 20) 길이초과
--food의 foodname을 넉넉히 50 바이트로 변경
ALTER TABLE food
MODIFY foodname varchar2(50);

insert into food values(10, '봉글레스파게티', 17000);
insert into food values(20, '새우볶음밥', 11000);
insert into food values(30, '된장찌개', 8000);
insert into food values(40, '그림스파게티', 12000);
insert into food values(50, '짜장면', 8000);
insert into food values(60, '순두부찌개', 9000);

--음식 주문 테이블에 데이터 넣기
insert into foodjumun values(seq_food.nextval, '유재석', 20, '2022-04-15');
insert into foodjumun values(seq_food.nextval, '강호동', 10, '2022-05-10');
insert into foodjumun values(seq_food.nextval, '이영자', 50,  sysdate);
insert into foodjumun values(seq_food.nextval, '유진',   60, '2022-04-10');
insert into foodjumun values(seq_food.nextval, '한지혜', 20, '2022-03-15');

ROLLBACK;
COMMIT;

--확인
select * from food;
select * from foodjumun;


--join(오라클)
select 
        name 주문자, 
        foodname 음식명, 
        price 가격, 
        to_char(food_time, 'yyyy-mm-dd') 예약일
from    food, foodjumun
where   food.idx = foodjumun.idx;

--join(ANSI)
SELECT 
        name 주문자, 
        foodname 음식명, 
        price 가격, 
        to_char(food_time, 'yyyy-mm-dd') 예약일
FROM    food INNER JOIN foodjumun
ON      food.idx = foodjumun.idx;

--join(Outer) : foodjumun에 없는 데이터 출력(아무도 주문하지 않은 음식)
SELECT  
        foodname "인기없는 음식명"
FROM    food, foodjumun
WHERE   food.idx = foodjumun.idx(+) and num is null;

--null 이 나온 데이터는 food에 있으나 foodjumun에 없는 데이터
SELECT  
        *
FROM    food, foodjumun
WHERE   food.idx = foodjumun.idx(+);


--삭제하기

--food에서 idx가 20인 음식을 삭제시 foodjumun 확인하기
DELETE 
FROM food 
WHERE idx = 20;

