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
