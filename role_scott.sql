CREATE TABLE temp01(
	userid varchar2(100) PRIMARY KEY,
	userpw varchar2(100) NOT null
);
-- 사용자 끼리도 권한부여를 할 수 있다.
GRANT SELECT, INSERT ON temp01  
TO orclstudy;

INSERT INTO temp01 values('jjang0000','1234');
COMMIT;

SELECT * FROM temp01;

REVOKE  SELECT, INSERT ON temp01  
FROM orclstudy;

-- role 은 권한의 묶음...
-- connect 
--GRANT CONNECT,RESOURCE TO orclstudy; 


GRANT SELECT ON emp TO PREV_HW;
GRANT SELECT ON dept TO PREV_HW;
GRANT SELECT ON salgrade TO PREV_HW;

REVOKE SELECT ON salgrade FROM PREV_HW;







