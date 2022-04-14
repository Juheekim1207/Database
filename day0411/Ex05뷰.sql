-- 뷰(VIEW) : 데이터를 저장하고 있지는 않지만 DML 작업이 가능한 가상의 테이블

--복잡한 쿼리는 view에 저장하여 사용
--뷰는 복잡한 쿼리를 단순화 시킬수 있다.
--뷰는 사용자에게 필요한 정보만 접근하도록 접근을 제한할 수 있다.

--CREATE 만 쓴 경우: 새로 생성만 가능, 같은 이름이 있는 경우 오류발생 
--CREATE OR REPLACE VIEW를 쓴 경우: 새로 생성을 하는데 같은 이름이 있는 경우 덮어쓴다
CREATE OR REPLACE VIEW mycart
AS
SELECT
      j.num, j.name, s.sangpum, s.color, s.price, j.cnt, s.ipgoday
FROM  shop s, jumun j
WHERE s.idx = j.idx; 
--오류발생(권한이 없어서...system에 가서 bitcamp에 create view에 관한 권한을 추가한다)

--view 조회
SELECT * FROM mycart;



CREATE OR REPLACE VIEW v_emp 
AS
    SELECT empno
         , ename
         , job
         , hiredate
      FROM emp;

      
CREATE OR REPLACE VIEW v_emp 
AS
    SELECT a.empno
         , a.ename
         , a.job
         , TO_CHAR(a.hiredate, 'YYYY-MM-DD') AS hiredate
      FROM emp a
         , dept b
     WHERE a.deptno = b.deptno;      
     
--뷰 컬럼 코멘트 추가
COMMENT ON COLUMN v_emp.empno IS '사원번호';

--뷰 삭제
DROP VIEW v_emp;

--컬럼 별칭 선언
CREATE OR REPLACE VIEW v_emp 
(
    empno,
    ename,
    job,
    hiredate
)
AS
    SELECT a.empno
         , a.ename
         , a.job
         , TO_CHAR(a.hiredate, 'YYYY-MM-DD')
      FROM emp a
         , dept b
     WHERE a.deptno = b.deptno;
          
--WITH READ ONLY 옵션 사용
CREATE OR REPLACE VIEW v_emp 
AS
    SELECT empno
         , ename
         , job
         , hiredate
      FROM emp
      WITH READ ONLY; 
     
     
     