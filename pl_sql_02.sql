-- pl/sql record는 자바의 class랑 같다.
DECLARE 
	TYPE REC_DEPT IS RECORD(
		deptno NUMBER(2) NOT NULL := 90,
		dname  dept.dname%TYPE,
		loc    dept.loc%TYPE
	);
	v_dept_rec REC_DEPT;
BEGIN
	v_dept_rec.deptno := 90;
	v_dept_rec.dname  := 'DATABASE';
	v_dept_rec.loc    := 'SEOUL';
	dbms_output.put_line('deptno : '||v_dept_rec.deptno);
	dbms_output.put_line('dname : '||v_dept_rec.dname);
	dbms_output.put_line('loc : '||v_dept_rec.loc);
END;


CREATE TABLE dept_record AS SELECT * FROM dept;
SELECT * FROM dept_record;
DECLARE 
	TYPE REC_DEPT IS RECORD(
		deptno NUMBER(2) NOT NULL := 90,
		dname  dept.dname%TYPE,
		loc    dept.loc%TYPE
	);
	v_dept_rec REC_DEPT;
BEGIN
	v_dept_rec.deptno := 90;
	v_dept_rec.dname  := 'DATABASE';
	v_dept_rec.loc    := 'SEOUL';
	INSERT INTO dept_record VALUES v_dept_rec;
END;

-- emp_record_type이라는 record를 하나 만드는데
-- 타입과 이름은 전부 emp와 동일하게 하고 
-- emp에 입력하는 pl/sql을 만드시오....
SELECT * FROM emp;
DECLARE
	TYPE emp_record_type IS RECORD (
		empno emp.empno%TYPE,
		ename emp.ename%TYPE,
		job emp.job%TYPE,
		mgr emp.mgr%TYPE,
		hiredate emp.hiredate%TYPE,
		sal emp.sal%TYPE,
		comm emp.comm%TYPE,
		deptno emp.deptno%TYPE
	);
	v_emp emp_record_type;
BEGIN
	v_emp.empno := 9993;
	v_emp.ename := 'jjang051';
	v_emp.job := 'CLERK';
	v_emp.mgr := 7839;
	v_emp.hiredate := TO_DATE('2024-11-13','YYYY-MM-DD');
	v_emp.sal := 2100;
	v_emp.comm := null;
	v_emp.deptno := 20;
	INSERT INTO emp VALUES v_emp;
END;






