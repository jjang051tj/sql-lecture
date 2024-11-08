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









