-- Ʈ�����. --

drop table dep02;

-- ���̺� ����.(������) --
CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;

/* not null�� ����. */
SELECT * FROM user_constraints where table_name='dep02'; --> ��������� Ŀ����.

-- ���� ����. --
INSERT INTO dep02 SELECT * FROM departments;

select * from dep02;

ROLLBACK; -- 13�����. --

DELETE FROM dep02;

SAVEPOINT C1;

DELETE FROM dep02 WHERE department_id=90;

ROLLBACK; --> �׻� Ŀ�� �������� ���ư�. 13��.

ROLLBACK TO C1;

-- VIEW �����ϱ�.(����) --
CREATE VIEW VIEW_EMP01
AS
SELECT employee_id, first_name, salary, department_id FROM employees WHERE department_id=10;

SELECT * FROM view_emp01;

-- employees ���纻 �����. --
CREATE TABLE emp_copy
AS
SELECT * FROM employees;

SELECT * FROM emp_copy; /* ���������� not null�� ���� ���� ��. */

-- VIEW �����ϱ�. --
DROP VIEW view_emp01;

----
CREATE VIEW VIEW_EMP01
AS
SELECT employee_id, first_name, salary, department_id FROM emp_copy WHERE department_id=10;

-- ����� �� Ȯ���ϱ�. --
SELECT * FROM view_emp01;
select * from emp_copy where employee_id=200;

-- VIEW �����ϱ�. --
UPDATE view_emp01 SET salary=4500 where employee_id=200;    /* ������ ������ �Բ� ��. */

-- DATA DICTIONARY --
--USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS, USER_VIEWS, USER_INDEXES--
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_constraants_columns WHERE table_name='employees';
SELECT * FROM user_views;
SELECT * FROM user_indexes;

-- ���� �信 �Է��ϱ�. (�������̺� �÷� 4���� �Է�) --
INSERT INTO view_emp01 VALUES(1000, 'JDK', 2000, 50);   /* not null ���� �ȵ�. */
                                                        /* �÷����� �������̺� �־��ָ� ���� �� ����. */
SELECT * FROM view_emp01;
SELECT * FROM user_constraints WHERE table_name='emp_copy';

CREATE VIEW view_emp02
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id FROM emp_copy WHERE department_id=10;

SELECT * FROM view_emp02;
/* ������ ��. 77���� �������� �����ϴ� ���̴ϱ�! �����̴ϱ�! */
INSERT INTO view_emp02 VALUES(1000, 'JDK', 'KDJ', 'JDKKDJ', TO_DATE('2020/01/01', 'yyyy/mm/dd'), 'IT_DEV');

select * from emp_copy where employee_id=1000;
DESC emp_copy;

-- VIEW 3 �����ϱ�. --
CREATE VIEW view_emp03
AS                                                                               /*where�� ���ָ� 91���� �� ����.*/
SELECT employee_id, first_name, last_name, email, hire_date, job_id FROM emp_copy;

SELECT * FROM view_emp03;
/*���������� not null�� ����.*/
INSERT INTO view_emp02 VALUES(2000, 'JDK', 'KDJ', 'JDKKDJ', TO_DATE('2020/01/01', 'yyyy/mm/dd'), 'IT_DEV');

select * from emp_copy where employee_id=2000;

SELECT * FROM view_emp03 where employee_id=2000;

-- ���� �信�� ���� �����ϱ�. --
delete from view_emp03 where employee_id=2000;

-- ���պ� �����ϱ� (employees, departments)�� ���� ���̺� �����Ͽ� ���ο� �������̺� �����. --
CREATE VIEW view_emp_dep
AS
SELECT employee_id, first_name, salary, E.department_id, department_name, location_id
FROM employees E INNER JOIN departments D ON E.department_id=D.department_id
ORDER BY department_id DESC;

SELECT * FROM view_emp_dep;
SELECT DISTINCT department_id, department_name FROM view_emp_dep;

-- �μ��� it ���� ���, �ְ�, ������ ���ϱ�. --
SELECT department_name, MAX(salary), MIN(salary) FROM view_emp_dep WHERE department_name='IT' GROUP BY department_name;

-- VIEW���� FORCE����. --
CREATE OR REPLACE FORCE VIEW view_force
AS
SELECT employee_id, first_name, last_name, department_id FROM emp20;    /*������ �����������(FORCE) ���빰�� �� �� ����.*/

select * from emp20;

select * from user_views;

-- ROWNUM. --
SELECT ROWNUM, employee_id, first_name FROM employees;
SELECT ROWNUM, department_id, first_name FROM employees WHERE department_id=100;
SELECT ROWNUM, department_id, first_name FROM employees WHERE department_id=100
ORDER BY first_name DESC;

-- ROWNUM ���� ��, ������ ��Ʈ������ ���� ���ġ �ϰ���� ��. --
SELECT ROWNUM, employee_id, first_name, hire_date FROM employees;
SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc;   /* ������ ��Ʈ����. */

CREATE OR REPLACE VIEW view_hiredate
AS
SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc;   /* ROWNUM�� insert������ ��ġ ��. */

SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate;

SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate WHERE ROMNUM <= 5; /* 5���� ���. */
SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate WHERE ROMNUM=4; /* ���X. */

SELECT ROWNUM, employee_id, first_name, hire_date
FROM(SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc)
WHERE ROWNUM <= 4;

-- �����ȣ, �����, �μ���, �μ���ġ ����ϴ� VIEW_LOC �ۼ��ϱ�. --
CREATE VIEW VIEW_LOC
AS
SELECT E.employee_id, E.first_name, D.department_name, D.location_id from emp_copy E inner join dep02 d
ON E.department_id=D.department_id;

select * from view_loc;

-- 30�� �μ� �Ҽ� ����� �̸��� �Ի��ϰ� �μ����� ����ϴ� VIEW_DEPT30 �ۼ��ϱ�. --
CREATE VIEW VIEW_DEPT30
AS
SELECT E.first_name, E.hire_date, D.department_name from emp_copy E inner join dep02 d
ON E.department_id=D.department_id where D.department_id=30;

select * from view_dept30;

-- �μ��� �ִ� �޿� ������ ������ ��(VIEW_DEPT_MAXSAL) ����. --
CREATE VIEW VIEW_DEPT_MAXSAL
AS
SELECT E.first_name, E.hire_date, D.department_name from emp_copy E inner join dep02 d
ON E.department_id=D.department_id where D.department_id=30;

select * from view_dept30;

-- �޿��� ���� �޴� ������� 3�� ����ϴ� ��(VIEW_SAL_TOP3) ����. --


CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;
