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

--생성자 만들기
CREATE USER jjang052 IDENTIFIED BY 1234;
--connect role 안에는 create session권한이 들어가 있다.
GRANT CONNECT TO jjang052;

-- RESOURCE role 안에는 create table권한이 들어가 있다,
GRANT RESOURCE TO jjang052; 

--DBA라는 role안에는 웬만한 권한들은 다 들어가 있다.
GRANT CONNECT,RESOURCE,DBA TO jjang052;


--role을 정의할 수 있음
CREATE ROLE rolestudy;

GRANT CONNECT,resource,CREATE VIEW, CREATE synonym TO rolestudy;

--권한
SELECT * FROM user_sys_privs;
-- role 조회
SELECT * FROM user_role_privs;

CREATE USER jjang053 IDENTIFIED BY 1234; 
GRANT rolestudy TO jjang053;
-- 권한 회수
REVOKE rolestudy from jjang053;

DROP USER jjang053 CASCADE;


-- practice01
-- 다음 조건을 만족하는 SQL문을 작성해 보세요.             
-- ① SYSTEM 계정으로 접속하여 PREV_HW 계정을 생성해 보세요.             
-- ② 비밀번호는 ORCL로 지정합니다. 접속 권한을 부여하고 PREV_HW 계정으로 접속이 잘되는 지 확인해 보세요.

CREATE USER PREV_HW IDENTIFIED BY ORCL;
GRANT rolestudy TO PREV_HW;



--practice02
--SCOTT 계정으로 접속하여 위에서 생성한 PREV_HW 계정에 
--SCOTT 소유의 EMP, DEPT, SALGRADE 테이블에 
--SELECT 권한을 부여하는 SQL문을 작성해 보세요. 
--권한을 부여했으면 PREV_HW 계정으로 SCOTT의 EMP, DEPT, SALGRADE 테이블이 잘 조회되는지 확인해 보세요.




