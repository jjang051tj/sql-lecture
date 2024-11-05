--  sys가 계정을 만들어줘야 db에 쓸 수 있다.
-- 원래 scott 계정은 default로 있었는데 삭제된 거 같습니다.
-- 계정 생성할때는 c##을 붙여하는데 모양이 보기 좋지 않다.

-- C##없애는 명령어는
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; 

-- scott 생성
CREATE USER scott IDENTIFIED BY tiger;

--사용자 삭제
DROP USER scott CASCADE;

--권한 부여 연결 권한 부여
GRANT CREATE SESSION TO scott;

-- 연결 및 리소스 사용 table 생성권한 부여
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;

--테이블 생성권한
GRANT CREATE TABLE TO scott;

-- sys에서 scott 생성됐는지 table확인
SELECT * FROM dba_users;




/*
ALTER USER scott IDENTIFIED BY tiger
ACCOUNT UNLOCK;
*/