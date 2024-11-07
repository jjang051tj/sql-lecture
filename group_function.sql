SELECT * FROM emp;
-- 그룹함수 다중행 함수(multi - row function)
--아래는 오류를 일으킨다 여러줄이 출력되는 결과와 다중행 함수는 하나의 결과로 나오기 때문에 동시에 쓸 수 없다.
SELECT ename, sum(sal) AS total_sal FROM emp;

SELECT sum(ALL sal) AS all_sum, 
	   sum(sal) AS sum, 
	   sum(DISTINCT sal) AS distinct_sum
FROM emp;

SELECT 
	sum(sal) AS all_sal,
	sum(comm) AS all_comm
FROM emp;	

SELECT 
	count(comm) AS total,
	count(sal) AS total_sal,
	count(*) AS total_all
FROM emp;

SELECT 
	count(DISTINCT deptno) AS total
FROM emp;


SELECT count(*) AS total
FROM emp
WHERE deptno = 30;

-- counting할때 null은 뺀다
SELECT count(comm) AS total
FROM emp
WHERE comm;

SELECT MAX(sal) AS top_sal
FROM emp;

--부서번호가 10번인 사원중에 제일 큰 급여 출력하기
SELECT MAX(sal) AS top_sal
FROM EMP 
WHERE deptno = 10;

--부서번호가 10번인 사원중에 제일 작은 급여 출력하기
SELECT MIN(sal) AS top_sal
FROM EMP 
WHERE deptno = 10;

-- 입사연도가 제일 최근인 사람...
SELECT MAX(hiredate) AS junior
FROM EMP; 

--부서 번호가 20인 사원의 입사일 중 제일 오래된 입사일 출력
SELECT MIN(hiredate) AS senito
FROM EMP
WHERE deptno = 20;


--부서 번호가 20인 사원들의 평균 급여
SELECT trunc(avg(sal),2) AS avg_sal
FROM emp
WHERE deptno = 30;

--10,20,30번 부서의 평균급여
SELECT '10', trunc(avg(sal),2) AS avg_sal FROM emp WHERE deptno = 10 UNION ALL
SELECT '20', trunc(avg(sal),2) AS avg_sal FROM emp WHERE deptno = 20 UNION ALL
SELECT '30', trunc(avg(sal),2) AS avg_sal FROM emp WHERE deptno = 30;

SELECT deptno,job,avg(sal) AS avg_sal 
FROM emp
GROUP BY deptno, job
ORDER BY deptno DESC, job;


--부서번호별 평균 수당
SELECT deptno,avg(comm) AS avg_comm 
FROM emp
GROUP BY deptno
ORDER BY deptno;

--그룹의 조건은 where를 쓰지 않고 having을 쓴다.
SELECT deptno,avg(sal) AS avg_comm 
FROM emp
GROUP BY deptno
HAVING avg(sal) >= 2000;

-- 1번 where 2번 group 3번 having 4번 order


-- 부서변 평균 급여를 deptno, job도 표시 하는데 sal 3000보다 작은 사람들만 그리고 평균 급여가 2000이상

SELECT deptno,job, avg(sal)
FROM EMP 
WHERE sal <= 3000
GROUP BY DEPTNO , job
HAVING avg(sal) >= 2000
ORDER BY deptno;

--부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 부서별 직책의 평균 급여 출력 하기...

SELECT deptno, job,avg(sal)
FROM emp
GROUP BY DEPTNO ,job
HAVING avg(sal) >= 500
ORDER BY DEPTNO , job;


--salesman의 총급여  case
SELECT 
	job,
	sum(sal) AS all_sal
FROM emp
WHERE job IN ('SALESMAN', 'MANAGER','CLERK')
GROUP BY job;


SELECT 
	sum(CASE WHEN job = 'CLERK' THEN sal end) AS clerk_sal,
	sum(CASE WHEN job = 'MANAGER' THEN sal end) AS manager_sal,
	sum(CASE WHEN job = 'SALESMAN' THEN sal end) AS salesman_sal
FROM emp;








