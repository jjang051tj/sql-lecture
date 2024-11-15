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


CREATE OR REPLACE PROCEDURE pro_param_inout (
	inout_no IN OUT NUMBER 
)
IS 
BEGIN
	inout_no := inout_no*2;
END pro_param_inout;


DECLARE
	num NUMBER;
BEGIN
	num := 5;
	pro_param_inout(num);
	dbms_output.put_line('num : '|| num);
END;




CREATE OR REPLACE PROCEDURE pro_err
IS 
	err_no NUMBER;
BEGIN
	err_no := 100;
	dbms_output.put_line('err_no : '||err_no);
END pro_err;

BEGIN
	pro_err;
END;

SELECT * FROM USER_ERRORS;
--SHOW ERRORS;

--함수만들기 내가 만든 함수
CREATE OR REPLACE FUNCTION func_after_tax(
	sal NUMBER
)
RETURN NUMBER
IS 
	tax NUMBER := 0.033;
BEGIN
	RETURN round(sal - (sal*tax));
END func_after_tax;

DECLARE
	after_tax NUMBER;
	money NUMBER;
BEGIN
	money := 3000;
	after_tax:=func_after_tax(money);
	dbms_output.put_line('원금 : '||money || ' / after_tax : '||after_tax);
END;


SELECT func_after_tax(3000) AS after_tax FROM dual;

SELECT empno,ename,sal,func_after_tax(sal) AS after_tax FROM emp;



--emp테이블에서 10번 부서의 sal을 10% 인상하는 프로시져 만들어 보기....

CREATE OR REPLACE PROCEDURE increease_sal 
IS 
BEGIN 
	UPDATE emp SET sal = sal*1.1
	WHERE deptno = 10;
	COMMIT;
END;

BEGIN
	increease_sal;
END;
SELECT * FROM emp;


--이번에는 입력받은 부서의 급여를 입력받은 %만큼 올려주기...

CREATE OR REPLACE PROCEDURE increase_sal02(
    p_deptno NUMBER,
    p_percent NUMBER
)
IS 
BEGIN 
    -- 급여 인상
    UPDATE emp 
    SET sal = sal + sal * (p_percent / 100)
    WHERE deptno = p_deptno;
    
    -- 변경된 부서의 직원들을 출력
    FOR emp_record IN (
        SELECT empno, ename, sal, deptno
        FROM emp
        WHERE deptno = p_deptno
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('EmpNo: ' || emp_record.empno || ', Name: ' || emp_record.ename || ', Salary: ' || emp_record.sal);
    END LOOP;

    COMMIT;  -- 변경 사항을 커밋
END;


-- 프로시저 호출
BEGIN
	increase_sal02(20,10);
END;




CREATE TABLE emp_trg AS SELECT * FROM emp;

--방아쇠 trigger
--dml (insert, update, delete)
CREATE OR REPLACE TRIGGER trg_emp_nodmp_weekend
BEFORE 
INSERT OR UPDATE OR DELETE ON emp_trg
BEGIN 
	IF TO_CHAR(SYSDATE,'DY') IN ('토','일')  THEN 
		IF INSERTING THEN 
			raise_application_error(-20000,'주말엔 사원정보 추가 불가');
		ELSIF UPDATING  THEN
			raise_application_error(-20001,'주말엔 사원정보 수정 불가');
		ELSIF DELETING  THEN
			raise_application_error(-20002,'주말엔 사원정보 삭제 불가');
		ELSE 
			raise_application_error(-20003,'주말엔 사원정보 변경 불가');
		END IF;
	END IF;
END;



SELECT TO_CHAR(SYSDATE,'DY') FROM dual;
SELECT * FROM emp_trg;
UPDATE emp_trg SET sal = 30000 WHERE empno = 7369;


--사원을 인서트하고 하고 나면 log 테이블에 기록 남기기
CREATE TABLE EMP_TRG_LOG(
	TABLENAME   VARCHAR2(100),
	DML_TYPE    VARCHAR2(100),
	EMPNO       NUMBER(5),
	USER_NAME   VARCHAR2(100),
	CHANGE_DATE DATE
);
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER 
INSERT OR UPDATE OR DELETE ON emp_trg
FOR EACH ROW 
BEGIN 
	IF INSERTING THEN 
		INSERT INTO EMP_TRG_LOG VALUES ('emp_trg',
										'insert',
										:new.empno,
										sys_context('USERENV','SESSION_USER'),
										sysdate
										);
	ELSIF UPDATING THEN 
		INSERT INTO EMP_TRG_LOG VALUES ('emp_trg',
										'update',
										:old.empno,
										sys_context('USERENV','SESSION_USER'),
										sysdate
										); 	
	ELSIF DELETING THEN 
		INSERT INTO EMP_TRG_LOG VALUES ('emp_trg',
										'delete',
										:old.empno,
										sys_context('USERENV','SESSION_USER'),
										sysdate
										); 	
	END IF;																	
END;

SELECT * FROM emp_trg;
SELECT * FROM EMP_TRG_LOG;

INSERT INTO emp_trg VALUES (
	9997,'dsfds','CLERK',7788,
	TO_DATE('2024-11-14','YYYY-MM-DD'), 1200,NULL,20);










