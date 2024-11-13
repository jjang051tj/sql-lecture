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

-- if , for






