-- block

--DECLARE는 변수 선언하는 곳
DECLARE 
	v_empno number(4) := 7788;
	v_ename varchar2(20);
BEGIN
	v_ename := 'scott';
	dbms_output.put_line('v_empno = '||v_empno);
	dbms_output.put_line('v_ename = ' || v_ename );
END;


DECLARE 
	v_tax constant number(1) := 3;
	v_deptno number(2) DEFAULT 10;
BEGIN
	dbms_output.put_line('v_tax = '|| v_tax);
	dbms_output.put_line('v_deptno = '|| v_deptno);
END;

DECLARE 
	-- not null을 쓰면 값에 null이 들어가면 안된다
	v_deptno number(2) NOT NULL DEFAULT 80;
BEGIN
	v_deptno := 30;
	dbms_output.put_line('v_deptno = '|| v_deptno);
END;

DECLARE 
	v_deptno dept.deptno%TYPE := 50;
BEGIN 
	dbms_output.put_line('v_deptno = '|| v_deptno);
END;

DECLARE 
	-- 한줄 또는 한행의 변수에 값을 대입할때...
	v_dept_row dept%ROWTYPE;
BEGIN 
	SELECT deptno, dname, loc INTO v_dept_row FROM dept
	WHERE deptno = 40;
	dbms_output.put_line('deptno = '|| v_dept_row.deptno);
	dbms_output.put_line('dname = '|| v_dept_row.dname);
	dbms_output.put_line('loc = '|| v_dept_row.loc);
END;

--IF 조건 then
DECLARE
	v_number NUMBER := 14;
BEGIN
	IF mod(v_number,2) = 1 THEN
		dbms_output.put_line('v_number는 홀수 입니다.');
	ELSE 
		dbms_output.put_line('v_number는 짝수 입니다.');
	END IF; 
END;

--학점
DECLARE 
	v_score NUMBER := 87;
BEGIN
	IF v_score >= 90 THEN 
		dbms_output.put_line('A학점');
	ELSIF v_score >= 80 THEN
		dbms_output.put_line('B학점');
	ELSIF v_score >= 70 THEN
		dbms_output.put_line('C학점');
	ELSIF v_score >= 60 THEN
		dbms_output.put_line('D학점');
	ELSE
		dbms_output.put_line('F학점');
	END IF;
END;


--switch 
DECLARE 
	v_score NUMBER := 87;
BEGIN
	CASE TRUNC(v_score/10) 
		WHEN 10 THEN dbms_output.put_line('A학점');
		WHEN  9 THEN dbms_output.put_line('A학점');
		WHEN  8 THEN dbms_output.put_line('B학점');
		WHEN  7 THEN dbms_output.put_line('C학점');
		WHEN  6 THEN dbms_output.put_line('D학점');
		ELSE dbms_output.put_line('F학점');
	END CASE;
END;

DECLARE 
	v_score NUMBER := 87;
BEGIN
	CASE  
		WHEN v_score>=100 THEN dbms_output.put_line('A학점');
		WHEN v_score>=90  THEN dbms_output.put_line('A학점');
		WHEN v_score>=80  THEN dbms_output.put_line('B학점');
		WHEN v_score>=70  THEN dbms_output.put_line('C학점');
		WHEN v_score>=60  THEN dbms_output.put_line('D학점');
		ELSE dbms_output.put_line('F학점');
	END CASE;
END;


--반복문
--기본 반복문 while / for
DECLARE
	v_num NUMBER := 0;
BEGIN
	LOOP 
		dbms_output.put_line('현재 v_num : ' || v_num);
		v_num := v_num+1;
		EXIT WHEN v_num > 10;
	END LOOP;
END;
 
--while loop
DECLARE
	v_num NUMBER := 0;
BEGIN
	WHILE v_num < 10 LOOP  
		dbms_output.put_line('현재 v_num : ' || v_num);
		v_num := v_num+1;
	END LOOP;
