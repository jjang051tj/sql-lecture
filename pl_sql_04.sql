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
--dept출력

-- 명시적 커서
DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
	V_DEPTNO DEPT.DEPTNO%TYPE;
	CURSOR C01(P_DEPTNO DEPT.DEPTNO%TYPE) IS
		SELECT * FROM dept
		WHERE DEPTNO = P_DEPTNO;
BEGIN 
	OPEN c01(10);
	LOOP 
		FETCH c01 INTO V_DEPT_ROW;
		EXIT WHEN c01%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('10번 부서 DEPTNO : '|| V_DEPT_ROW.DEPTNO 
							  || 'DNAME  : '|| V_DEPT_ROW.DNAME 
							  || 'LOC    : '|| V_DEPT_ROW.LOC
							 );
	END LOOP;
	CLOSE c01;
	OPEN c01(20);
	LOOP 
		FETCH c01 INTO V_DEPT_ROW;
		EXIT WHEN c01%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('20번 부서 DEPTNO : '|| V_DEPT_ROW.DEPTNO 
							  || 'DNAME  : '|| V_DEPT_ROW.DNAME 
							  || 'LOC    : '|| V_DEPT_ROW.LOC
							 );
	END LOOP;
	CLOSE c01;
END;


ROLLBACK;
SELECT * FROM dept;
INSERT INTO dept VALUES (50,'WEB','SEOUL');
--묵시적 커서
BEGIN
	UPDATE DEPT SET DNAME = 'DATABASE' 
	WHERE DEPTNO = 50;
	DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
	IF (SQL%NOTFOUND) THEN 
		DBMS_OUTPUT.PUT_LINE('갱신할 행이 없다');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('갱신할 행이 있다');
	END IF;
	--묵시적 커서는 구문에 나타나지 않지만 존재하고 있는 cursor이다.
    --키워드 sql로 접근하면 된다.
END;



--practice01
--명시적 커서를 사용하여 EMP 테이블의 전체 데이터를 조회한 후 커서 안의 
--데이터가 다음과 같이 출력되도록 PL/SQL문을 작성해 보세요.            
--① LOOP를 사용한 방식           
--② FOR LOOP를 사용한 방식

DECLARE
	V_EMP_ROW EMP%ROWTYPE;
	CURSOR c01 IS 
		SELECT * FROM EMP;
BEGIN
	OPEN c01;
		LOOP
			FETCH c01 INTO V_EMP_ROW;
			EXIT WHEN C01%NOTFOUND;
			dbms_output.put_line(
				'empno   : '|| V_EMP_ROW.empno ||
				',ename  : '|| V_EMP_ROW.ename ||
				',job    : '|| V_EMP_ROW.job   ||
				',sal    : '|| V_EMP_ROW.sal   ||
				',deptno : '|| V_EMP_ROW.empno
			);
		END LOOP;
	CLOSE c01;
END;



DECLARE
	CURSOR c01 IS 
		SELECT * FROM EMP;
BEGIN
	FOR C01_RECORD IN C01 LOOP 
			DBMS_OUTPUT.PUT_LINE(
				'EMPNO   : '|| C01_RECORD.EMPNO ||
				',ENAME  : '|| C01_RECORD.ENAME ||
				',JOB    : '|| C01_RECORD.JOB   ||
				',SAL    : '|| C01_RECORD.SAL   ||
				',DEPTNO : '|| C01_RECORD.EMPNO
			);
	END LOOP;
END;








