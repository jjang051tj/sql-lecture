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
	v_deptno scott.dept.deptno%TYPE := 50;
BEGIN 
	dbms_output.put_line('v_deptno = '|| v_deptno);
END;




