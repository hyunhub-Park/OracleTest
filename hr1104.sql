-- hr resource�� �ִ� ���̺� ����. --
select * from tab;  /*������ �ݵ�� �� �Ŀ� ���� �ʿ�.*/
-- employees ���̺� ���� --
desc employees; /*Ŭ����*/
-- employees �ӿ� ����ִ� ���ڵ�(��ü��). --

select * from employees;
-- departments ���̺� ��ü(���ڵ�=�ν��Ͻ�)�� Ȯ��. --
select * from departments;
-- departments�� ���� ����. --
desc departments;
-- departments_id, deparetments_name�� ����ϱ�. --
select department_id, department_name from departments;
-- �ʵ�� ��Ī ����ϱ�. --
-- select department_id as "�μ���ȣ", department_name as "�μ���" from departments; --
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
select department_id as "DEPT NO", department_name as "DEPT NAME" from departments;
-- + || --
select '5' + 5 from dual;
select '5' || 5 from dual;
-- select * from dual; --
-- select '5' + 5 from employees;--
-- ���ڿ��� �̿��� �ʵ�� ����ϱ�. --
select first_name, job_id from employees;
select first_name || '�� ������' || job_id || '�Դϴ�.' from employees;
select first_name || '�� ������' || job_id || '�Դϴ�.' as data from employees;
-- �ߺ� ���� ���. distinct--
select distinct job_id from employees;
-- ���� 3000���� �̻��� ���. --
select * from employees;
describe employees;
select * from employees where salary >= 3000;   /*������ 3õ �̻��� ���.*/
desc employees;
-- 2008�� ���Ŀ� �Ի��� ����. --
select * from employees where hire_date >= '2008/01/01';
select * from employees where TO_CHAR(hire_date, 'YYYY/MM/DD') >= '2008/01/01';
select * from employees where hire_date >= TO_DATE('2008/01/01', 'YYYY/MM/DD HH24:MI:SS');
-- AND����, BETWEEN a AND b --
select * from employees where salary >= 2000 and salary <= 3000;
select * from employees where salary >= 2000 and salary between 2000 and 3000;
-- OR, IN( , ) ������ȣ�� 67�̰ų� 101�̰ų� 184�� ��� --
select * from employees where employee_id = 67 or employee_id = 101 or employee_id = 184;
select * from employees where employee_id in(67, 101, 184);
-- NULL ����, ��, �Ҵ� --
select 100 + NULL from dual;
select 100 - NULL from dual;
describe employees;
select * from employees where commission_pct = null;
select * from employees;
select * from emloyees where commission_pct is not null;
select * from emloyees where commission_pct is null;