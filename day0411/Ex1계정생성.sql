-- 연습용 계정 생성

--계정명이 angel, 비번이 a1234인 계정 생성(12C부터는 C##계정명)
--create use c##angel identified by a1234;
--alter session set "_ORACLE_SCRIPT" = true;

CREATE USER angel IDENTIFIED BY a1234; 

--cmd sqlplus에서
--Enter user-name: angel
--Enter password:
--ERROR:
--ORA-01045: user ANGEL lacks CREATE SESSION privilege; logon denied

--권한이 필요!
--angel 계정에 connect, resource 권한(기본)주기
GRANT CONNECT, RESOURCE TO angel;
--cmd 접속확인

--angel 계정의 두가지 권한 다시 뺏기
REVOKE CONNECT, RESOURCE FROM angel;
--cmd 접속확인

--angel 계정 제거(데이터가 있다면 모두 삭제)
DROP USER angel;

--bitcamp/a1234 계정을 생성 후 기본 권한을 주세요
CREATE USER bitcamp IDENTIFIED BY a1234;
GRANT CONNECT, RESOURCE TO bitcamp;

--bitcamp 계정에 권한 추가
GRANT CREATE VIEW TO bitcamp;

--SQL Developer 접속

