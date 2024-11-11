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







