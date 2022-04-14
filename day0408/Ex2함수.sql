
--[그룹함수 연습 : min, max, sum, avg, count]

--emp테이블의 총 개수
select count(*) count from employees;

--salary의 총합과 평균 구하기
select sum(salary), avg(salary) from employees;             --소수점이하가 너무 많다
select sum(salary), round(avg(salary), 0) from employees;   --반올림
select sum(salary), floor(avg(salary)) from employees;      --내림
select sum(salary), ceil(avg(salary))  from employees;      --올림

--salary의 최고연봉과 최저연봉
select min(salary) 최저연봉, max(salary) 최고연봉 from employees;

-- [서브쿼리 사용]
--salary의 최저연봉을 받는 사람의 이름과 연봉을 출력하시오
select first_name, salary
from employees
where salary = (select MIN(salary) from employees); --최저연봉은 바뀔 수 있는 값이므로

--평균 연봉보다 많이 받는 사람의 이름(first+last)과 연봉을 출력하시오
select first_name||' '||last_name name, salary
from employees
where salary > (select AVG(salary) from employees);

--first_name 이 Bruce와 같은 직업을 가진 사람 출력(first_name, job_id 출력)
select first_name, job_id
from employees
where job_id = (select job_id 
                from employees 
                where first_name = 'Bruce');

--select/from/where/group by/having/order by
--직업별 인원수와 평균 연봉 구하기
SELECT  job_id 직업, 
        count(*) 인원수, 
        round(avg(salary), 0) 평균연봉
from employees
GROUP BY job_id;
--위와 같은데 평균 연봉이 높은 순서대로 출력(3번 열(평균연봉) 기준)
SELECT  job_id 직업, 
        count(*) 인원수, 
        round(avg(salary), 0) 평균연봉
from employees
GROUP BY job_id
ORDER BY 3
DESC;
--위와 같은데 인원수가 많은 그룹부터 출력
SELECT  job_id 직업, 
        count(*) 인원수, 
        round(avg(salary), 0) 평균연봉
from employees
GROUP BY job_id
ORDER BY 2 --두번째 열(인원수)
DESC;
--위와 같은데 인원수 5인 이상인 곳만 출력
SELECT  job_id 직업, 
        count(*) 인원수, 
        round(avg(salary), 0) 평균연봉
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5
ORDER BY 2 
DESC;

--[JOIN]
--join을 이용해서 first_name과 department_id를 이용해서 부서명 조회
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--위의 sql문에서 서로 중복되지 않은 컬럼명은 앞에 테이블명 생략 가능
SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--날짜에 관한 함수들 연습(dual로 연습)
-- ▶ Dual 테이블
-- dual 테이블은 사용자가 함수(계산)를 실행할 때 임시로 사용하는데 적합하다.
-- 함수에 대한 쓰임을 알고 싶을때 특정 테이블을 생성할 필요없이 
-- dual 테이블을 이용하여 함수의 값을 리턴(return)받을 수 있다.

select sysdate from dual;                                           --오늘
select sysdate + 1 from dual;                                       --현재날짜기준 다음날
select sysdate + 7 from dual;                                       --현재날짜기준 일주일 뒤

--현재 날짜에서 년도 4자리만 추출
select TO_CHAR(sysdate, 'YYYY') from dual;                          --2022
select TO_CHAR(sysdate, 'yyyy') from dual;                          --2022
select TO_CHAR(sysdate, 'YY') from dual;                            --22
select TO_CHAR(sysdate, 'YEAR') from dual;                          --문자열

--현재 날짜에서 월 2자리만 추출
select TO_CHAR(sysdate, 'MM') from dual;                            --04

--현재 날짜를 날짜와 시간으로 표시
select TO_CHAR(sysdate, 'yyyy-mm-dd HH24:MI') from dual;            --2022-04-08 15:40
select TO_CHAR(sysdate, 'yyyy-mm-dd am HH24:MI') from dual;         --2022-04-08 오후 15:41
select TO_CHAR(sysdate, 'yyyy-mm-dd pm HH24:MI') from dual;         --2022-04-08 오후 15:41

--emp테이블에서 first_name과 hire_date를 출력하는데 hire_date는 yyyy-mm-dd 형식으로 출력
select first_name name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date from employees;

--hire_date에서 년도를 추출해서 2006년에 입사한 사람을 조회(first_name, hire_date)
SELECT first_name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2006';

--hire_date에서 년도를 추출해서 5월에 입사한 사람을 조회(first_name, hire_date)
SELECT first_name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'mm') = '05';                          --WHERE TO_CHAR(hire_date, 'mm') = 5; 에러발생

--마지막 컬럼에 입사 년차를 출력(현재년도-입사년도)
SELECT  first_name, 
        TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date,
        TO_CHAR(sysdate, 'yyyy') - TO_CHAR(hire_date, 'yyyy') 입사년차 
FROM employees;

--[숫자함수 연습]
select ABS(-5), ABS(5) from dual;                               --절대값
select ROUND(23.45, 1) from dual;                               --23.5
select ROUND(23.43, 1) from dual;                               --23.4
select ROUND(4567893, -1) from dual;                            --10원   단위까지만 출력(반올림) 4567890
select ROUND(4567893, -2) from dual;                            --100원  단위까지만 출력(반올림) 4567900
select ROUND(4567893, -3) from dual;                            --1000원 단위까지만 출력(반올림) 4568000
select TRUNC(4567893, -3) from dual;                            --1000원 단위까지만 출력(반내림) 4567000

select MOD(10, 3) from dual;                                    --1 :10을 3으로 나눈 나머지
select POWER(2, 3) from dual;                                   --8 : 2의 3승

--[문자열 처리 함수 연습]
select CONCAT('hello', 'kitty') from dual;                      --hellokitty
select 'hello'||'kitty' from dual;                              --hellokitty

select INITCAP('haPPy dAY') from dual;                          --Happy Day
select LOWER('haPPy dAY') from dual;                            --happy day
select UPPER('haPPy dAY') from dual;                            --HAPPY DAY

select LPAD('3500', 10, '*') from dual;                         --******3500 :10자리 중 남은 자리수만큼 왼쪽으로별표
select RPAD('3500', 10, '*') from dual;                         --3500****** :10자리 중 남은 자리수만큼 오른쪽으로 별표

select SUBSTR('happy day', 3, 3) from dual;                     --ppy :3번째 글자부터 3개 추출
select SUBSTR('happy day', -3, 3) from dual;                    --day :뒤에서 3번째 글자부터 3개 추출

select LENGTH('happy day') from dual;                           --9 :공백 포함 길이
select REPLACE('Have a Nice Day', 'a', '*')       from dual;    --H*ve * Nice D*y :모든 a를 *로  변경
select REPLACE('Have a Nice Day', 'Nice', 'Good') from dual;    --Have a Good Day :Nice를 Good로 변경




