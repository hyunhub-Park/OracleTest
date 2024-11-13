-- sequence ����. --
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100000
NOCYCLE
CACHE 2;

-- DATA DICTIONARY --
--USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS, USER_VIEWS, USER_INDEXES--
SELECT * FROM user_sequences;

-- employees ������ ���� emp01. --
DROP TABLE emp01;
CREATE TABLE emp01
AS
SELECT employee_id, first_name, hire_date FROM employees WHERE 1=0;
-- emp_seq.NEXTVAL �Է�. --
INSERT INTO emp01 VALUES(emp_seq.NEXTVAL, 'KDJ', SYSDATE);

-- emp_seq.currval �Է�. --
SELECT emp_seq.CURRVAL FROM dual;

-- sequence dept_seq ����, ���۰� 10, ����ġ 10, ���ġ 30. --
CREATE SEQUENCE dept_seq
START WITH 10
INCREMENT BY 10
MAXVALUE 30;

-- dept02 ���̺� ���� ����. --
DROP TABLE dept02;

CREATE TABLE dept02
AS
SELECT department_id, department_name, location_id FROM departments WHERE 1=0;

INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '�λ��', 1);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '�ѹ���', 2);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '������', 3);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '������', 4);  /* maxvalue�� 30�̱� ������, 40�� �� ���� �� �� ����. */




select * from user_sequences;
SELECT * FROM dept02;
DESC emp01;