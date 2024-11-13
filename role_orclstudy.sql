CREATE TABLE temp07 (
	userid varchar2(100) PRIMARY KEY,
	userpw varchar2(100) NOT null
);
SELECT * FROM scott.temp01;
INSERT INTO scott.temp01 values('jjang22222','1234');
COMMIT;

INSERT INTO temp01 VALUES ('jjang052','1234');
SELECT * FROM temp05;

SELECT * FROM scott.emp;