--procedure 
--많이 쓰는 것들을 저장해놓고 불러다 쓰기

CREATE OR REPLACE PROCEDURE pro_noparam
IS 
	V_EMPNO NUMBER(4) := 7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : '||V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : '||V_ENAME);
END;

EXECUTE pro_noparam;



	