SELECT * FROM dept_tcl;

UPDATE dept_tcl SET dname = 'DATABASE'
WHERE deptno = 30;
COMMIT;