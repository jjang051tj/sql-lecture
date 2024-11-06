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








