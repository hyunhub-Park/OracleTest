-- 24_Oracle XE 18c 'Susan'�� �μ����̵� ����. --
SELECT department_id FROM employees where first_name='Susan';

-- �μ����̵� 40�� �μ��� ����. --
SELECT department_name FROM departments where department_id=40;

-- 'Susan'�� �ҼӵǾ��ִ� �μ���. --
SELECT * FROM employees WHERE first_name='Susan';   /* department_name�� ��ȸ���� ����. */
SELECT * FROM departments WHERE department_id=40;

                                                                /* JOIN ����. */
SELECT * FROM departments D INNER JOIN employees E ON D.department_id=E.department_id;
/* �ش� ������ ����� �÷����� �����Ѱ� ������ �� ����. �ڵ������� _1�� �̸��� �����Ͽ� ���ε�. */

SELECT * FROM departments D INNER JOIN employees E ON D.department_id=E.department_id
-- SELECT E.first_name, D.department_name from departments D INNER JOIN employees E ON D.department_id=E.department_id --
WHERE UPPER(first_name)=UPPER('Susan');

-- ��! ��! ��! ��! --
/* ������. (<> ������.)*/ /* �������� ��, ũ��, ������ ����. */
/* �������� ��, ũ�� ���� �Ұ��� -> IN(OR), ANY(1�� �̻� ������ ��.), ALL(��� �¾ƾ� ��.), EXISTS(�����ϸ� true, �ƴϸ� false) */
SELECT department_id FROM employees WHERE first_name='Susan';
SELECT * FROM departments WHERE department_id=(SELECT department_id FROM employees WHERE first_name='Susan');

/* SELECT * FROM department_id as A department_name as B WHERE department_id=
        (SELECT department_id ? ��ſ� A��� ��Ī �� �� ����! ��ȣ�� ���� ����Ǳ� ������ ?. FROM employees WHERE first_name='Susan'); */
        
-- employees���̺��� 'Lex'�� ���� �μ��� �ִ� ��� ����� �̸��� �Ի����� ���. --
/* ���� ���̺��̾ �������� OK. */
SELECT department_id FROM employees WHERE first_name='Lex';
SELECT * FROM employees WHERE department_id='90';
SELECT first_name, TO_CHAR(hire_date, 'YYYY-MM-DD') FROM employees WHERE department_id=(SELECT department_id FROM employees WHERE first_name='Lex');


-- EMPLOYEES ���̺��� CEO���� �����ϴ� ������ ��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�. --
SELECT * FROM employees;
SELECT * FROM departments;
/* ???IS NULL�� �� ���� �ʱ�^^??? */
select * from employees where manager_id is null;
select * from employees where manager_id=100;
SELECT * FROM employees WHERE manager_id=(SELECT employee_id from employees WHERE manager_id IS NULL);

-- ������̺��� ��ü ���� ���. --
-- SELECT ROUND(AVG(salary),1) as "��տ���" FROM employees; --   /* ������. */
SELECT ROUND(AVG(salary),1) as salary FROM employees;   /* ������. */
SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id; /* -> �������� ��. */

-- ��ü ��տ������� ���� ���� ���� ���. --
SELECT * FROM employees WHERE salary > (SELECT ROUND(AVG(salary),1) as "��տ���" FROM employees);

-- �������� ��, �� ���� ����. X --
SELECT * FROM employees WHERE salary > (SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id);
                                    /* �������� ��, */
SELECT * FROM employees WHERE salary > ALL(SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id);

CREATE TABLE imsiTBL
AS
SELECT * FROM employees WHERE 1=0;  /* '����'�� �����. */

SELECT * FROM imsiTBL;
DROP TABLE imsiTBL;

CREATE TABLE imsiTBL
AS
SELECT * FROM employees WHERE 1=1;  /* '����&����' �����. */

SELECT * FROM imsiTBL;
DROP TABLE imsiTBL;

/* imsiTBL��(���̺� ���� ��,) ���������� 'NOT NULL'�� ���簡 �� !!!!! */
SELECT * FROM USER_CONSTARINTS WHERE TABLE_NAME=UPPER('imsiTBL');

