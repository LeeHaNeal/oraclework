-- 한줄 주석 (단축키 : ctrl + / )
/*
    여러줄 주석
    주석
    alt  + shift + c
*/

-- 나의 계정 보기
show user;

-- 사용자 계정 조회
SELECT * FROM DBA_USERS;

SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS;

--  사용자 만들기
-- 오라클 12버전부터 일반사용자는 c##(대소문자 안가림)으로 시작하는 이름을 가져야한다.
CREATE USER c##user1 IDENTIFIED BY 1234;

-- c##을 회피하는 방법
ALTER SESSION SET "_oracle_script" = true;

CREATE USER user1 IDENTIFIED BY 1234;

-- 사용할 계정 만들기
-- 계정명은 대소문자 상관없음
-- 비밀번호는 대소문자 가림
CREATE USER tjoeun IDENTIFIED BY 1234;

-- 권한 생성
-- [표현법] GRANT 권한1, 권한2, ... TO 계정명;
GRANT CONNECT TO TJOEUN;
GRANT  RESOURCE TO tjoeun;

-- insert시  '테이블 스페이스 users에 대한 권한이 없습니다. 오류일 때
ALTER USER tjoeun default tablespace users quota unlimited on users;
-- ALTER USER tjoeun quota 50M on users;

-- workbook사용자 만들기
ALTER SESSION SET "_oracle_script" = true;
CREATE USER workbook IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO workbook;
ALTER USER workbook default tablespace users quota unlimited on users;

-- scott사용자 만들기
ALTER SESSION SET "_oracle_script" = true;
CREATE USER scott IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO scott;
ALTER USER scott default tablespace users quota unlimited on users;

-- ddl사용자 만들기
ALTER SESSION SET "_oracle_script" = true;
CREATE USER ddl IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO ddl;
ALTER USER ddl default tablespace users quota unlimited on users;

-- tjoeun view 생성 권한
GRANT CREATE VIEW TO TJOEUN;

ALTER SESSION SET "_oracle_script" = true;
CREATE USER jsp IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO jsp;
ALTER USER jsp default tablespace users quota unlimited on users;

----
ALTER SESSION SET "_oracle_script" = true;
CREATE USER SEQ_VOTE IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO SEQ_VOTE;
ALTER USER SEQ_VOTE default tablespace users quota unlimited on users;

ALTER SESSION SET "_oracle_script" = true;
CREATE USER jsp2 IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO jsp2;
ALTER USER jsp2 default tablespace users quota unlimited on users;


ALTER SESSION SET "_oracle_script" = true;
CREATE USER mybatis IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO mybatis;
ALTER USER mybatis default tablespace users quota unlimited on users;

ALTER SESSION SET "_oracle_script" = true;
CREATE USER springboot IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO springboot;
ALTER USER springboot default tablespace users quota unlimited on users;

ALTER SESSION SET "_oracle_script" = true;
CREATE USER semi IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO semi;
ALTER USER semi default tablespace users quota unlimited on users;


