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
select department_id, max(salary), min(salary), sum(salary), round(avg(salary), 1),
count(salary) from employees where department_id >= 70 group by department_id having sum(salary) >= 30000;
select max(salary), round(avg(salary), 1), sum(salary) from employees;

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

select employee_id, department_id, first_name, job_id, salary,
	case department_id when 30 then salary*1.05
end "�λ�� ���"

from employees;

----
select hire_date, first_name from employees where TO_CHAR(hire_date, 'yy')='03';
select to_char(hire_date, 'yy/mm/dd hh24:mi:ss'), to_char(hire_date, 'yy') from employees;
select to_date('20041214', 'yyyy/mm/dd')+1 from dual;
select first_name from employees where upper(substr(first_name, length(first_name), 1))=upper('k');

-- ���� �ð� ǥ��. --
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;
select floor(sysdate-to_date('2024/11/04', 'yyyy/mm/dd')) from dual;    /* date, timeStamp �ڷ����� ���ֹ��� �ʱ�! */

-- ���ϴ� �������� ���� ����ϱ�. --
select to_char(1234567.23, 'l999,999,999.999') from dual;
select trim(to_char(1234567.23, 'l999,999,999.999')) as money from dual;
select first_name, trim(to_char(salary, 'l999,999,999,999.99')) as salary from employees;

-- ���� + ���� = ���� --
select '10,000'+'20,000' from dual; /* ��ȯ �ʿ�. ����X */
select to_number('10,000', '999,999') + to_number('20,000', '999,999') from dual;

-- NVL TEST --
select first_name, salary, commission_pct, job_id from employees;
select first_name, salary, nvl(commission_pct, 0), job_id from employees;

-- NVL2 TEST --
select first_name, salary, commission_pct, salary+(salary*commission_pct) as total from employees;
select first_name, salary, commission_pct, salary+(salary*nvl(commission_pct, 0)) as total from employees;
select first_name, salary, commission_pct, salary+(salary*nvl2(commission_pct, commission_pct, 0)) as total from employees;


