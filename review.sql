-- 주석
/*
	여러 줄 주석
	여러 줄 주석
	여러 줄 주석
*/
-- 관계형 데이터베이스 Relational DB  MS(오라클,mySql, Maria Db 등등)
-- Structured Query Language   
-- Create  insert into  
-- Read    select from
-- Upadte  update set
-- Delete  delete
SELECT * FROM emp
WHERE empno = 7369;

--열의 중복 제거하고 출력
SELECT  DISTINCT job, deptno FROM emp;

--열에 계산이 가능
SELECT ename,sal, sal*12+comm AS annual_sal FROM emp;

-- 열을 정렬 해서 출력
SELECT * FROM emp
ORDER BY empno DESC;

-- 열을 두개 이상 정렬 해서 출력
SELECT * FROM emp
ORDER BY DEPTNO ASC, SAL DESC;

--order by는 연산을 많이 하기 때문에 조심해서 쓰는게 좋다.

-- 조건 검색
SELECT * FROM emp
WHERE DEPTNO = 30 OR JOB = 'SALESMAN';

--산술연산자 + - * /
SELECT * FROM emp 
WHERE sal*12 = 36000;

SELECT sal*12+100 AS ann_sal FROM emp; 

--비교 연산자
SELECT * FROM emp
WHERE sal != 3000;

-- 논리 연산자 
SELECT * FROM emp
WHERE NOT sal = 3000;

-- in 연산자
SELECT * FROM EMP
WHERE job = 'MANAGER' OR 
      job = 'SALESMAN' OR 
      job = 'CLERK';

SELECT * FROM EMP
WHERE job IN ('MANAGER','SALESMAN','CLERK');


SELECT * FROM EMP
WHERE job NOT IN ('MANAGER','SALESMAN','CLERK');

SELECT * FROM emp
WHERE sal >=2000 AND sal<=3000;

SELECT * FROM emp
WHERE sal BETWEEN 2000 AND 3000;

-- like
SELECT * FROM emp
WHERE ename LIKE '%E%';


SELECT * FROM emp
WHERE ename LIKE '_L%';

--사람 이름 중에 AM
SELECT * FROM emp
WHERE ename LIKE '%AM%';

-- null데이터는 is 비교한다.
SELECT * FROM emp
WHERE COMM IS null;

-- union
SELECT empno,ename,sal, deptno FROM emp WHERE DEPTNO = 10
UNION ALL 
SELECT empno,ename,sal, deptno FROM emp WHERE DEPTNO = 10;

--함수 문자열 함수 숫자 함수 타입변경
SELECT LOWER(ename),UPPER(ename),INITCAP(ename) FROM emp;
SELECT ename,
	   LENGTH(ename), 
	   LOWER(SUBSTR(ename,1,2)),
	   LOWER(SUBSTR(ename,-3,3)),
	   RPAD('Oralce',10,'*'),
	   RPAD('120304-',14,'*'),
	   LPAD('120304',14,'*')
FROM emp;

--이름의 첫글자와마지막 글자만 보여주고 나머지는 * 채우기
S***H

SELECT
	ename , ename AS masked_name
FROM emp;


SELECT ENAME,
	RPAD(
		RPAD(SUBSTR(ename,1,1),LENGTH(ename)-1, '*'), --S***
			 LENGTH(ename),
			 SUBSTR(ename,LENGTH(ename)
		)
	)  AS making_name
FROM emp;
SELECT ENAME,SUBSTR(ename,1,1) || 
			 RPAD('*',LENGTH(ENAME) - 2,'*') || 
			 SUBSTR(ename,-1,1) 
	  AS making_name
FROM emp;
-- 반올림
SELECT 
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678,0) AS ROUND_0,
	ROUND(1234.5678,1) AS ROUND_1,
	ROUND(1234.5678,2) AS ROUND_2,
	ROUND(1234.5678,3) AS ROUND_3,
	TRUNC(1234.5678) AS TRUNC_0,
	TRUNC(1234.5678,1) AS TRUNC_1,
	TRUNC(1234.5678,2) AS TRUNC_2,
	TRUNC(1234.5678,3) AS TRUNC_3,
	TRUNC(1234.5678,4) AS TRUNC_4
FROM dual;

SELECT SYSDATE - 1 AS yesterday FROM dual;

SELECT SYSDATE , 
	TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') AS year FROM dual;

SELECT nvl(comm,0),nvl2(comm,'O','X') FROM emp;

-- 다중행 함수 여러개의 결과를 하나의 row에 출력하기...
SELECT 
	   DEPTNO,
	   sum(sal) AS sum,
	   count(*) AS count,
	   avg(sal) AS sal_avg
FROM emp
GROUP BY DEPTNO
	HAVING avg(sal) >= 2000;









     
      

















