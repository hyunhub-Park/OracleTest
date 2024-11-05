-- hr resource에 있는 테이블 정보. --
select * from tab;  /*블럭지정 반드시 한 후에 수행 필요.*/
-- employees 테이블 구조 --
desc employees; /*클래스*/
-- employees 속에 들어있는 레코드(객체들). --

select * from employees;
-- departments 테이블 객체(레코드=인스턴스)를 확인. --
select * from departments;
-- departments의 구조 보기. --
desc departments;
-- departments_id, deparetments_name만 출력하기. --
select department_id, department_name from departments;
-- 필드명에 별칭 사용하기. --
-- select department_id as "부서번호", department_name as "부서명" from departments; --
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
select department_id as "DEPT NO", department_name as "DEPT NAME" from departments;
-- + || --
select '5' + 5 from dual;
select '5' || 5 from dual;
-- select * from dual; --
-- select '5' + 5 from employees;--
-- 문자열을 이용해 필드명 출력하기. --
select first_name, job_id from employees;
select first_name || '의 직급은' || job_id || '입니다.' from employees;
select first_name || '의 직급은' || job_id || '입니다.' as data from employees;
-- 중복 없는 출력. distinct--
select distinct job_id from employees;
-- 연봉 3000만원 이상인 사람. --
select * from employees;
describe employees;
select * from employees where salary >= 3000;   /*연봉이 3천 이상인 사람.*/
desc employees;
-- 2008년 이후에 입사한 직원. --
select * from employees where hire_date >= '2008/01/01';
select * from employees where TO_CHAR(hire_date, 'YYYY/MM/DD') >= '2008/01/01';
select * from employees where hire_date >= TO_DATE('2008/01/01', 'YYYY/MM/DD HH24:MI:SS');
-- AND조건, BETWEEN a AND b --
select * from employees where salary >= 2000 and salary <= 3000;
select * from employees where salary >= 2000 and salary between 2000 and 3000;
-- OR, IN( , ) 직원번호가 67이거나 101이거나 184인 사원 --
select * from employees where employee_id = 67 or employee_id = 101 or employee_id = 184;
select * from employees where employee_id in(67, 101, 184);
-- NULL 연산, 비교, 할당 --
select 100 + NULL from dual;
select 100 - NULL from dual;
describe employees;
select * from employees where commission_pct = null;
select * from employees;
select * from emloyees where commission_pct is not null;
select * from emloyees where commission_pct is null;