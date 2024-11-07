--함수 
-- 숫자 관련 함수 문자 관련 함수 
-- 문자 관련 함수
SELECT ENAME, 
		LOWER(ENAME) AS lower_ename, 
		UPPER(ENAME) AS upper_name,  
		INITCAP(ENAME) as initCap_name 
FROM emp;

SELECT * FROM emp;

SELECT LOWER(ename) AS ename FROM EMP  
WHERE UPPER(ename) LIKE UPPER('%s%');

--이름이 5글자 이상인 사람만 출력 length(컬럼명 또는 값) 는 수수한 글자수
-- lengthb(컬럼명 또는 값)는 글자의 바이트 수 오라클에서 한글은 3byte문자
SELECT ename AS five_more_name FROM emp WHERE LENGTH(ename) >= 5;
SELECT LENGTH('hello') AS LENGTH, LENGTHB('hello') AS lengthb FROM dual;
SELECT LENGTH('안녕') AS LENGTH, LENGTHB('안녕') AS lengthb FROM dual;


SELECT ename,LENGTH(ename) AS letters_name FROM emp;

--글자 자르기
SELECT job, 
	  SUBSTR(job,1,2),
	  SUBSTR(job,3,2),
	  SUBSTR(job,5),
	  SUBSTR(job,-5,2)
FROM emp; 

--job의 뒤에서 두글자만 출력하기..

SELECT job, SUBSTR(job,1,2) AS front, SUBSTR(job,-2) AS back FROM emp; 
-- Cl ERK
-- SA LESMAN
-- MA NAGER
SELECT job, 
	SUBSTR(job,1,2) AS front, 
	SUBSTR(job,3) AS back FROM emp;

-- ClE RK
-- SALESM AN
-- MANAG ER
SELECT job, 
	SUBSTR(job,1,LENGTH(job)-2) AS front, 
	SUBSTR(job,-2) AS back FROM emp;

--instr은 글자가 몇번째 위치하고 있는지...
SELECT INSTR('HELLO, ORACLE','L') FROM dual;
--L을 4번째 부터 찾기 시작해서 처음 나오는 L의 위치
SELECT INSTR('HELLO, ORACLE','L',4) FROM dual;
--L을 4번째 부터 찾기 시작해서 두번째 나오는 L의 위치
SELECT INSTR('HELLO, ORACLE','L',4,2) FROM dual;
SELECT INSTR('HELLO, ORACLE','Z') FROM dual;

--이름에 s가 포함되어 있는 사람만 출력보기..
SELECT ename FROM emp WHERE INSTR(ename,'S') > 0 ;
SELECT ename FROM emp WHERE ENAME LIKE '%S%' ;

SELECT '010-1111-2222' AS replace_before, 
	   REPLACE('010-1111-2222','-',' ') AS replace_after01,
	   REPLACE('010-1111-2222','-') AS replace_after02
FROM dual;

SELECT 'Oracle Database' AS replace_before, 
	   REPLACE('Oracle Database','Database','DB') AS replace_after01,
	   REPLACE('Oracle Database',' ') AS replace_after02
FROM dual;


--'Oracle Database'  ---> Ora DB
SELECT 'Oracle Database' AS replace_before, 
	   REPLACE(REPLACE('Oracle Database','Oracle','Ora'),'Database','DB') AS replace_after01
FROM dual;

-- 991122-******  RPAD LPAD
SELECT RPAD('971216-',14,'*') AS jumin FROM dual;
--010-1111-****
SELECT RPAD('010-1111-',13,'*') AS jumin FROM dual;

-- 901216-1234567 
-- 971216-*******
-- 암호화
SELECT '901216-1234567' AS original,
	   RPAD(SUBSTR('901216-1234567',1,7),14,'*') AS rpad_jumin	
FROM dual;

SELECT LPAD('Oracle',10,'*')  FROM dual;

--문자열 연결
SELECT concat(empno,ename) AS concatName FROM emp;

-- 7369 / SMITH
SELECT concat(empno,concat(' / ',ename)) AS concatName FROM emp;

SELECT 'Hello ' || 'Oracle' AS concatName FROM dual;

-- oracle 전용  다른 db에서는 concat써야 한다.
SELECT empno || ' / ' || ename AS concatName FROM emp;

-- 010-1111-2222   ===> 010-1***-****

