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