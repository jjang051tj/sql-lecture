DECLARE
	v_dept_row dept%ROWTYPE;
BEGIN
	--select into 구문은 결과가 한줄일때만 쓸 수 있다. 
	-- 대부분 여러줄 또는 한줄일때도 사용 가능한 cursor를 사용한다.
	SELECT deptno, dname,loc INTO v_dept_row
	FROM dept
	WHERE deptno=40;
	dbms_output.put_line('deptno : '||v_dept_row.deptno);
	dbms_output.put_line('dname : '||v_dept_row.dname);
	dbms_output.put_line('loc : '||v_dept_row.loc);
END;

-- 커서를 사용한 출력
DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
	CURSOR c01 IS 
		SELECT deptno,dname,loc
		FROM dept
		WHERE deptno = 40;
BEGIN
	OPEN c01;
	FETCH c01 INTO V_DEPT_ROW;
		DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
		DBMS_OUTPUT.PUT_LINE('DNAME  : '|| V_DEPT_ROW.DNAME);
		DBMS_OUTPUT.PUT_LINE('LOC    : '|| V_DEPT_ROW.LOC);
	CLOSE c01;
END;

--여러줄일때  loop
DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
	CURSOR c01 IS 
		SELECT deptno,dname,loc
		FROM dept;
BEGIN
	OPEN c01;
	LOOP
		FETCH c01 INTO V_DEPT_ROW;
--		EXIT WHEN c01%NOTFOUND;
--			DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
--			DBMS_OUTPUT.PUT_LINE('DNAME  : '|| V_DEPT_ROW.DNAME);
--			DBMS_OUTPUT.PUT_LINE('LOC    : '|| V_DEPT_ROW.LOC);
		--  c01%NOTFOUND결과가 있으면 true 없으면 false;
		IF c01%NOTFOUND THEN 
			EXIT;
		ELSE 
			DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
			DBMS_OUTPUT.PUT_LINE('DNAME  : '|| V_DEPT_ROW.DNAME);
			DBMS_OUTPUT.PUT_LINE('LOC    : '|| V_DEPT_ROW.LOC);
		END IF;
	END LOOP;
	CLOSE c01;
END;
--emp출력해보기....

DECLARE
	V_EMP_ROW EMP%ROWTYPE;
	CURSOR c01 IS
		SELECT * FROM emp;
BEGIN 
	OPEN c01;
	LOOP 
		FETCH c01 INTO 	V_EMP_ROW;
		IF c01%NOTFOUND THEN
			EXIT;
		ELSE 
			DBMS_OUTPUT.PUT_LINE('EMPNO  : '|| V_EMP_ROW.EMPNO || 
								 ' - ENAME  : '|| V_EMP_ROW.ENAME || 
								 '- JOB    : '|| V_EMP_ROW.JOB);
		END IF;
	END LOOP; 
	CLOSE c01;
END;

-- for loop
DECLARE
	CURSOR c01 IS
		SELECT * FROM emp;
BEGIN 
	FOR c01_rec IN c01 LOOP 
		DBMS_OUTPUT.PUT_LINE('EMPNO  : '|| c01_rec.EMPNO || 
							 ' - ENAME  : '|| c01_rec.ENAME || 
							 '- JOB    : '|| c01_rec.JOB);
	END LOOP;
END;








