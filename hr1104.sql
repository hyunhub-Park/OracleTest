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
select * from employees where commission_pct is not null;
select * from employees where commission_pct is null;
-- ORDER BY ASC, DESC ��� ����. --
-- primary key �̹Ƿ� null�� ����. --
select employee_id, first_name from employees order by employee_id asc;
select employee_id, first_name from employees order by employee_id desc;
-- GROUP BY --
select * from employees;    /*����*/
select * from employees where department_id >= 70;
select department_id, salary from employees where department_id >= 70;
select department_id, max(salary) from employees where department_id >= 70 group by department_id;
select department_id, max(salary), min(salary), sum(salary), round(avg(salary, 1),
count(salary) from employees where department_id >= 70 group by department_id having sum(salary) >= 30000;
select max(salary), round(avg(salary, 1), sum(salary) from employees;

select department_id, sum(salary) from employees 
group by department_id having department_id = 30;
-- 20�� �μ����� ������� �Ի�⵵ ��������. --
select employee_id, first_name, substr(hire_date, 1, 2) || '�⵵' as "�Ի�⵵" from employees where department_id = 20;
SELECT TRIM(LEADING FROM ' ABCD ') LT, LENGTH(TRIM(LEADING FROM '        ABCD ')) LT_LEN, 
        TRIM(TRAILING FROM ' ABCD ') RT, LENGTH(TRIM(TRAILING FROM '        ABCD ')) RT_LEN, 
        TRIM(BOTH FROM '    ABCD ') BOTH1, LENGTH(TRIM(BOTH FROM '    ABCD ')) BOTH1, 
        TRIM('    ABCD    ') BOTHT2, LENGTH(TRIM(' ABCD ')) BOTHLEN2
FROM DUAL;
-- �ٹ� �� �� ���ϱ�. --
select * from employees where department_id = 30;
select first_name, hire_date as "�Ի���", sysdate as "���糯¥", round(months_between(sysdate, hire_date)) 
        as "�ٹ��޼�" from employees where department_id = 30;
-- NEXT_{DAY () �Լ� --
select sysdate, next_day(sysdate, '������') from dual;
select sysdate, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'), next_day(sysdate, '������') from dual;
