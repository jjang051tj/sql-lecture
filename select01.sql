-- create   insert문   
-- read     select문     
-- update   update문   
-- delete   delete문


-- sql에디터  dbeaver/toad/sqldeveloper
DESC emp;

--rdbms
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM SALGRADE;

SELECT empno, ENAME FROM emp;

--중복제거
SELECT DISTINCT job FROM emp;
SELECT DISTINCT deptno FROM emp;

--연봉으로 알려줘
SELECT ename,sal, comm FROM emp;

SELECT ename,sal*12+nvl(comm,0) as annualsal FROM emp;


-- 컬럼명 as alias(별칭)
SELECT ename AS 사원이름,sal AS 월급 FROM emp;

-- 오름정렬 / 내림 정렬
SELECT ename AS 사원이름,sal AS 월급 FROM emp ORDER BY 월급 desc;

--사원번호 기준으로 내림차순 정렬
SELECT * FROM emp ORDER BY empno DESC;

--사원번호 기준으로 부서번호로 오름차순 정렬 하고 급여로 내림 차순 정렬
SELECT * FROM emp ORDER BY DEPTNO ASC, sal DESC ;

-- 조건절
-- where 는 프로그래밍 언어에서의 if와 같다.
SELECT * FROM emp WHERE DEPTNO = 30;

--사원번호가 7782인 사람 출력 해보기...
SELECT * FROM emp WHERE EMPNO = 7782;

--부서번호가 30번인 곳에서 salesman인 사람만 뽑기 
--문자열을 따지때는 작은 따옴표
--큰 따옴표는 테이블 명이나 식별자 쓸 때 이때는 대소문자 따짐...
SELECT * FROM emp WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

--사원번호가 7499이고 부서번호가 30번인 사워출력
SELECT * FROM emp WHERE EMPNO = 7499 AND DEPTNO = 30;

--부서번호가 30번 또는 job이 clerk인사람 뽑기...
SELECT * FROM emp where deptno = 30 OR job = 'clerk';


-- 연산자  + , - , * , /
SELECT * FROM emp;
SELECT * FROM emp WHERE sal*12 > 20000;
SELECT * FROM emp WHERE sal*12 < 20000;
SELECT * FROM emp WHERE sal*12 >= 20000;
SELECT * FROM emp WHERE sal*12 <= 20000;
SELECT * FROM emp WHERE sal*12 = 20000;
SELECT * FROM emp WHERE sal*12 != 20000;

-- 문자도 크기 비교 가능 알파벳 순서로 비교
SELECT * FROM emp WHERE ename >= 'FORD';  

--job이 MANAGER 또는 SALESMAN 또는 CLERK
SELECT ename,job FROM emp WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';

-- in (값 여러개 있을 수 있음) in구문안에 하나라도 걸리면 true,false
SELECT ename,job FROM emp WHERE JOB IN ('MANAGER','SALESMAN','CLERK');

--job이 MANAGER 또는 SALESMAN 또는 CLERK이 아닌 사람
SELECT ename,job FROM emp WHERE JOB != 'MANAGER' AND JOB <> 'SALESMAN' AND JOB ^= 'CLERK';
SELECT ename,job FROM emp WHERE JOB NOT IN ('MANAGER','SALESMAN','CLERK');

--월급이 2000보다 크거나 같고 3000보다 작거난 같은 사람  
SELECT ename,sal FROM emp WHERE sal>=2000 AND sal<=3000;
SELECT ename,sal FROM emp WHERE sal BETWEEN 2000 AND 3000;

--like 연산자  검색
SELECT * FROM emp;  
SELECT * FROM emp WHERE ename LIKE 'J%';

--앞에 이름이 뭐여도 상관없는데 끝이 ER로 끝나는 사람 찾기....
SELECT * FROM emp WHERE ename LIKE '%ER';

--이름중에  AM을 포함하고 있는 사람 찾아보기...
SELECT * FROM emp WHERE ename LIKE '%AM%';

--이름중에  M을 포함하고 있는 사람 찾아보기...
SELECT * FROM emp WHERE ename LIKE '%M%';

--이름중에  M 또는 I을 포함하고 있는 사람 찾아보기...M으로 시작하고 i가 나오는 경우
SELECT * FROM emp WHERE ename LIKE '%M%I%';
--이름이 다섯글자인 사람
SELECT * FROM emp WHERE ename LIKE '_____';

--이름이 다섯글자인 사람중에 마지막 글자가 s인 사람
SELECT * FROM emp WHERE ename LIKE '____S';

--이름의 세번째글자가 A인 사람 찾기
SELECT * FROM emp WHERE ename LIKE '__A%';


SELECT 'steven_king' AS ename FROM dual;

WITH temp AS (
	SELECT 'STEVEN_KING' AS ename FROM dual UNION ALL
	SELECT 'ALBERT_KING' AS ename FROM dual UNION ALL
	SELECT 'SCOTT' AS ename FROM dual 
)
SELECT * FROM temp WHERE ename LIKE '%$_%' ESCAPE '$';

--null 검색 null은 = 못씀 is
SELECT * FROM emp;
SELECT * FROM emp WHERE COMM IS NOT NULL;

SELECT * FROM emp WHERE MGR IS NOT NULL;

SELECT ENAME, nvl(comm,0)+100 AS comm100 FROM emp;


--practice01
SELECT * FROM emp WHERE ename LIKE '%S';

--practice02
SELECT * FROM emp 
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

--practice0301
SELECT * FROM emp 
WHERE (DEPTNO = 20 OR DEPTNO = 30) AND SAL > 2000;

--practice0302
SELECT * FROM emp 
WHERE DEPTNO IN (20,30) 
AND SAL > 2000;

--practice04
SELECT * FROM emp
WHERE sal > 2000 AND sal < 3000;

--practice0402 between은 equal 포함 >=  <=
SELECT * FROM emp
WHERE sal BETWEEN 2000 AND 3000;

--practice05
SELECT ename,empno,sal, deptno FROM emp 
WHERE 
DEPTNO = 30 AND 
sal NOT BETWEEN 1000 AND 2000 AND 
ename LIKE '%E%';


--practice05
SELECT * FROM emp
WHERE comm IS NULL 
	AND mgr IS NOT NULL
	AND JOB IN ('MANAGER','CLERK') 
	AND ENAME NOT LIKE '_L%'; 














































