-- sequence 생성. --
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

-- employees 구조만 복사 emp01. --
DROP TABLE emp01;
CREATE TABLE emp01
AS
SELECT employee_id, first_name, hire_date FROM employees WHERE 1=0;
-- emp_seq.NEXTVAL 입력. --
INSERT INTO emp01 VALUES(emp_seq.NEXTVAL, 'KDJ', SYSDATE);

-- emp_seq.currval 입력. --
SELECT emp_seq.CURRVAL FROM dual;

-- sequence dept_seq 생성, 시작값 10, 증가치 10, 결과치 30. --
CREATE SEQUENCE dept_seq
START WITH 10
INCREMENT BY 10
MAXVALUE 30;

-- dept02 테이블 구조 복사. --
DROP TABLE dept02;

CREATE TABLE dept02
AS
SELECT department_id, department_name, location_id FROM departments WHERE 1=0;

INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '인사과', 1);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '총무과', 2);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '서무과', 3);
INSERT INTO dept02 VALUES(dept_seq.NEXTVAL, '교육과', 4);  /* maxvalue가 30이기 때문에, 40이 될 값은 들어갈 수 없음. */

-- sequence 수정하기. --
ALTER SEQUENCE dept_seq
MAXVALUE 100;

SELECT * FROM user_sequences WHERE sequence_name='dept_seq';

-- sequence 삭제하기. --
DROP SEQUENCE dept_seq;

-- data dictionary에서 index 확인하기. --
SELECT * FROM user_indexes WHERE TABLE_NAME='EMPLOYEES';
SELECT * FROM user_ind_columns WHERE TABLE_NAME='EMPLOYEES';

SELECT * FROM EMPLOYEES WHERE employee_id=100;

DROP TABLE emp10;

CREATE TABLE emp10
AS
SELECT * FROM employees WHERE 1=1;

SELECT * FROM EMP10 WHERE employee_id=100;

-- index 생성하기. --
SELECT * FROM user_ind_columns WHERE TABLE_NAME='EMP10';
CREATE UNIQUE INDEX EMP10_EMPLOYEE_ID_IX
ON EMP10(EMPLOYEE_ID);

-- index 삭제하기. --
DROP INDEX EMP10_EMPLOYEE_ID_IX;





select * from user_sequences;
SELECT * FROM dept02;
DESC emp01;