-- salary >= 13000�� ����� �μ� ���. --
SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;
SELECT * FROM employees WHERE department_id IN(90, 80, 20);

-- �������� �̿�. --
SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;
SELECT * FROM employees WHERE department_id IN(SELECT DISTINCT department_id FROM employees WHERE salary >= 13000);

-- employees ���̺���, 'Susan'�Ǵ� 'Lex'�� ���� ���. --
SELECT * FROM employees WHERE UPPER(first_name)=UPPER('Susan');
SELECT first_name FROM employees WHERE UPPER(first_name)=UPPER('Susan') or UPPER(first_name)=UPPER('Lex');  /* ������. */

-- employees ���̺���, 'Susan'�Ǵ� 'Lex'�� ������ ���� ������ �̸�, ���, �޿� ��� ('Susan', 'Lex' ����). --
SELECT * FROM employees WHERE salary in (17000, 6500) AND first_name <> 'Susan' AND first_name <> 'Lex';
SELECT * FROM employees WHERE salary in (17000, 6500) AND first_name NOT IN ('Susan', 'Lex');

SELECT * FROM employees WHERE salary in
(select salary from employees where upper(first_name)=upper('Susan') or UPPER(first_name)=UPPER('Lex'))
AND first_name <> 'Susan' AND first_name <> 'Lex';

-- �� �� �̻����κ��� ���� �޴´�. (CEO=NULL) and MANAGER --
SELECT DISTINCT manager_id FROM employees WHERE manager_id is not null OR manager_id is null order by manager_id asc;
SELECT DISTINCT manager_id AS ��� FROM employees order by manager_id asc;

SELECT employee_id, first_name, job_id, department_id FROM employees WHERE manager_id
in(SELECT DISTINCT manager_id FROM employees);

--EMPLOYEES ���̺��� Accounting �μ����� �ٹ��ϴ� ������ ���� ������ �ϴ� ������ �̸�, ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�. --
select * from employees;
SELECT * FROM employees WHERE department_id=
(SELECT departmnet_id from departments WHERE departmnet_name='Accounting');

SELECT DISTINCT job_id FROM employees WHERE department_id=110;

SELECT first_name, job_id from employees
WHERE department_id = (select department_id from departments WHERE department_name='Accounting')
AND job_id IN('AC_MGR', 'AC_ACCOUNT');

select * from departments;

SELECT first_name, job_id from employees
WHERE department_id = (select department_id from departments WHERE department_name='Accounting')
AND job_id IN(SELECT DISTINCT job_id FROM employees WHERE department_id=110);

/* department_id = (select department_id from departments WHERE department_name='Accounting') => A
A AND (B AND A)�� ���� ���� ��. department_id as ID�� �ؼ� ������ where�� department_id�� 110��� ID�� ���°�? */

SELECT first_name, job_id from employees
WHERE job_id IN(SELECT DISTINCT job_id FROM employees WHERE department_id=110);

-- EXISTS 1=1(true), 1=0(false) --
SELECT * FROM employees WHERE department_id=110;

-- ���̺� ����. where 1=0���� �� ��, ������ ����X ������ ���� O. --
DROP TABLE emp02;

CREATE TABLE emp02
AS
SELECT employee_id, first_name FROM employees;  /* ������ ����Ǿ��µ�, id�� name�� ���� �� ����. */

SELECT * FROM emp02;

-- ���������� �̿��Ͽ� ������ ����. --
-- ������ ����. --
CREATE TABLE DEP01
AS
SELECT * FROM departments WHERE 1=0;

SELECT * FROM dep01;

-- ***��������***�� �̿��Ͽ� ���� ����. --
-- INSERT INTO DEP01 VALUES --
INSERT INTO DEP01 (SELECT * FROM departments);

-- UPDATA �������� Ȱ�� --
-- �μ� 10�� ������ġ�� �μ� 40���� ������ġ�� ����. --
UPDATE dep01 SET location_id=2400 WHERE department_id=10;
SELECT location_id from departments WHERE department_id=40;

