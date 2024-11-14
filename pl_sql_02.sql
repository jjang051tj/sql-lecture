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
	-- 괄호 생략할땐 순서 맞춰서 넣으세요.
	INSERT INTO emp VALUES v_emp;
END;




--procedural language sql  
--sql에 프로그램적인 요소를 집어넣어서 만든 언어
--변수/함수

DECLARE
	--변수 설정
	-- sql에서 = 같다라는 의미이므로 사용 불가 값을 변수에 대입할때는 :=
	v_empno NUMBER(4) := 9998;
	v_pi CONSTANT NUMBER(3,2) := 3.14;
	v_deptno NUMBER(2) DEFAULT 10; 
	v_deptno02 NUMBER(2) NOT NULL DEFAULT 20;
	--참조용 변수
	v_deptno03 dept.deptno%TYPE := 30; 
	v_dept_row dept%ROWTYPE; 
BEGIN
	--여기에 플로그래밍 하면 된다.
	dbms_output.put_line('hello plsql');
	dbms_output.put_line('empno : '|| v_empno);
	dbms_output.put_line('v_pi : '|| v_pi);
	dbms_output.put_line('v_deptno : '|| v_deptno);
	dbms_output.put_line('v_deptno02 : '|| v_deptno02);
	dbms_output.put_line('v_deptno03 : '|| v_deptno03);
END;

DECLARE
	--dept의 행 전체를 참조한다.
	v_dept_row dept%ROWTYPE;
BEGIN
	SELECT deptno,dname,loc INTO v_dept_row
	FROM DEPT d
	WHERE deptno=40;
	dbms_output.put_line('deptno : '|| v_dept_row.deptno);
	dbms_output.put_line('dname : '|| v_dept_row.dname);
	dbms_output.put_line('loc : '|| v_dept_row.loc);
END;

DECLARE
	v_num NUMBER := 12;
BEGIN
	IF mod(v_num,2) = 1 THEN
		dbms_output.put_line('홀수입니다.');
	ELSE 
		dbms_output.put_line('짝수입니다.');
	END IF;
END;


DECLARE
	v_num NUMBER := 87;
BEGIN
	IF v_num >= 90 THEN
		dbms_output.put_line('A');
	ELSIF v_num >= 80 THEN
		dbms_output.put_line('B');
	ELSE 
		dbms_output.put_line('F');
	END IF;
END;

DECLARE
	v_num NUMBER := 87;
BEGIN
	CASE
		WHEN v_num >= 90 THEN
			dbms_output.put_line('A');
		WHEN v_num >= 80 THEN
			dbms_output.put_line('B');
		ELSE 
			dbms_output.put_line('F');
	END CASE;
END;

--loop
DECLARE
	v_num NUMBER := 0;
BEGIN
	LOOP
		dbms_output.put_line(v_num);
		v_num:=v_num+1;
		EXIT WHEN v_num >= 10;
	END LOOP;
END;

DECLARE
	v_num NUMBER := 0;
BEGIN
	LOOP
		dbms_output.put_line(v_num);
		v_num:=v_num+1;
		IF v_num >= 10 THEN
			EXIT;
		END IF;
	END LOOP;
END;

DECLARE
	v_num NUMBER := 0;
BEGIN
	WHILE v_num <= 10 LOOP
		dbms_output.put_line(v_num);
		v_num:=v_num+1;
	END LOOP;
END;

DECLARE
	v_num NUMBER := 0;
BEGIN
	FOR i IN 0..10 LOOP
		dbms_output.put_line(i);
	END LOOP;
END;














