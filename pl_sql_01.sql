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
 	






