--연습용 간단한 테이블 생성

--primary key 기본키 : not null + unique
CREATE TABLE test(
    idx     NUMBER(5) PRIMARY KEY,
    name    VARCHAR2(20) NOT NULL,
    age     NUMBER(3),
    email   VARCHAR2(20) UNIQUE
    ); 
    
--테이블 기본 구조확인
DESC test;

--데이터 추가
INSERT INTO test (
    idx, 
    name, 
    age, 
    email
) values(
    1, 
    'lee', 
    12, 
    'aaa@naver.com'
);

--전체 컬럼 데이터 추가 시 컬럼명은 생략가능
INSERT INTO test values(
    2, 
    'kim', 
    23, 
    'kim@nate.com'
);

--idx 값을 넣지 않을 경우 오류확인
INSERT INTO test (
    name, 
    age 
) values( 
    'park', 
    30
); --ORA-01400: cannot insert NULL into ("BITCAMP"."TEST"."IDX")

--idx에 중복값을 넣었을 경우
INSERT INTO test (
    idx, 
    name,
    age
) values(
    2,
    'park', 
    30
); 
--ORA-00001: unique constraint (BITCAMP.SYS_C007022) violated
--UI로부터 테이블(TEST) '제약조건'탭 제약조건ID(SYS_C007022) 확인

--email에 unique 위배 시
INSERT INTO test (
    idx, 
    name,
    email
) values(
    3,
    'shin', 
    'kim@nate.com'
); 
--ORA-00001: unique constraint (BITCAMP.SYS_C007022) violated

--데이터 확인
SELECT * FROM test;

--test 테이블 제거 후 UI reflash
DROP TABLE test; 

--위의 test 테이블을 제약조건명을 주면서 다시 생성해보자
CREATE TABLE test(
    idx     NUMBER(5)       CONSTRAINT test_pk_idx      PRIMARY KEY,
    name    VARCHAR2(20)    CONSTRAINT test_nn_name     NOT NULL,
    age     NUMBER(3),
    email   VARCHAR2(20)    CONSTRAINT test_uq_email    UNIQUE
); 

--데이터 추가
INSERT INTO test values(
    1, 
    'aaa', 
    11, 
    'aaa@naver.com'
);

--idx 오류 확인해보기
INSERT INTO test (
    idx, 
    name
) values(
    1,
    'bbb'
); 
--ORA-00001: unique constraint (BITCAMP.TEST_PK_IDX) violated

--email 오류 확인해보기
INSERT INTO test (
    idx, 
    name,
    email
) values(
    2,
    'bbb',
    'aaa@naver.com'
); 
--ORA-00001: unique constraint (BITCAMP.TEST_UQ_EMAIL) violated

--name 오류 확인해보기(not null 제약조건 생략 가능)
INSERT INTO test (
    idx,
    age,
    email
) values(
    2,
    12,
    'bbb@naver.com'
); 
--ORA-01400: cannot insert NULL into ("BITCAMP"."TEST"."NAME")

--제약조건의 추가/제거
--email의 TEST_UQ_EMAIL 제거
--               ADD  CONSTRAINT
ALTER TABLE test DROP CONSTRAINT TEST_UQ_EMAIL;

--같은 이메일을 넣기 가능
INSERT INTO test (
    idx,
    name,
    email
) values(
    2,
    'bbb',
    'aaa@naver.com'
); 

--컬럼 추가하기(수정은 무조건 ALTER)
ALTER TABLE test ADD blood VARCHAR2(10);

--컬럼 추가시 초기값 지정하기
ALTER TABLE test ADD addr VARCHAR2(50) DEFAULT '서울';

--컬럼 타입 수정
ALTER TABLE test MODIFY addr VARCHAR2(100);

--컬럼 데이터 타입 수정 불가(기존 저장 데이터 변경 불가)
ALTER TABLE test MODIFY age VARCHAR2(5);
--01439. 00000 -  "column to be modified must be empty to change datatype"

--컬럼 제거(저장 데이터도 삭제)
ALTER TABLE test DROP COLUMN blood;

--컬럼명 변경 : addr->address
ALTER TABLE test RENAME COLUMN addr TO address;

--컬럼명 변경 : age->nai
ALTER TABLE test RENAME COLUMN age TO nai;

--문1)score 라는 컬럼 추가 타입은 number(5), 초기값은 50으로
ALTER TABLE test ADD score NUMBER(5) DEFAULT 50;

--문2)score 라는 컬럼명 변경 score->jumsoo로
ALTER TABLE test RENAME COLUMN score TO jumsoo;

--문3)idx 의 컬럼 길이를 5에서 10으로 변경
ALTER TABLE test MODIFY idx NUMBER(10);
--같은 자료형만 가능
--다른 자료형 : "column to be modified must be empty to change datatype"


--데이터 확인
SELECT * FROM test;

--테이블 구조 확인
DESC test;

--테이블 제거
DROP TABLE test;


