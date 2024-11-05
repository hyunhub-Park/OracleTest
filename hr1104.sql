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
select * from employees where commission_pct is not null;
select * from employees where commission_pct is null;
-- ORDER BY ASC, DESC 사번 기준. --
-- primary key 이므로 null은 없음. --
select employee_id, first_name from employees order by employee_id asc;
select employee_id, first_name from employees order by employee_id desc;
-- GROUP BY --
select * from employees;    /*원래*/
select * from employees where department_id >= 70;
select department_id, salary from employees where department_id >= 70;
select department_id, max(salary) from employees where department_id >= 70 group by department_id;
select department_id, max(salary), min(salary), sum(salary), round(avg(salary, 1),
count(salary) from employees where department_id >= 70 group by department_id having sum(salary) >= 30000;
select max(salary), round(avg(salary, 1), sum(salary) from employees;

select department_id, sum(salary) from employees 
group by department_id having department_id = 30;
-- 20번 부서에서 사원들의 입사년도 가져오기. --
select employee_id, first_name, substr(hire_date, 1, 2) || '년도' as "입사년도" from employees where department_id = 20;
SELECT TRIM(LEADING FROM ' ABCD ') LT, LENGTH(TRIM(LEADING FROM '        ABCD ')) LT_LEN, 
        TRIM(TRAILING FROM ' ABCD ') RT, LENGTH(TRIM(TRAILING FROM '        ABCD ')) RT_LEN, 
        TRIM(BOTH FROM '    ABCD ') BOTH1, LENGTH(TRIM(BOTH FROM '    ABCD ')) BOTH1, 
        TRIM('    ABCD    ') BOTHT2, LENGTH(TRIM(' ABCD ')) BOTHLEN2
FROM DUAL;
-- 근무 달 수 구하기. --
select * from employees where department_id = 30;
select first_name, hire_date as "입사일", sysdate as "현재날짜", round(months_between(sysdate, hire_date)) 
        as "근무달수" from employees where department_id = 30;
-- NEXT_{DAY () 함수 --
select sysdate, next_day(sysdate, '수요일') from dual;
select sysdate, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'), next_day(sysdate, '수요일') from dual;
