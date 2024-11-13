ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; 
--사용자는 만들어 졌음 하지만 db에 접속할 수 있는 권한은 없음...
CREATE USER orclstudy IDENTIFIED BY oracle;

--접속 권한 주기
GRANT CREATE SESSION TO orclstudy;

SELECT * FROM all_users;

--비밀번호 바꾸기...
ALTER USER orclstudy IDENTIFIED BY orcl; 

--사용자 삭제
DROP USER orclstudy;

--사용자가 가지고 있던 모든 객체들 한꺼번에 삭제
DROP USER orclstudy cascade;

--자기 아이디 가지고 사용자 만들어서 접속 해보기...
--확인하고 삭제

CREATE USER jjang051 IDENTIFIED BY 1234;
GRANT CREATE SESSION TO jjang051;
DROP USER jjang051 CASCADE;

-- 권한을 줄때는 grant 명령어를 쓴다. 하나씩 줘도 되고 
-- ,(컴마)를 통해 한꺼번에 부여를 해도 된다.
-- resource 권한에 tablespace 할당되었지만 12 버전 이후에 없어짐...
GRANT RESOURCE, CREATE SESSION , CREATE TABLE TO orclstudy;
--GRANT USER orclstudy DEFAULT TABLESPACE users quota unlimited ON users;

-- 아래 명령어를 통해 테이블 공간 할당...
ALTER USER orclstudy quota unlimited ON users;

--revoke는 권한을 뺏을때 쓴다.
REVOKE resource,CREATE TABLE FROM orclstudy;

REVOKE CREATE SESSION FROM orclstudy;



