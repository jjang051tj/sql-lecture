-- not null null을 허용하지 않겠다.
CREATE TABLE table_notnull02 (
	login_id   varchar2(20)  CONSTRAINT tblNN2_login_id_NN NOT NULL,
	login_pw   varchar2(50)  CONSTRAINT tblNN2_login_pw_NN NOT NULL,
	tel        varchar2(13)
);
SELECT * FROM table_notnull02;
INSERT INTO table_notnull02  (login_id,login_pw,tel) VALUES
('jjang051','1234','010-1111-1111');

INSERT INTO table_notnull02  (login_id,login_pw,tel) VALUES
('jjang052','1234','010-2222-2222');

--데이터 무결성
SELECT * FROM user_constraints;


ALTER TABLE table_notnull02 
MODIFY (tel NOT NULL);

SELECT * FROM table_notnull02;

--제약 조건 삭제 
ALTER TABLE table_notnull
DROP CONSTRAINT SYS_C008330;

--제약 조건 이름 변경
ALTER TABLE table_notnull
RENAME CONSTRAINT SYS_C008329 TO TBLNN_LOGIN_ID_NN;

-- UNIQUE는 중복 허용하지 않음...loginid,전화번호, email
CREATE TABLE table_unique (
	login_id varchar2(20) UNIQUE,
	login_pw varchar2(50) NOT NULL,
	tel      varchar2(13) 
);
SELECT * FROM table_unique;
SELECT * FROM user_constraints;

--데이터 무결성
INSERT INTO table_unique (login_id,login_pw, tel) VALUES
(NULL,'1234','010-1111-1111');


-- primary key  not null  / unique index 자동 설정
-- 게시판의 고유번호  
CREATE TABLE table_pk (
	login_id varchar2(20) PRIMARY KEY,
	login_pw varchar2(20) NOT null,
	tel      varchar2(20)
);
SELECT * FROM table_pk;
SELECT * FROM user_indexes;
SELECT * FROM user_constraints;


CREATE TABLE table_pk02 (
	login_id varchar2(20) CONSTRAINT table_pk02_login_pk PRIMARY KEY,
	login_pw varchar2(20) NOT null,
	tel      varchar2(20)
);

SELECT * FROM table_pk;

INSERT INTO table_pk (login_pw, tel)
VALUES ('1234','010-1111-1111');


--foreign key  다른 테이블의 값을 참조할때 쓴다. 

SELECT owner,constraint_name,constraint_type,table_name,r_owner, r_constraint_name
FROM user_constraints 
WHERE table_name IN ('EMP','DEPT');

SELECT * FROM dept;

INSERT INTO dept (deptno,dname,loc) VALUES (50,'DB','SEOUL');


INSERT INTO emp (empno,ENAME,job,mgr,HIREDATE,sal,comm,deptno) VALUES
(9999,'hong','CLERK','7788',TO_DATE('2024/11/12','YYYY/MM/DD'), 1200,NULL,50);
ROLLBACK;

CREATE TABLE dept_fk(
	deptno NUMBER(2) CONSTRAINT deptfk_dept_pk PRIMARY KEY,
	dname  varchar2(20),
	loc    varchar2(20)
);
SELECT * FROM dept_fk;

CREATE TABLE emp_fk(
	empno   NUMBER(2) CONSTRAINT empfk_emp_pk PRIMARY KEY,
	ename   varchar2(20),
	job     varchar2(20),
	mgr     number(4),
	hiredate DATE,
	sal     number(7,2),
	comm    number(7,2),
	deptno  number(2) CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno)
);


INSERT INTO emp_fk (empno,ENAME,job,mgr,HIREDATE,sal,comm,deptno) VALUES
(99,'hong','CLERK','7788',TO_DATE('2024/11/12','YYYY/MM/DD'), 1200,NULL,10);
SELECT * FROM dept_fk;
INSERT INTO dept_fk (deptno,dname,loc) VALUES
(10,'DB','SEOUL');

DELETE FROM emp_fk WHERE deptno = 10;
DELETE FROM dept_fk WHERE deptno = 10;
ROLLBACK;

--게시판에 글쓰기  
-- 1 아름다누 밤이에요... pk
     -- 미친           fk 
     -- 죽어라          fk

CREATE TABLE students(
	student_id number(4) PRIMARY KEY,
	student_name varchar2(100)
);

SELECT * FROM students;

CREATE TABLE student_cource(
	student_id number(4) CONSTRAINT fk_student 
						 REFERENCES students(student_id) ON DELETE cascade,
	course_id  NUMBER,
	enroll_date DATE,
	grade varchar2(2)
);

INSERT INTO students values(1,'장성호');
INSERT INTO students values(3,'장동건');

INSERT INTO student_cource values(3,101,sysdate,'a');
INSERT INTO student_cource values(3,201,sysdate,'b');
INSERT INTO student_cource values(3,301,sysdate,'b');

SELECT s.*, sc.*
FROM students s
JOIN student_cource sc
ON s.student_id = sc.student_id;

DELETE FROM students WHERE student_id = 1;
SELECT * FROM students;



CREATE TABLE table_check (
	login_id varchar2(20),
	login_pw varchar2(20) 
		CONSTRAINT table_check_loginpw_check CHECK(LENGTH(login_pw) > 3),
	tel      varchar2(20)
);
INSERT INTO table_check values('aaa','2124','010-1111-1111');

CREATE TABLE table_default (
	login_id varchar2(20) DEFAULT '아무개',
	login_pw varchar2(20),
	tel      varchar2(20)
);
INSERT INTO table_default (login_pw,tel) values('1234','010-1111-1111');
SELECT * FROM table_default;
-- DML(insert, update,delete, select) / DDL(테이블 만들기)












