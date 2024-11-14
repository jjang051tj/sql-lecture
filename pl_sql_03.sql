--배열
DECLARE
	/*
	TYPE ITAB_EX(이름) IS TABLE OF VARCHAR2(20)(자료형)
		INDEX BY PLS_INTEGER;
	*/
	--일반프로그래밍에 배열과 같다.
	TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
		INDEX BY PLS_INTEGER;
	text_arr ITAB_EX;
	--두자리 정수만들어서 출력
BEGIN
	text_arr(1) := 'first';
	text_arr(2) := 'second';
	text_arr(3) := 'third';
	text_arr(4) := '4th';
	dbms_output.put_line('text_arr(1) : '|| text_arr(1));
	dbms_output.put_line('text_arr(2) : '|| text_arr(2));
	dbms_output.put_line('text_arr(3) : '|| text_arr(3));
	dbms_output.put_line('text_arr(4) : '|| text_arr(4));
END;


DECLARE
	TYPE ITAB_EX IS TABLE OF NUMBER(2)
		INDEX BY PLS_INTEGER;
	num_arr ITAB_EX;
	--두자리 정수만들어서 출력
BEGIN
	num_arr(1) := 10;
	num_arr(2) := 20;
	num_arr(3) := 30;
	num_arr(4) := 40;
	dbms_output.put_line('num_arr(1) : '|| num_arr(1));
	dbms_output.put_line('num_arr(2) : '|| num_arr(2));
	dbms_output.put_line('num_arr(3) : '|| num_arr(3));
	dbms_output.put_line('num_arr(4) : '|| num_arr(4));
END;

--record class 랑 같다..

DECLARE
	TYPE REC_DEPT IS RECORD(
		deptno DEPT.DEPTNO%TYPE,
		dname DEPT.DNAME%TYPE,
		loc DEPT.loc%TYPE
	);
	TYPE ITAB_DEPT IS TABLE OF REC_DEPT
		 INDEX BY PLS_INTEGER;
	dept_arr ITAB_DEPT;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
		idx := idx + 1;
		dept_arr(idx).deptno := i.deptno;
		dept_arr(idx).dname := i.dname;
		dbms_output.put_line
			(dept_arr(idx).deptno || ':'|| dept_arr(idx).dname);
	END LOOP;
END;
-- emp ename,empno,sal


DECLARE
	TYPE REC_EMP IS RECORD(
		empno emp.empno%TYPE,
		ename emp.ename%TYPE,
		sal emp.sal%TYPE
	);
	TYPE ITAB_EMP IS TABLE OF REC_EMP
		 INDEX BY PLS_INTEGER;
	emp_arr ITAB_EMP;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN (SELECT ename,empno, sal FROM emp) LOOP
		idx := idx+1;
		emp_arr(idx).empno :=  i.empno;
		emp_arr(idx).ename :=  i.ename;
		emp_arr(idx).sal :=  i.sal;
		dbms_output.put_line
			(emp_arr(idx).empno || ':'|| emp_arr(idx).ename|| ':'|| emp_arr(idx).sal);
	END LOOP;
END;

DECLARE
	TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
		INDEX BY PLS_INTEGER;
	dept_arr ITAB_DEPT;
	idx PLS_INTEGER := 0; 
BEGIN
	FOR i IN (SELECT * FROM dept) LOOP
		idx := idx+1;
		dept_arr(idx).deptno := i.deptno;
		dept_arr(idx).dname := i.dname;
		dept_arr(idx).loc := i.loc;
		dbms_output.put_line(dept_arr(idx).deptno ||':'
							||dept_arr(idx).dname|| ':'||dept_arr(idx).loc);
	END LOOP;
END;
--emp

DECLARE
	--collection이라고 부르는데 배열 같은 타입을 가지고 있는 배열
	--collection에도 메서드 
	TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
		INDEX BY PLS_INTEGER;
	emp_arr ITAB_EMP;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN (SELECT * FROM emp) LOOP
		idx := idx+1;
		emp_arr(idx).empno := i.empno;
		emp_arr(idx).ename := i.ename;
		emp_arr(idx).sal := i.sal;
		dbms_output.put_line(emp_arr(idx).empno || ':'||emp_arr(idx).ename||':'||
			emp_arr(idx).sal
		);
	END LOOP;
	dbms_output.put_line('emp_arr.count : '||emp_arr.count);
	dbms_output.put_line('emp_arr.first : '||emp_arr.first);
	dbms_output.put_line('emp_arr.last : '||emp_arr.last);
	dbms_output.put_line('emp_arr.prior(10) : '||emp_arr.PRIOR(1));
	dbms_output.put_line('emp_arr.next(10) : '||emp_arr.NEXT(13));
END;



--practice01
CREATE TABLE emp_record AS 
 SELECT * FROM emp WHERE 1!=1;
SELECT * FROM emp_record;

DECLARE
	TYPE RECORD_EMP IS RECORD(
		empno    emp.empno%TYPE NOT NULL DEFAULT 9999,
		ename    emp.ename%TYPE ,
		job      emp.job%TYPE,
		mgr      emp.job%TYPE,
		hiredate emp.hiredate%TYPE,
		sal      emp.sal%TYPE,
		comm     emp.comm%TYPE,
		deptno   emp.deptno%TYPE
	);
	v_emp_rec RECORD_EMP;
BEGIN
	v_emp_rec.empno := 1111;
	v_emp_rec.ename    := 'jjang051';
	v_emp_rec.job      := 'CLERK';
	v_emp_rec.mgr      := null;
	v_emp_rec.hiredate := TO_DATE('2024/11/14','YYYY/MM/DD');
	v_emp_rec.sal      := 2400;
	v_emp_rec.comm     := null;
	v_emp_rec.deptno   := 40;
	INSERT INTO emp_record VALUES v_emp_rec;
END;
SELECT * FROM emp_record;
COMMIT;

--practice02
DECLARE
	TYPE ITABLE_EMP IS TABLE OF emp%ROWTYPE
		INDEX BY PLS_INTEGER;
	emp_arr ITABLE_EMP;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN (SELECT * FROM emp) LOOP
		idx := idx+1;
		emp_arr(idx).empno    := i.empno;
		emp_arr(idx).ename    := i.ename;
		emp_arr(idx).job      := i.job;
		emp_arr(idx).mgr      := i.mgr;
		emp_arr(idx).hiredate := i.hiredate;
		emp_arr(idx).sal      := i.sal;
		emp_arr(idx).comm     := i.comm;
		emp_arr(idx).deptno   := i.deptno;
		dbms_output.put_line(
			emp_arr(idx).empno    ||':'||
			emp_arr(idx).ename    ||':'||
			emp_arr(idx).job      ||':'||
			emp_arr(idx).mgr      ||':'||
			emp_arr(idx).hiredate ||':'||
			emp_arr(idx).sal      ||':'||
			emp_arr(idx).comm     ||':'||
			emp_arr(idx).deptno
		);
	END LOOP;
END;

--cursor
SELECT * FROM emp;




