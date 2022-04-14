--시퀀스 란? 
--시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성
--PRIMARY KEY 값을 생성하기 위해 사용(중복 제거)


CREATE SEQUENCE seq1;                               -- 1부터 1씩증가
--UI 시퀀스 폴더에서 확인

CREATE SEQUENCE seq2 START WITH 1  INCREMENT BY 1;   -- 1 부터 1씩증가
CREATE SEQUENCE seq3 START WITH 10 INCREMENT BY 5;   -- 10부터 시작 5씩 증가
CREATE SEQUENCE seq4 NOCACHE;                        -- 1 부터 1씩증가 cache사이즈 0
CREATE SEQUENCE seq5 MAXVALUE 5 CYCLE NOCACHE;       -- 5까지 증가되면 다시 1로~(기본키로는 못쓴다)     

--cache(메모리) 옵션이 20개씩 시퀀스 번호를 생성하도록 설정되어 있다면 
--한번에 1부터 20까지 시퀀스 번호를 생성한다. 
--이 상태에서 DB를 중지하고 재시작 시키면 메모리에 있던 20번까지의 시퀀스가 삭제되고
--21번부터 40번까지 메모리에 시퀀스 번호가 저장되기 때문에 
--이런 경우에 1, 21, 41로 시퀀스 번호가 증가될 수 있다.

--시퀀스 제거
DROP SEQUENCE seq4;

--전체 시퀀스 확인
SELECT * FROM seq;

--시퀀스값 출력
SELECT seq2.nextval from dual;
SELECT seq3.nextval from dual;  --5씩 증가
SELECT seq5.nextval from dual;  --1~5 순회

--시퀀스 제거
drop SEQUENCE seq5;