UPDATE dep01 SET location_id=(SELECT location_id from departments WHERE department_id=40) WHERE department_id=10;

-- ������ 'ST_MAN'�� ������ �޴� �޿����� �ּ� �޿����� ���� �޴� �������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 20���� ������ �����Ѵ�. --
CREATE TABLE EX01
AS
SELECT * FROM employees;
    --MIN �Ἥ �ּڰ��� ���ص� ��.--
/* SELECT MIN(salary) FROM EX01 WHERE job_id='ST_MAN';*/
SELECT first_name, salary FROM EX01 WHERE salary > ANY (SELECT salary FROM EX01 WHERE job_id='ST_MAN');
-- ��ü. --
SELECT * FROM EX01 WHERE salary > (SELECT MIN(salary) FROM EX01 WHERE job_id='ST_MAN') AND department_id <> 20
ORDER BY EX01.department_id ASC;

select * from ex01;
select * from ex01 where first_name='Valli';
select * from departments;

--  EMPLOYEES ���̺��� Valli��� �̸��� ���� ������ ������ �� ������ ���� ����� ��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�. (������� Valli�� ����) --
SELECT * FROM EX01 WHERE EXISTS (SELECT * FROM departments WHERE department_name='IT' AND salary=4800);

-- ��ü. --
SELECT * FROM EX01 WHERE job_id=(SELECT job_id FROM EX01 WHERE first_name='Valli')
AND salary=(SELECT salary FROM EX01 WHERE first_name='Valli')
and first_name <> 'Valli';



-- EMPLOYEES ���̺��� ������ �ڽ���(��Valli��) ���� �μ��� ��� ���޺��� ���� ����� �μ���ȣ, �̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. --
SELECT * FROM EX01 WHERE EXISTS (SELECT * FROM departments WHERE salary > 4800);

-- ��ü. --
SELECT department_id FROM EX01 WHERE first_name='Valli';
-- SELECT department_id, ROUND(AVG(salary)) FROM EX01 GROUP BY department_id; --
SELECT ROUND(AVG(salary)) FROM EX01 WHERE department_id=60;
-- SELECT * FROM EX01 WHERE salary > (SELECT ROUND(AVG(salary)) FROM EX01 WHERE department_id=60); --
SELECT * FROM EX01 WHERE salary > (SELECT ROUND(AVG(salary)) FROM EX01 WHERE department_id=(SELECT department_id FROM EX01 WHERE first_name='Valli'));

select * from employees where last_name='Tucker';

select * from employees;

SELECT first_name, last_name, salary AS "Name" FROM employees WHERE last_name='Tucker';
SELECT first_name, last_name AS Name, job_id, salary FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name='Tucker');

SELECT first_name, last_name AS Name, salary, hire_date, job_id FROM employees
WHERE (job_id, salary) IN(SELECT job_id, MIN(salary) FROM employees GROUP BY job_id)
ORDER BY job_id asc;

select AVG(salary) from employees where job_id='FI_ACCOUNT';
select salary, first_name from employees where job_id='FI_ACCOUNT';

select AVG(salary) from employees where job_id='SA_MAN';
select salary, first_name from employees where job_id='SA_MAN';

SELECT first_name, last_name AS Name, salary, department_id, job_id FROM employees E
WHERE E.salary > (SELECT AVG(salary) FROM employees WHERE department_id=E.department_id)
ORDER BY job_id;

select * from departments;
select salary, first_name from employees;



select CONCAT(CONCAT(e.first_name, ' '), e.last_name) "Name", e.salary, 
    e.department_id, e.job_id
from employees e
where salary > (select AVG(salary)
                from employees
                where department_id = e.department_id
                group by e.department_id);
                
                
SELECT first_name, last_name AS Name, job_id, salary, department_id, ROUND((SELECT AVG(salary)
FROM employees
WHERE department_id=E.department_id)) AS "Department Avg Salary" FROM employees E
ORDER BY job_id;