END;
 

--for loop
DECLARE
	--v_num NUMBER := 0;
--  in 다음에 reverse 를 쓰면 거꾸로 된다.
BEGIN
	FOR i IN 0..10 LOOP   
		CONTINUE WHEN mod(i,2) = 1;
		dbms_output.put_line('현재 i : ' || i);
	END LOOP;
END;
 	
--if 문 넣어서 쓸때
BEGIN
	FOR i IN 0..10 LOOP 
		IF mod(i,2) = 1 THEN 
			CONTINUE;
		END IF;
		dbms_output.put_line('현재 i : ' || i);
	END LOOP;
END;


--if 문 넣어서 쓸때
BEGIN
	FOR i IN 0..10 LOOP 
		IF i >= 5 THEN 
			EXIT;
		END IF;
		dbms_output.put_line('현재 i : ' || i);
	END LOOP;
END;





--practice01
DECLARE

BEGIN
	FOR i IN 1..10 LOOP
		CONTINUE WHEN MOD(i,2) = 0; 
		dbms_output.put_line('현재 i의 : '||i);
	END LOOP;
END;

DECLARE

BEGIN
	FOR i IN 1..10 LOOP
		IF MOD(i,2) = 1 THEN
			dbms_output.put_line('현재 i의 : '||i);
		END IF;
	END LOOP;
END;


DECLARE

BEGIN
	FOR i IN 1..10 LOOP
		IF MOD(i,2) = 0 THEN
			CONTINUE; 	
		END IF;
		dbms_output.put_line('현재 i의 : '||i);
	END LOOP;
END;


--break 대신 exit를 쓴다,
BEGIN
	FOR i IN 1..10 LOOP
		IF i > 5 THEN
			EXIT; 	
		END IF;
		dbms_output.put_line('현재 i의 : '||i);
	END LOOP;
END;


-- DEPT 테이블의 DEPTNO와 자료형이 같은 변수 V_DEPTNO를 선언합니다. 
-- 그리고 V_DEPTNO 변수 값에 10, 20, 30, 40을 대입했을 때 
-- 다음과 같이 부서 이름을 출력하는 프로그램을 작성해 보세요. 
-- 단 부서 번호가 10, 20, 30, 40이 아니면 N/A로 출력합니다.

SELECT * FROM dept;
DECLARE 
	v_deptno dept.deptno%TYPE := 10;
BEGIN 
	CASE v_deptno
		WHEN 10 THEN dbms_output.put_line('dname : ACCOUNTING');
		WHEN 20 THEN dbms_output.put_line('dname : RESEARCH');
		WHEN 30 THEN dbms_output.put_line('dname : SALES');
		WHEN 40 THEN dbms_output.put_line('dname : OPERATIONS');
		ELSE  dbms_output.put_line('dname : N/A');
	END CASE;
END;

DECLARE 
	v_deptno dept.deptno%TYPE := 10;
BEGIN 
	IF  v_deptno = 10 THEN dbms_output.put_line('dname : ACCOUNTING');
		ELSIF v_deptno = 20 THEN dbms_output.put_line('dname : RESEARCH');
	    ELSIF v_deptno = 30 THEN dbms_output.put_line('dname : SALES');
		ELSIF v_deptno = 40 THEN dbms_output.put_line('dname : OPERATIONS');
		ELSE  dbms_output.put_line('dname : N/A');
	END IF;
END;

-- v_age를 숫자로 입력 받아서 19세 이상이면 성인
-- 13세 이상 19세 미만이면 청소년
-- 나머지는 어린이 출력
   
DECLARE
	v_age NUMBER := 20;
BEGIN
	IF v_age >= 19 THEN
		dbms_output.put_line('성인');
		ELSIF v_age >= 13 AND v_age < 19 THEN
			dbms_output.put_line('청소년');
		ELSE dbms_output.put_line('청소년');
	END IF;
END;




