-- 쿼리 한번 더 쓰기
-- query 안에 query가 한번 더 들어감...
-- emp jones 보다 높은 급여를 받는 사람 출력
SELECT sal FROM emp
WHERE ename= 'JONES';


--조건절에 쓰는 서브쿼리를 중첩 서브쿼리
--select에 쓰는 서브쿼리를 스칼라 서브쿼리
--from 절에 쓰는 서브쿼리를 inline view
SELECT * FROM emp
WHERE sal > (SELECT sal FROM emp
WHERE ename= 'JONES');  


--ALLEN보다 많은 comm 을 받는 사람 출력
SELECT * FROM emp
WHERE COMM > (SELECT comm FROM emp
WHERE ename = 'ALLEN');


SELECT * FROM emp
WHERE HIREDATE < (SELECT HIREDATE FROM emp
WHERE ename = 'ALLEN');

-- 20번 부서에 속한 사원중 전체 사원의 평균 급여보다 높으 급여를 받는 사람 출력
SELECT e.*, d.DNAME , d.LOC 
FROM emp e
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 20 AND e.sal > (SELECT avg(SAL) FROM emp);

-- 전체 사원의 평균 급여보다 작거나 같은 급요를 받고 있는 
-- 20부서의 사원 및 부서 정보 출력

SELECT e.*, d.DNAME , d.LOC 
FROM emp e
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 20 AND e.sal <= (SELECT avg(SAL) FROM emp);


SELECT * FROM EMP e
WHERE DEPTNO IN (20,30);

--부서별 최고 급여를 받는 사람과 동일한 급요를 받는 사람 출력

SELECT * FROM EMP e 
WHERE SAL IN (SELECT MAX(sal) FROM emp
GROUP BY DEPTNO);

-- any, some, all
-- any, some 조건이 하나라도 맞으면
-- 1500 < ANY (500,1000,2000) false

-- all
-- 1000 > ANY (500,700,900) false

SELECT * FROM EMP e;
SELECT * FROM EMP e 
WHERE sal > some (1000,2000,3000);

--스칼라 서브 쿼리
SELECT empno,ename,job, sal, 
( 
	SELECT grade FROM SALGRADE
	WHERE e.sal BETWEEN losal AND hisal
) AS salgrade
FROM emp e;

--262p 문제 풀어보기...
--같이 풀어보아요...
-- 1. 전체 사원 중 ALLEN과 같은 직책 (JOB) 인 사원들의 사원 정보, 
-- 부서 정보를 다음과 같이 출력하 는 SQL문을 작성하세요.

SELECT * FROM emp
WHERE ename = 'ALLEN';


--오라클 조인
SELECT * FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND  
job = (
	SELECT JOB FROM emp
	WHERE ename = 'ALLEN'
);

--안시 조인
SELECT * FROM EMP e
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE job = (
	SELECT JOB FROM emp
	WHERE ename = 'ALLEN'
);

--2번
-- 전체 사원의 평균 급여 (SAL) 보다 높은 급여를 받는 사원들의 
--사원 정보, 부서 정보, 급여 등급 정 보를 출력하는 SQL문을 작성하세요
SELECT * FROM EMP e 
WHERE sal > (SELECT avg(sal) AS avg_sal FROM emp);

SELECT * FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND 
sal > (SELECT avg(sal) AS avg_sal FROM emp);

SELECT e.*, d.dname,d.loc FROM EMP e
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = d.DEPTNO AND 
sal > (SELECT avg(sal) AS avg_sal FROM emp);


-- 3.
-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 
-- 사원들의 사원 정보, 부 서 정보를 다음과 같이 출력하는 SQL문을 작성하세요.

SELECT e.*, d.dname,d.loc FROM EMP e
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = d.DEPTNO AND 
e.DEPTNO = 10 AND 
JOB NOT IN (SELECT DISTINCT JOB FROM emp
WHERE DEPTNO = 30);

-- 4.
-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 
-- 사원 정보, 급여 등급  정보를 다음과 같이 출력하는 SQL문을 작성하세요
-- 4.1
SELECT * FROM emp
WHERE sal > (SELECT MAX(sal) AS max_sal FROM EMP e 
WHERE JOB = 'SALESMAN');

-- 4.2
SELECT * FROM emp
WHERE sal > ALL ( SELECT sal FROM EMP e 
WHERE JOB = 'SALESMAN' );