-- 정규표현식 regexp
SELECT '[' ||   TRIM('           __Oracle__    ') || ']' AS trim,
	   '[' ||   TRIM(LEADING FROM '           __Oracle__    ') || ']' AS ltrim,
	   '[' ||   TRIM(TRAILING FROM '           __Oracle__    ') || ']' AS rtrim
FROM dual;

SELECT '[' ||   TRIM('           __Oracle__    ') || ']' AS trim,
	   '[' ||   LTRIM('           __Oracle__    ') || ']' AS ltrim,
	   '[' ||   RTRIM('           __Oracle__    ') || ']' AS rtrim
FROM dual;

--trim은 하나만 쓸 수 있다. from을 같이 써야 한다.
SELECT '[' ||   TRIM('_' FROM '           __Oracle__    ') || ']' AS trim,
	   '[' ||   LTRIM('           __Oracle__    ',' _') || ']' AS ltrim,
	   '[' ||   RTRIM('           __Oracle__    ',' _') || ']' AS rtrim
FROM dual;

-- xxxxxhello oraclexxxx에서 왼쪽 x만 지워보기, 오른쪽 x지워보기, 좌우 x지우기..

SELECT TRIM('x' FROM 'xxxxxhello oraclexxxx') AS trim,
	   LTRIM('xxxxxhello oraclexxxx','x') AS ltrim,
	   RTRIM('xxxxxhello oraclexxxx','x') AS rtrim
FROM dual;



-----숫자관련 함수
--round(값,소수점 자리수) 만약 음수이면 자연수 자릿수
SELECT 
	ROUND(1234.5678)   AS round_0,
	ROUND(1234.4678)   AS not_round_0,
	ROUND(1234.5678,1) AS round_1,
	ROUND(1234.5478,1) AS not_round_1,
	ROUND(1234.5678,2) AS round_2,
	ROUND(1234.5648,2) AS not_round_2,
	ROUND(1234.5648,-1) AS round_negative_1,
	ROUND(1235.5648,-1) AS not_round_negative_1,
	ROUND(1254.5648,-2) AS round_negative_2,
	ROUND(1235.5648,-2) AS not_round_negative_2
FROM dual;


--절사
SELECT 
	TRUNC(1234.5678)   AS trunc_0,
	TRUNC(1234.4678)   AS not_trunc_0,
	TRUNC(1234.5678,1) AS trunc_1,
	TRUNC(1234.5478,1) AS not_trunc_1,
	TRUNC(1234.5678,2) AS trunc_2,
	TRUNC(1234.5648,2) AS not_trunc_2,
	TRUNC(1234.5648,-1) AS trunc_negative_1,
	TRUNC(1235.5648,-1) AS not_trunc_negative_1,
	TRUNC(1254.5648,-2) AS trunc_negative_2,
	TRUNC(1235.5648,-2) AS not_trunc_negative_2
FROM dual;


SELECT 
	CEIL(3.14) AS ceil,
	FLOOR(3.94) AS floor
FROM dual;

SELECT MOD(10,2) AS mod_1
FROM dual;


--날짜 관련 함수....
SELECT SYSDATE FROM dual;

--어제
SELECT 
	SYSDATE - 1 AS yesterday,
	SYSDATE + 1 AS tomorrow,
	SYSDATE + 30 AS after_month
FROM dual;

SELECT 
	SYSDATE AS now,
	ADD_MONTHS(SYSDATE,3) AS after_one_month
FROM dual;

-- 모든 사원의 10주년 뽑아보기... 
SELECT * FROM emp; 

SELECT EMPNO,ename,HIREDATE,ADD_MONTHS(HIREDATE,120) AS ten_annuary FROM emp;


-- 몇달 차이...
SELECT empno,ename,hiredate, sysdate ,
MONTHS_BETWEEN(HIREDATE,SYSDATE) AS month01 ,
MONTHS_BETWEEN(SYSDATE,hiredate) AS month02 ,
TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)) AS trunc_month ,
TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)/12) AS trunc_year
FROM emp;

SELECT SYSDATE,
	NEXT_DAY(SYSDATE,'월요일'),
	NEXT_DAY(SYSDATE,'목요일'),
	LAST_DAY(SYSDATE) 
FROM dual;

