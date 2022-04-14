-- [조인 Join]

--DB 정규화(Normalization)
--정규화란?
--한마디로 DB 서버의 메모리를 낭비하지 않기 위해서
--어떤 테이블을 식별자를 가지는 여러개의 테이블로 나누는 과정을 정규화라고 한다
--정규화된 데이타베이스는 중복이 최소화되도록 설계된 데이타베이스이다

--장단점

--장점
--메모리를 절약할수 있다
--구조화된 시스템으로 인해서 관리하기가 편하다
--단점
--조회비율이 높은 시스템의 경우에는 테이블간의 join 연산이 반복적으로 이뤄지기 때문에
--질의 응답 속도가 살짝 늦어질수 있다

--오라클 조인

--outer join : 조건에 일치하지 않아도 출 력
--self join  : 자신의 테이블과의 조인
--equi join  : 기본키(primary key) 와 외부키(foreign key) 를 사용하여 join,
--             일치할때만 조회(** 제일 많이 사용)
--Ansi 조인
--     ms-sql,db1 같은 오라클이 아닌 환경에서도 사용이 가능한 표준화된 조인
--     cross 조인,natural 조인, outer join,self join … 등등



--[shop 테이블]
--idx         number(5) primary key   : 고유값
--sangpum     varchar2(20)            : 상품명
--color       varchar2(20)            : 색상
--price       number(10)              : 단가
--ipgoday     date                    : 입고일


--[jumun 테이블]
--num         number(5) primary key   : 고유값
--name        varchar2(20)            : 주문자
--idx(shop)   number(5)               : shop의 외부키(FOREIGN KEY)
--cnt         number(5)               : 갯수

--실습 테이블 생성

CREATE TABLE shop (
    idx         number(5) CONSTRAINT shop_pk_idx primary key,
    sangpum     varchar2(20),
    color       varchar2(20),
    price       number(10),
    ipgoday     date
);
--jumun 테이블 생성(shop의 idx를 외부키로 사용)
CREATE TABLE jumun (
    num         number(5) CONSTRAINT jumun_pk_num PRIMARY KEY,
    name        varchar2(20),
    idx         number(5) CONSTRAINT jumun_fk_idx REFERENCES shop(idx),
    cnt         number(5)
);

--상품용 시퀀스 새로 생성
CREATE SEQUENCE seq_shop NOCACHE;

--shop에 상품 등록
INSERT INTO shop VALUES (
    SEQ_SHOP.nextval, '블라우스', 'white', 23000, sysdate);
INSERT INTO shop VALUES (
    SEQ_SHOP.nextval, '청바지', 'blue', 47000, '2022-03-20');
INSERT INTO shop VALUES (
    SEQ_SHOP.nextval, '브이넥티', 'pink', 16000, sysdate);
INSERT INTO shop VALUES (
    SEQ_SHOP.nextval, '체크남방', 'red', 17000, '2021-12-25');
INSERT INTO shop VALUES (
    SEQ_SHOP.nextval, '블라우스', 'yellow', 19500, '2021-03-29');

COMMIT;



--jumun 테이블에 데이터 추가하기
--없는 shop제품을 등록시 어떤 오류가 출력되는지 확인
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '이영자', 3, 1);
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '유재석', 6, 2); --6번 제품은 shop에 없음.
      --integrity constraint (BITCAMP.JUMUN_FK_IDX) violated - parent key not found    
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '유재석', 4, 3); 
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '한가인', 5, 2);
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '김태희', 2, 1);  
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '김종국', 3, 3); 
INSERT INTO jumun VALUES (
        SEQ_SHOP.nextval, '이제니', 1, 1);  
        
COMMIT;        

--상품조회
SELECT * FROM shop;

--주문조회
SELECT * FROM jumun;

--join 해서 출력(일치하는 행 출력)
SELECT
      j.num, j.name, s.sangpum, s.color, s.price, j.cnt, s.ipgoday
FROM  shop s, jumun j
WHERE s.idx = j.idx;

--컬럼명 앞에 테이블명은 어느 한쪽만 존재하는 경우 생략이 가능
SELECT
      num, name, sangpum, color, price, cnt, ipgoday
FROM  shop s, jumun j
WHERE s.idx = j.idx; --양쪽 동일 컬럼명일 경우 식별

--상품을 주문한 사람이 있는 상태에서 상품을 삭제해보자
DELETE FROM shop WHERE idx = 1;
--integrity constraint (BITCAMP.JUMUN_FK_IDX) violated - child record found
--삭제하려면 1번 주문정보를 모두 삭제해야 가능
--게시판 게시글의 댓글 : 댓글을 모두 삭제해야 게시글 삭제 가능