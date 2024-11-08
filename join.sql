-- join   테이블 여러개를 가로로 연결해서 쓰기...
-- ansi

-- inner join 등가조인 따로 join문을 쓰지 않으면 기본적으로 inner join을 하게 되어 있음

-- 오라클 조인
SELECT  e.*,d.dname,d.loc
FROM EMP e,DEPT d
WHERE e.deptno = d.deptno;

-- ansi join  inner 조인이면서 등가 조인 이때 같이 쓰는 컬러명에는 테이블의 별칭을 붙이지 않는다.
-- 첫번째 방법
SELECT  e.empno, e.ename, e.job,e.mgr,e.HIREDATE,e.sal,
		deptno, -- 공통으로 사용하는 컬럼에는 별칭이 없다.
		d.dname,d.loc
FROM EMP e NATURAL JOIN DEPT d;


-- 두번째 방법
SELECT  e.empno, e.ename, e.job,e.mgr,e.HIREDATE,e.sal,
		deptno, -- 공통으로 사용하는 컬럼에는 별칭이 없다.
		d.dname,d.loc
FROM EMP e JOIN DEPT d USING (deptno);

-- 세번째 방법 가장 많이 쓴다. 공통으로 쓰는 컬럼이 없다.
SELECT  e.empno,  e.ename, e.job,e.mgr,e.HIREDATE,e.sal,
		d.deptno, d.dname, d.loc
FROM EMP e JOIN DEPT d ON (e.DEPTNO = d.DEPTNO);

SELECT  e.*,
		d.dname, d.loc
FROM EMP e JOIN DEPT d ON (e.DEPTNO = d.DEPTNO);



SELECT  e.*,d.dname,d.loc
FROM EMP e,DEPT d
WHERE e.deptno = d.deptno 
AND e.sal >= 2500 
AND e.sal<=3000;

--비등가 조인
SELECT e.*,s.* 
FROM emp e,salgrade s
WHERE e.sal >= s.LOSAL AND e.sal <= s.HISAL;

SELECT e.*,s.* 
FROM emp e,salgrade s
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL;

-- 자체 조인 self join 등가조인
SELECT * FROM emp;
select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
ORDER BY e1.empno;



SELECT * FROM emp;

select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
ORDER BY e1.empno;

-- 자체 조인 self join 등가조인 left outer 조인 왼쪽을 기준으로 오른쪽에 기분에 맞는게 없어도 출력
-- (+) 붙이는 쪽이 기준이다.  직속 상관이 없어도 출력
-- 왼쪽에 있는 데이터가 오른쪽에 없어도 null이러도 출랙해라
select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+)
ORDER BY e1.empno;

--ansi join left outer join 
select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1 LEFT OUTER JOIN emp e2 ON (e1.mgr = e2.EMPNO);


-- 자체 조인 self join 등가조인 right outer 조인 오른쪽을 기준으로 오른쪽에 기분에 맞는게 없어도 출력
SELECT * FROM emp;
select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1, emp e2
WHERE e1.mgr(+) = e2.empno
ORDER BY e1.empno;

--ansi join right outer join 
select e1.empno,e1.ename,e1.job,e1.mgr,e2.mgr AS mgr_empno,e2.ename AS mgr_name
FROM emp e1 RIGHT OUTER JOIN emp e2 ON (e1.mgr = e2.empno);



--practice01
--급여가 2000 초과인 사원들의 부서저옵 사원 정보 출력

--ansi natural join 같이 쓴 컬럼에는 소속을 붙이지 않는다.
SELECT DEPTNO , d.DNAME,e.EMPNO,e.ENAME, e.SAL 
FROM emp e NATURAL JOIN dept d
WHERE e.SAL > 2000;

SELECT d.DEPTNO, d.DNAME,e.EMPNO,e.ENAME, e.SAL 
FROM emp e 
JOIN DEPT d
ON e.DEPTNO  = d.DEPTNO 
WHERE e.SAL > 2000;

--오라클 조인
SELECT d.DEPTNO, d.DNAME,e.EMPNO,e.ENAME, e.SAL 
FROM EMP e , DEPT d
WHERE e.DEPTNO  = d.DEPTNO  
AND e.SAL > 2000;


--practice02
-- ansi
SELECT d.DEPTNO ,d.DNAME , 
	   TRUNC(avg(sal)) AS avg_sal, 
	   max(sal) AS max_sal,
	   min(sal) AS min_sal,
	   count(*) AS cnt
FROM emp e
INNER JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO
GROUP BY d.DEPTNO , d.DNAME;

--오라클
SELECT d.DEPTNO ,d.DNAME , 
	   TRUNC(avg(sal)) AS avg_sal, 
	   max(sal) AS max_sal,
	   min(sal) AS min_sal,
	   count(*) AS cnt
FROM emp e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO
GROUP BY d.DEPTNO , d.DNAME;




--practice03
-- ansi
SELECT d.DEPTNO ,d.DNAME ,e.ENAME ,e.EMPNO , e.SAL 
FROM EMP e
RIGHT OUTER JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO ;

-- 오라클
SELECT d.DEPTNO ,d.DNAME ,e.ENAME ,e.EMPNO , e.SAL 
FROM EMP e, DEPT d 
WHERE e.DEPTNO(+) = d.DEPTNO;


-- practice04
-- ansi
SELECT d.DEPTNO,d.DNAME,
       e1.EMPNO,e1.ENAME,e1.MGR,e1.SAL,e1.DEPTNO,
       s.LOSAL , s.HISAL , s.GRADE , 
       e2.EMPNO AS MGR_EMPNO, e2.ENAME  AS MGR_ENAME
FROM EMP e1
RIGHT OUTER JOIN DEPT d
	ON e1.DEPTNO = d.DEPTNO 
LEFT OUTER JOIN SALGRADE s 
	ON e1.SAL BETWEEN s.LOSAL AND s.HISAL
LEFT OUTER JOIN EMP e2
	ON e1.mgr = e2.EMPNO
ORDER BY d.DEPTNO;

-- 오라클
SELECT d.DEPTNO,d.DNAME,
       e1.EMPNO,e1.ENAME,e1.MGR,e1.SAL,e1.DEPTNO,
       s.LOSAL , s.HISAL , s.GRADE , 
       e2.EMPNO AS MGR_EMPNO, e2.ENAME  AS MGR_ENAME
FROM EMP e1, DEPT d,SALGRADE s, EMP e2
WHERE e1.DEPTNO(+) = d.DEPTNO  
AND e1.SAL BETWEEN s.LOSAL AND s.HISAL
AND e1.mgr = e2.EMPNO(+)
ORDER BY d.DEPTNO;