--세기   21c,  2001
-- cc 세기
-- YYYY 4자리 연도
-- Q 분기
-- DDD 365기분 몇번재 날인지...
SELECT SYSDATE,
	ROUND(SYSDATE,'CC') AS format_CC,
	ROUND(SYSDATE,'YYYY') AS format_YYYY,
	ROUND(SYSDATE,'Q') AS format_Q,
	ROUND(SYSDATE,'DDD') AS format_DDD,
	ROUND(SYSDATE,'HH') AS format_HH
FROM dual;

SELECT SYSDATE,
	TRUNC(SYSDATE,'CC') AS format_CC,
	TRUNC(SYSDATE,'YYYY') AS format_YYYY,
	TRUNC(SYSDATE,'Q') AS format_Q,
	TRUNC(SYSDATE,'DDD') AS format_DDD,
	TRUNC(SYSDATE,'HH') AS format_HH
FROM dual;


--형변환  type casting  자기가 봐서 대강 바꿀만 하다 싶으면 바꿔줌..  명시적
SELECT empno,ename,empno+'1000' FROM emp;

ALTER SESSION SET NLS_LANGUAGE= 'TRADITIONAL CHINESE';

-- TO_CHAR
SELECT sysdate,
	TO_CHAR(SYSDATE,'YYYY/MM/DD / HH24 : MI : SS')  AS now,
	TO_CHAR(SYSDATE,'YYYY/MM/DD / AM HH : MI : SS')  AS now_apm,
	TO_CHAR(SYSDATE,'DAY, DDTH MON YYYY','NLS_DATE_LANGUAGE=ENGLISH')  AS now02
FROM dual;



SELECT TO_NUMBER('1234', '999,999')
  FROM DUAL;

SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,200','999,999') 
AS num FROM dual;

SELECT TO_NUMBER('123.456','999.999') AS num FROM dual;

SELECT TO_DATE('2024-11-06','YYYY-MM-DD') AS now01
FROM dual;

--1982-06-01 이후 입사자들만 출력
SELECT ename,hiredate FROM emp WHERE HIREDATE > TO_DATE('1981/06/01','YYYY/MM/DD');

-- null 처리 함수
SELECT empno,ename,sal,comm,sal+nvl(comm,0) FROM emp;

-- comm이 있는지 없는지  o,x
SELECT empno,ename,sal,comm,nvl2(comm,'o','x') FROM emp;



-- decode 오라클 전용함수 ansi 함수 (표준)   vs 오라클
-- 조건 if else

-- sal manager 10%인상,salesman 5%인상 analyst는 연봉동결 나머지는 3%인상
SELECT empno,ename,job,sal, 
	DECODE(JOB,
		'MANAGER', SAL*1.1,
		'SALESMAN', SAL*1.05,
		'ANALYST', SAL ,
		SAL * 1.03
	) AS upsal
FROM emp;

WITH temp AS (
	SELECT 'M' gender FROM dual UNION ALL
	SELECT 'F' gender FROM dual UNION ALL
	SELECT 'X' gender FROM dual
)
SELECT gender, 
	DECODE(gender,
		'M', '남자',
		'F', '여자',
		'기타'
	)  AS gender_kor
FROM temp; 

SELECT job FROM emp;

--gender_kor m 남자 f 여자 기타

SELECT ename,job,
	DECODE(job,
		'CLERK','사원',
		'SALESMAN','영업사원',
		'MANAGER','관리자',
		'PRESIDENT','회장',
		'ANALYST','분석가',
		'기타'		
	) AS job_kor
FROM emp;

SELECT ename,job,
	CASE job
		WHEN 'MANAGER' THEN sal*1.1
		WHEN 'SALESMAN' THEN sal*1.05
		WHEN 'ANALYST' THEN sal
		ELSE sal*1.03
	END AS upsal
FROM emp;


SELECT ename,job,
	DECODE(job,
		'CLERK','사원',
		'SALESMAN','영업사원',
		'MANAGER','관리자',
		'PRESIDENT','회장',
		'ANALYST','분석가',
		'기타'		
	) AS job_kor
FROM emp;

--switch 방식
SELECT ename, job,
	CASE JOB 
		WHEN 'CLERK' THEN '사원'
		WHEN 'SALESMAN' THEN '영업사원'
		WHEN 'MANAGER' THEN '관리자'
		WHEN 'PRESIDENT' THEN '회장'
		WHEN 'ANALYST' THEN '분석가'
		ELSE '기타'
	END AS job_kor
FROM emp;

