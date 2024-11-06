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



