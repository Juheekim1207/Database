--연습용 테이블 생성
CREATE TABLE sawon (
    num number(5) constraint sawon_pk_num primary key,
    name varchar2(20),
    buseo varchar2(20) default '교육부',
    age number(5),
    pay number(10),
    ipsaday date
);
--시퀀스 생성
CREATE SEQUENCE seq_sawon NOCACHE;

--데이터 추가
INSERT INTO sawon VALUES(
    seq_sawon.nextval, '강호동', '홍보부', 34, 6700000, '2017-12-11');
INSERT INTO sawon (
    num, name, age, pay, ipsaday
) VALUES(seq_sawon.nextval, '이지영', 28, 3400000, SYSDATE);
INSERT INTO sawon VALUES(
    seq_sawon.nextval, '유재석', '인사부', 45, 5600000, '2018-03-19');
INSERT INTO sawon VALUES(
    seq_sawon.nextval, '이지니', '교육부', 25, 2800000, '2021-10-12');
INSERT INTO sawon VALUES(
    seq_sawon.nextval, '박제니', '홍보부', 41, 5500000, '2019-12-30');
INSERT INTO sawon VALUES(
    seq_sawon.nextval, '강백호', '인사부', 38, 4780000, '2020-05-06');
    
--커밋(변경사항 저장) opp ROLLBACK(변경사항 취소)
--DML(insert/delete/update) 조작명령 실행 후 반드시 처리해야한다.
COMMIT;
    
    
--수정연습

--강호동의 부서를 인사부로, 나이를 34에서 35로 수정
UPDATE sawon
SET buseo = '인사부',
    age = 35;
--실수로 where조건 누락(6개 업데이트)
--1	강호동	인사부	35	6700000	17/12/11
--2	이지영	인사부	35	3400000	22/04/11
--3	유재석	인사부	35	5600000	18/03/19
--4	이지니	인사부	35	2800000	21/10/12
--5	박제니	인사부	35	5500000	19/12/30
--6	강백호	인사부	35	4780000	20/05/06
ROLLBACK;   -- 이미 커밋한 건은 취소불가 

UPDATE sawon
SET   buseo = '인사부',
      age = 35
WHERE name = '강호동';

--박제니의 입사일을 2020-12-29일로 수정
UPDATE sawon
SET   ipsaday = '2020-12-29'
WHERE name = '박제니';


--삭제
DELETE FROM sawon
WHERE num = 3;

ROLLBACK;
--COMMIT;
    
--확인
SELECT * FROM sawon ORDER BY num;

--부서별 인원수와 평균나이 평균 연봉 구하기(순서는 부서의 오름차순)
SELECT  buseo 부서명, COUNT(buseo) 인원수, 
        FLOOR(AVG(age)) 평균나이, TO_CHAR(AVG(pay), 'L9,999,999') 평균연봉 
FROM sawon
GROUP BY buseo
ORDER BY 부서명;

--서브쿼리 연습

--최대 급여를 받는 사람의 이름과 나이와 부서, 급여를 출력하시오
SELECT name, age, buseo, pay
FROM sawon
WHERE pay = (SELECT MAX(pay) FROM sawon);

--평균 급여보다 많이 받는 사람의 이름과 나이, 부서, 급여를 출력하시오
SELECT name, age, buseo, pay
FROM sawon
WHERE pay > (SELECT AVG(pay) FROM sawon);    

--평균급여는?

--조건을 나타내는 함수

--부서가 홍보부면 '용산', 교육부면 '강남', 인사부변 '여의도'
SELECT  name 사원명, buseo 부서명,
        DECODE(buseo, '홍보부','용산','교육부','강남','인사부','여의도') 사무실위치
FROM sawon;

--CASE WHEN
SELECT  name 사원명, buseo 부서, pay 월급여,
    CASE WHEN pay >= 6000000 THEN '초고연봉'
         WHEN pay >= 5000000 THEN '고연봉'   
         WHEN pay >= 6000000 THEN '평균연봉'
         ELSE '최저시급'
    END 분류
from sawon;
        
SELECT name,
    CASE WHEN name in ('강호동', '유재석', '박제니') THEN '그룹 A'
         WHEN name in ('이지영', '강백호') THEN '그룹 B'
         ELSE '그룹 C'
    END 그룹
FROM sawon;


--기존 테이블을 복사해서 새로운 테이블 생성
CREATE TABLE sawon_a AS SELECT * FROM sawon 
WHERE buseo = '홍보부';
--확인
SELECT * FROM sawon_a;

--나이가 35세 이상인 사원만 복사해서 sawon-b 테이블 생성
CREATE TABLE sawon_b AS SELECT * FROM sawon 
WHERE age >= 35;
--확인
SELECT * FROM sawon_b;



--확인
SELECT * FROM sawon ORDER BY num;