--if else if else 방식
SELECT ename, job,
	CASE  
		WHEN JOB = 'CLERK' THEN '사원'
		WHEN JOB = 'SALESMAN' THEN '영업사원'
		WHEN JOB = 'MANAGER' THEN '관리자'
		WHEN JOB = 'PRESIDENT' THEN '회장'
		WHEN JOB = 'ANALYST' THEN '분석가'
		ELSE '기타'
	END AS job_kor
FROM emp;

--sal을 가지고 2900 이상이면 1등급 2700이상이면 2등급 2000이상 이면 3등급 4등급

SELECT ename, job, sal,
   CASE 
      WHEN sal >= 2900 THEN '1등급'
      WHEN sal >= 2700 THEN '2등급'
      WHEN sal >= 2000 THEN '3등급'
      ELSE '4등급'
   END AS grade
FROM emp ORDER BY sal desc;

SELECT ename, hiredate FROM emp;  -- 입사일이 1분기, 2분기,3분기, 4분기 인지 출력 		


SELECT HIREDATE,
	CASE 
		WHEN TO_CHAR(hiredate,'q') = '1' THEN '1분기'
		WHEN TO_CHAR(hiredate,'q') = '2' THEN '2분기'
		WHEN TO_CHAR(hiredate,'q') = '3' THEN '3분기'
		WHEN TO_CHAR(hiredate,'q') = '4' THEN '4분기'
	END AS quarter
 FROM emp;

SELECT HIREDATE,
	CASE TO_CHAR(hiredate,'q') 
		WHEN '1' THEN '1분기'
		WHEN '2' THEN '2분기'
		WHEN '3' THEN '3분기'
		WHEN '4' THEN '4분기'
	END AS quarter
 FROM emp;

-- deptno = 10 부서일때 sal 2000 보다 크면 1등급 1500크면 2등급 1000보다 크면 3등급
-- deptno = 20 부서일때 sal 3000 보다 크면 1등급 2500크면 2등급 2000보다 크면 3등급
-- deptno = 30 부서일때 sal 2500 보다 크면 1등급 2000크면 2등급 1500보다 크면 3등급

SELECT ename, sal, deptno FROM emp;
--please give me a code

SELECT ename,sal,deptno,
   CASE 
      WHEN deptno = 10 THEN 
      	CASE
      		WHEN sal >= 2000 THEN '1등급'
      		WHEN sal >= 1500 THEN '2등급'
      		WHEN sal >= 1000 THEN '3등급'
      		ELSE '4등급'
      	END
      WHEN deptno = 20 THEN 
      	CASE
      		WHEN sal >= 3000 THEN '1등급'
      		WHEN sal >= 2500 THEN '2등급'
      		WHEN sal >= 2000 THEN '3등급'
      		ELSE '4등급'
      	END
      WHEN deptno = 30 THEN
      	CASE
      		WHEN sal >= 2500 THEN '1등급'
      		WHEN sal >= 2000 THEN '2등급'
      		WHEN sal >= 1500 THEN '3등급'
      		ELSE '4등급'
      	END
   END AS sal_grade
FROM emp;

SELECT * FROM emp;






-----practice01
SELECT empno, 
	   RPAD(SUBSTR(empno,1,2),4,'*') AS masking_empno,
	   ename,
	   RPAD(SUBSTR(ename,1,1),LENGTH(ENAME),'*') AS masking_ename 
FROM emp;

-----practice02
SELECT empno,ename,sal,
	   TRUNC(sal/21.5,2) AS day_pay	,
	   ROUND(sal/21.5/8,1) AS time_pay
FROM emp;

-----practice03
SELECT empno,ename,hiredate,
	   TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일'),'YYYY-MM-DD') AS r_day,
	   NVL(TO_CHAR(comm),'N/A') AS comm
FROM emp;

SELECT * FROM emp;

--practice04

SELECT empno,ename,mgr,
	CASE
		WHEN MGR IS NULL THEN 0000
		WHEN SUBSTR(MGR,1,2) = 75 THEN 5555
		WHEN SUBSTR(MGR,1,2) = 76 THEN 6666
		WHEN SUBSTR(MGR,1,2) = 77 THEN 7777
		WHEN SUBSTR(MGR,1,2) = 78 THEN 8888
		ELSE MGR 
	END AS chg_mgr
FROM emp;

-- group 함수 / 다중행 함수





