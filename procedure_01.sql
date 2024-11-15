CREATE OR REPLACE PROCEDURE pro_noparam 
IS
	V_EMPNO NUMBER(4) := 9988;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;

--EXEC pro_noparam;

DROP PROCEDURE pro_noparam;

BEGIN
	pro_noparam;
END;


CREATE OR REPLACE PROCEDURE pro_param_in(
	param01 IN NUMBER,
	param02 NUMBER,
	param03 NUMBER := 3,
	param04 NUMBER DEFAULT 4
)
IS 
BEGIN 
	DBMS_OUTPUT.PUT_LINE('PARAM01 : '||PARAM01);
	DBMS_OUTPUT.PUT_LINE('PARAM02 : '||PARAM02);
	DBMS_OUTPUT.PUT_LINE('PARAM03 : '||PARAM03);
	DBMS_OUTPUT.PUT_LINE('PARAM04 : '||PARAM04);
END;

BEGIN
	pro_param_in(1000,2000);
	pro_param_in(1000,2000,param03=>150);
	pro_param_in
	(param01=>100,param02=>300,param03=>10,param04=>500);
END;

--함수를 만들때 리턴값을 만들 수 있듯이 프로시져도 이게 가능
CREATE OR REPLACE PROCEDURE pro_param_out(
	in_empno IN emp.empno%TYPE,
	out_ename OUT emp.ename%TYPE,
	out_sal OUT emp.sal%TYPE
)
IS
BEGIN
	SELECT ename,sal INTO out_ename,out_sal FROM emp
	WHERE empno =  in_empno;
END pro_param_out;

DECLARE 
	v_ename emp.ename%TYPE;
	v_sal emp.sal%TYPE;
BEGIN
	pro_param_out(7369,v_ename,v_sal);
	dbms_output.put_line('ename : '|| v_ename);
	dbms_output.put_line('sal : '|| v_sal);
END;


















