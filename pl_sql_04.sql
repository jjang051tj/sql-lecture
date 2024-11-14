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









