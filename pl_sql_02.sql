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



