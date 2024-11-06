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

ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';

-- TO_CHAR
SELECT sysdate,
	TO_CHAR(SYSDATE,'YYYY/MM/DD / HH24 : MI : SS')  AS now,
	TO_CHAR(SYSDATE,'YYYY/MM/DD / AM HH : MI : SS')  AS now_apm,
	TO_CHAR(SYSDATE,'DAY, DDTH MON YYYY','NLS_DATE_LANGUAGE=ENGLISH')  AS now02
FROM dual;










