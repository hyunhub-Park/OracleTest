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