SELECT * FROM dict;
SELECT * FROM dictionary;

-- scott이 만든 테이블 이름 검색
SELECT table_name FROM user_tables;

SELECT OWNER, TABLE_name FROM all_tables;

--dual은 아무나 쓸 수 있는 테이블 더미용 테이블  
SELECT OWNER, TABLE_name FROM all_tables 
WHERE table_name = 'DUAL';

-- scott 에게 dba권한을 주면 출력이 가능
SELECT * FROM dba_tables;

-- 책에서 특정 내용을 찾을 떄 색인 (index)을 사용하듯이 
-- 데이터 베이스도 빠른 검색을 위해서 index 설정을 한다.
-- 검색 속도가 빨라진다.
-- unique, null, primary 키 설정을 하면 자동으로 인덱스 설정이 된다.

SELECT * FROM user_ind_columns; 
--primary key 설정을 하면 (제약사항) 자동으로 index 생성됨...

--있다는거 정도만 알아두세요. 
CREATE INDEX idx_emp_sal ON emp(sal);
DROP INDEX idx_emp_sal;

-- view 객체
-- table masking
-- view 도 테이블이지만 읽기 전용 테이블

--sys에서 scott에게 view를 만들 수 있는 권한을 부여해야 한다.
CREATE VIEW view_emp20 AS 
(SELECT empno, ename,job,deptno FROM emp
WHERE DEPTNO = 20);

--scott이 가지고 있는 view를 조회
SELECT * FROM user_views;

SELECT * FROM view_emp20;

DROP VIEW view_emp20;

-- top-n  쿼리  
-- 게시판에 글이 300

-- rownum은 없는 컬럼인데 순서 메기기 위해 사용하는 가짜 컬럼 유사,
-- 의사 컬럼 pseudo column
SELECT ROWNUM AS no,e.* FROM emp e
ORDER BY sal DESC;

-- top-n 쿼리
-- 서브쿼리 이용
SELECT ROWNUM AS NO, e.* from
(SELECT * FROM emp
ORDER BY sal DESC) e
WHERE ROWNUM BETWEEN 1 AND 5;

-- 인라인 view
WITH e AS (SELECT * FROM emp ORDER BY sal desc)
SELECT ROWNUM,e.* FROM e;

-- view를 사용하는 방식
CREATE VIEW view_emp_sal_desc AS 
(SELECT * FROM emp) ORDER BY sal desc;

SELECT rownum AS no, v.* 
FROM view_emp_sal_desc v
WHERE rownum between 1 AND 5;


--sequence
--자동증가
--1,2,3,4,5,6,7,8

CREATE TABLE dept_seq AS 
SELECT * FROM DEPT d WHERE 1!=1;
SELECT * FROM dept_seq;

CREATE SEQUENCE seq_dept
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

SELECT * FROM user_sequences;
INSERT INTO dept_seq (deptno,dname,loc) VALUES 
(seq_dept.nextval,'WEB','SEOUL');


SELECT * FROM dept_seq;

--제일 마지막에 쓴 시퀀스
SELECT seq_dept.currval FROM dual;


CREATE SEQUENCE seq_board
INCREMENT BY 1
START WITH 1
MAXVALUE 999999999999999
MINVALUE 0
NOCYCLE
CACHE 10;

ALTER SEQUENCE seq_dept
INCREMENT BY 3
MAXVALUE 99
CYCLE ;
-- 1,2,3,4,5,6,7,8 중간에 삭제한다고 끼워 넣기 없다.

DROP SEQUENCE seq_dept;

--테이블 이름에 별명 이건 sys에서 하는 거 
GRANT CREATE synonym TO scott;
GRANT CREATE public synonym TO scott;

--테이블의 이름이 길어서 타이핑 하기 힘들때 쓴다.
CREATE synonym e FOR emp;
SELECT * FROM e;

--practice01
--다음 SQL문을 작성해 보세요.          
--① EMP 테이블과 같은 구조의 데이터를 저장하는 EMPIDX 테이블을 만들어 보세요.
--② 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 만들어 보세요.
--③ 마지막으로 인덱스가 잘 생성되었는지 적절한 데이터 사전 뷰를 통해 확인해 보세요.

--①번
CREATE TABLE empidx AS
SELECT * FROM emp;

--②번
CREATE INDEX IDX_EMPIDX_EMPNO ON empidx(EMPNO);

--③번
SELECT * FROM user_indexes;


--practice02
--문제 1번에서 생성한 EMPIDX 테이블의 데이터 중 급여 (SAL) 가 1500 초과인 
--사원들만 출력하 는 EMPIDX_OVER15K 뷰를 생성해 보세요. 
--이 이름을 가진 뷰가 이미 존재할 경우에 새로운 내용으로 대체 가능해야 합니다. 
--EMPIDX_OVER15K 뷰는 사원 번호, 사원 이름, 직책, 
--부서 번호,  급여, 추가 수당 열을 가지고 있습니다. 
--추가 수당 열의 경우에 추가 수당이 존재하면 O, 존재하지  않으면 X로 출력합니다.

CREATE OR REPLACE VIEW EMPIDX_OVER15K AS 
(SELECT empno,ename,job,deptno,sal,nvl2(comm,'o','x') AS comm
FROM EMPIDX
WHERE sal >= 1500);

SELECT * FROM EMPIDX_OVER15K;

--practice03
CREATE TABLE deptseq AS SELECT * FROM dept;

CREATE SEQUENCE seq_deptseq
INCREMENT BY 1
START WITH 1
MAXVALUE 99
MINVALUE 1
NOCYCLE
NOCACHE;

