CREATE TABLE chap10hw_emp AS SELECT * FROM emp;
CREATE TABLE chap10hw_dept AS SELECT * FROM dept;
CREATE TABLE chap10hw_salgrade AS SELECT * FROM salgrade;

--practice01
INSERT INTO chap10hw_dept (deptno,dname,loc) VALUES (50,'ORACLE','BUSAN');
INSERT INTO chap10hw_dept (deptno,dname,loc) VALUES (60,'sql','ilsan');
INSERT INTO chap10hw_dept (deptno,dname,loc) VALUES (70,'select','incheon');
INSERT INTO chap10hw_dept (deptno,dname,loc) VALUES (80,'dml','BUNDANG');

COMMIT;
SELECT * FROM chap10hw_dept;


--  SQL 반복문 if  pl/sql 
--practice02
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
 
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
 
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
 
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
 
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);

COMMIT;


--practice03
UPDATE chap10hw_emp SET 
deptno = 70	
WHERE sal > (SELECT avg(sal) AS avg_sal 
				FROM chap10hw_emp   WHERE deptno = 50
			);
SELECT * FROM 	chap10hw_emp;	



--practice04
UPDATE chap10hw_emp SET 
	sal = sal*1.1,
	deptno = 80	
	WHERE hiredate > 
	(SELECT max(hiredate) FROM chap10hw_emp WHERE deptno = 60);
	

COMMIT;

DELETE FROM chap10hw_emp
	WHERE empno  IN (
		SELECT e.empno FROM chap10hw_emp e, chap10hw_salgrade s
			WHERE e.sal BETWEEN s.losal AND s.hisal AND s.grade=5
	);

SELECT * from chap10hw_emp;


-- 트랜잭션 일의 묶음(은행 이체 카카오 뱅크에서 돈을 인출 100000 -> 신한은행 100000) 
-- commit,rollback

--테이블 복사
CREATE TABLE dept_tcl AS SELECT * FROM dept;

SELECT * FROM dept_tcl;

-- 테이블 데이터에 영향을 미친다. commit rollback
INSERT INTO dept_tcl VALUES (50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE deptno = 40;
DELETE FROM DEPT_TCL WHERE dname='RESEARCH';

-- DDL (Data Definition Language)  create , rename, drop
-- DML (Data Manipulation Language)   select, insert , delete , update
-- Transation Control Language  commit/rollback
COMMIT;
ROLLBACK;

SELECT * FROM dept_tcl;

DELETE FROM DEPT_TCL WHERE deptno = 50; 

UPDATE dept_tcl SET loc = 'SEOUL'
WHERE deptno = 30;
-- commit / rollback을 하지 않으면 다른 곳에서 접근 불가능 Lock


-- data definition language  ddl에는 commit / rollback 없음...
CREATE TABLE emp_ddl (
	empno number(4),
	ename varchar2(10),
	job varchar2(9),
	mgr number(4),
	hiredate DATE,
	sal number(7,2),  -- 전체 자릿수 7 소수점 자리수 2개 정수 5개 까지...   
	comm number(7,2),
	DEPTno number(2)
);
SELECT * FROM EMP_DDL ed ;

-- 싹다 들고 온다.
CREATE TABLE dept_ddl AS SELECT * FROM dept;
SELECT * FROM dept_ddl;

--구조만 즉 틀만 들고 온다. 안쪽에 데이터는 없다.
CREATE TABLE dept_ddl AS SELECT * FROM dept WHERE 1!=1;

--ALTER 는 테이블 변경
CREATE TABLE emp_alter AS SELECT * FROM emp;
SELECT * FROM emp_alter;

--hp 컬럼 추가
ALTER TABLE emp_alter
ADD hp varchar2(13);

SELECT * FROM emp_alter;

--컬럼의 이름 바꾸기...
ALTER TABLE emp_alter
RENAME COLUMN hp TO tel;

-- 사원이 증가해서 10000명
ALTER TABLE emp_alter
MODIFY empno number(5);

-- 컬럼 없애기
ALTER TABLE EMP_ALTER 
DROP COLUMN tel;


-- 테이블 이름 변경
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_rename;


-- table의 데이터 싹다 삭제...
-- 조심해서 쓰자 commit / rollback이 없다.
TRUNCATE TABLE emp_rename; 

SELECT * FROM emp_rename;

--테이블 삭제
DROP TABLE emp_rename;

--만약 drop table로 삭제가 안될경우는 제약 사항이 걸려 있어서 그렇다.
DROP TABLE emp_rename CASCADE CONSTRAINTS;





