-- select 데이터 조회
-- Data Manupulation Language
-- 입력,수정,삭제
SELECT * FROM emp;

--dept를 복제하는 명령어
CREATE TABLE temp_dept AS SELECT * FROM dept;

--dept를 복제하는 명령어
CREATE TABLE temp_dept02 AS SELECT * FROM dept WHERE 1=0;

DROP TABLE temp_dept;

SELECT * FROM TEMP_DEPT td ;


INSERT INTO temp_dept (DEPTNO,DNAME,LOC)
VALUES (50,'DATABASE','SEOUL');

ROLLBACK;


-- 입력할 컬럼명을 생략하는 경우 무조건 갯수 맞추어야 한다.
INSERT INTO temp_dept 
VALUES (60,'DATABASE','SEOUL');

-- null을 허용했을때만 넣을 수 있다.
INSERT INTO temp_dept 
VALUES (70,'WBE',NULL);

INSERT INTO temp_dept 
VALUES (80,'MOBILE','');

ROLLBACK;



-- DML  입력, 수정, 삭제시에는 반드시  
-- transaction (하나로 처리되어야 하는 일의 묶음, 은행 입출금)
-- COMMIT, ROLLBACK

CREATE TABLE temp_emp
AS SELECT * FROM emp WHERE 1!=1;

SELECT * FROM TEMP_EMP;

INSERT INTO TEMP_EMP (EMPNO,ename,job,mgr,HIREDATE,SAL,comm,deptno)
VALUES (9999,'hong','PRESIDENT',NULL,'2024/11/11',5000,1000,10);

INSERT INTO TEMP_EMP (EMPNO,ename,job,mgr,HIREDATE,SAL,comm,deptno)
VALUES (9999,'sung','MANAGER',9999,'2024-11-11',4000,null,20);

INSERT INTO TEMP_EMP (EMPNO,ename,job,mgr,HIREDATE,SAL,comm,deptno)
VALUES (8888,'byun','MANAGER',9999,
	to_date('11/11/2024','DD/MM/YYYY'),4000,null,20);

INSERT INTO TEMP_EMP (EMPNO,ename,job,mgr,HIREDATE,SAL,comm,deptno)
VALUES (8888,'byun','MANAGER',9999,
	sysdate,4000,null,20);

SELECT * FROM TEMP_EMP te ;
ROLLBACK;

--관리자들이 쓰는 명령어
INSERT INTO TEMP_EMP (EMPNO,ename,job,mgr,HIREDATE,SAL,comm,deptno)
(
	SELECT e.EMPNO,e.ENAME,e.job,e.mgr,e.HIREDATE,e.SAL,e.comm,e.DEPTNO 
	FROM emp e, SALGRADE s 
	WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1
);

-- temp_emp02라는 빈테이블을 만들고 회원 3명 입력해보기....
CREATE TABLE temp_dept02 AS 
SELECT * FROM dept;

SELECT * FROM TEMP_DEPT02 td ;

UPDATE TEMP_DEPT02 
	SET loc = 'SEOUL'
	WHERE DEPTNO = 40;
COMMIT;
ROLLBACK;

--temp_emp02를 만들고 여기에 emp를 데이터까지 복제하고 금여가 2500이하인 사원의 
--comm을 50으로 수정
SELECT * FROM TEMP_EMP te ;

CREATE TABLE temp_emp02 AS
SELECT * FROM emp;

SELECT * FROM TEMP_EMP02;
ROLLBACK;
UPDATE temp_emp02 SET 
COMM= 50 
WHERE sal<=2500;

SELECT * FROM temp_dept02;

-- loc=부산으로바꾼다  dname=operation인 부서

SELECT * FROM TEMP_DEPT02 td ;
UPDATE TEMP_DEPT02 SET loc = 'BUSAN'
WHERE deptno = (
	SELECT deptno FROM TEMP_DEPT02 td 
	WHERE dname = 'OPERATIONS'
);
DROP TABLE temp_emp02;
CREATE TABLE temp_emp02 AS
SELECT * FROM emp;

SELECT * FROM TEMP_EMP02 te; 
DELETE FROM TEMP_EMP02 te 
	WHERE JOB = 'MANAGER';
COMMIT;
ROLLBACK;
-- 급여 등급이 3등급이고 deptno= 30부서인 사원들 삭제

SELECT * FROM TEMP_EMP02 te ;

COMMIT;


DELETE FROM TEMP_EMP02 te 
	WHERE empno IN (
		SELECT e.empno FROM TEMP_EMP02 e, SALGRADE s 
		WHERE e.sal BETWEEN s.losal AND s.hisal
		AND s.grade = 3 AND deptno=30);

	
DELETE FROM TEMP_EMP02 WHERE EMPNO IN 
	(SELECT E.EMPNO FROM TEMP_EMP02 E, SALGRADE S 
		WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
		AND S.GRADE = 3 
		AND DEPTNO = 30);
	
-- practice01
CREATE TABLE CHAP10HW_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10HW_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10HW_SALGRADE AS SELECT * FROM SALGRADE;

ROLLBACK;
DROP TABLE TEMP_EMP;

SELECT * FROM emp;























