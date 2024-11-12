-- 24_Oracle XE 18c 'Susan'의 부서아이디 보기. --
SELECT department_id FROM employees where first_name='Susan';

-- 부서아이디 40의 부서명 보기. --
SELECT department_name FROM departments where department_id=40;

-- 'Susan'이 소속되어있는 부서명. --
SELECT * FROM employees WHERE first_name='Susan';   /* department_name은 조회되지 않음. */
SELECT * FROM departments WHERE department_id=40;

                                                                /* JOIN 조건. */
SELECT * FROM departments D INNER JOIN employees E ON D.department_id=E.department_id;
/* 해당 조인의 결과로 컬럼명이 동일한게 존재할 수 있음. 자동적으로 _1로 이름을 변경하여 조인됨. */

SELECT * FROM departments D INNER JOIN employees E ON D.department_id=E.department_id
-- SELECT E.first_name, D.department_name from departments D INNER JOIN employees E ON D.department_id=E.department_id --
WHERE UPPER(first_name)=UPPER('Susan');

-- 서! 브! 쿼! 리! --
/* 단일행. (<> 다중행.)*/ /* 단일행은 비교, 크기, 연산이 가능. */
/* 다중행은 비교, 크기 연산 불가능 -> IN(OR), ANY(1개 이상만 맞으면 됨.), ALL(모두 맞아야 함.), EXISTS(존재하면 true, 아니면 false) */
SELECT department_id FROM employees WHERE first_name='Susan';
SELECT * FROM departments WHERE department_id=(SELECT department_id FROM employees WHERE first_name='Susan');

/* SELECT * FROM department_id as A department_name as B WHERE department_id=
        (SELECT department_id ? 대신에 A라는 별칭 쓸 수 없다! 괄호가 먼저 실행되기 때문에 ?. FROM employees WHERE first_name='Susan'); */
        
-- employees테이블에서 'Lex'와 같은 부서에 있는 모든 사원의 이름과 입사일자 출력. --
/* 같은 테이블이어도 서브쿼리 OK. */
SELECT department_id FROM employees WHERE first_name='Lex';
SELECT * FROM employees WHERE department_id='90';
SELECT first_name, TO_CHAR(hire_date, 'YYYY-MM-DD') FROM employees WHERE department_id=(SELECT department_id FROM employees WHERE first_name='Lex');


-- EMPLOYEES 테이블에서 CEO에게 보고하는 직원의 모든 정보를 출력하는 SELECT문을 작성하시오. --
SELECT * FROM employees;
SELECT * FROM departments;
/* ???IS NULL인 것 잊지 않기^^??? */
select * from employees where manager_id is null;
select * from employees where manager_id=100;
SELECT * FROM employees WHERE manager_id=(SELECT employee_id from employees WHERE manager_id IS NULL);

-- 고용테이블에서 전체 연봉 평균. --
-- SELECT ROUND(AVG(salary),1) as "평균연봉" FROM employees; --   /* 단일행. */
SELECT ROUND(AVG(salary),1) as salary FROM employees;   /* 단일행. */
SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id; /* -> 다중행이 됨. */

-- 전체 평균연봉보다 높은 직원 정보 출력. --
SELECT * FROM employees WHERE salary > (SELECT ROUND(AVG(salary),1) as "평균연봉" FROM employees);

-- 다중행일 시, 비교 가능 여부. X --
SELECT * FROM employees WHERE salary > (SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id);
                                    /* 다중행일 시, */
SELECT * FROM employees WHERE salary > ALL(SELECT ROUND(AVG(salary),1) as salary FROM employees GROUP BY department_id);

CREATE TABLE imsiTBL
AS
SELECT * FROM employees WHERE 1=0;  /* '구조'만 복사됨. */

SELECT * FROM imsiTBL;
DROP TABLE imsiTBL;

CREATE TABLE imsiTBL
AS
SELECT * FROM employees WHERE 1=1;  /* '구조&내용' 복사됨. */

SELECT * FROM imsiTBL;
DROP TABLE imsiTBL;

/* imsiTBL의(테이블 복사 시,) 제약조건은 'NOT NULL'만 복사가 됨 !!!!! */
SELECT * FROM USER_CONSTARINTS WHERE TABLE_NAME=UPPER('imsiTBL');

-- salary >= 13000인 사람의 부서 출력. --
SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;
SELECT * FROM employees WHERE department_id IN(90, 80, 20);

-- 서브쿼리 이용. --
SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;
SELECT * FROM employees WHERE department_id IN(SELECT DISTINCT department_id FROM employees WHERE salary >= 13000);

-- employees 테이블에서, 'Susan'또는 'Lex'의 월급 출력. --
SELECT * FROM employees WHERE UPPER(first_name)=UPPER('Susan');
SELECT first_name FROM employees WHERE UPPER(first_name)=UPPER('Susan') or UPPER(first_name)=UPPER('Lex');  /* 다중행. */

-- employees 테이블에서, 'Susan'또는 'Lex'와 월급이 같은 직원의 이름, 어부, 급여 출력 ('Susan', 'Lex' 제외). --
SELECT * FROM employees WHERE salary in (17000, 6500) AND first_name <> 'Susan' AND first_name <> 'Lex';
SELECT * FROM employees WHERE salary in (17000, 6500) AND first_name NOT IN ('Susan', 'Lex');

SELECT * FROM employees WHERE salary in
(select salary from employees where upper(first_name)=upper('Susan') or UPPER(first_name)=UPPER('Lex'))
AND first_name <> 'Susan' AND first_name <> 'Lex';

-- 한 명 이상으로부터 보고를 받는다. (CEO=NULL) and MANAGER --
SELECT DISTINCT manager_id FROM employees WHERE manager_id is not null OR manager_id is null order by manager_id asc;
SELECT DISTINCT manager_id AS 상사 FROM employees order by manager_id asc;

SELECT employee_id, first_name, job_id, department_id FROM employees WHERE manager_id
in(SELECT DISTINCT manager_id FROM employees);

--EMPLOYEES 테이블에서 Accounting 부서에서 근무하는 직원과 같은 업무를 하는 직원의 이름, 업무명를 출력하는 SELECT문을 작성하시오. --
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
A AND (B AND A)와 같은 꼴이 됨. department_id as ID를 해서 마지막 where절 department_id에 110대신 ID를 쓰는게? */

SELECT first_name, job_id from employees
WHERE job_id IN(SELECT DISTINCT job_id FROM employees WHERE department_id=110);

-- EXISTS 1=1(true), 1=0(false) --
SELECT * FROM employees WHERE department_id=110;

-- 테이블 복사. where 1=0으로 할 시, 내용은 복사X 구조만 복사 O. --
DROP TABLE emp02;

CREATE TABLE emp02
AS
SELECT employee_id, first_name FROM employees;  /* 구조가 복사되었는데, id와 name만 복사 된 것임. */

SELECT * FROM emp02;

-- 서브쿼리를 이용하여 데이터 복사. --
-- 구조만 복사. --
CREATE TABLE DEP01
AS
SELECT * FROM departments WHERE 1=0;

SELECT * FROM dep01;

-- ***서브쿼리***를 이용하여 내용 저장. --
-- INSERT INTO DEP01 VALUES --
INSERT INTO DEP01 (SELECT * FROM departments);

-- UPDATA 서브쿼리 활용 --
-- 부서 10번 지역위치를 부서 40번의 지역위치로 수정. --
UPDATE dep01 SET location_id=2400 WHERE department_id=10;
SELECT location_id from departments WHERE department_id=40;

UPDATE dep01 SET location_id=(SELECT location_id from departments WHERE department_id=40) WHERE department_id=10;

-- 직급이 'ST_MAN'인 직원이 받는 급여들의 최소 급여보다 많이 받는 직원들의 이름과 급여를 출력하되 부서번호가 20번인 직원은 제외한다. --
CREATE TABLE EX01
AS
SELECT * FROM employees;
    --MIN 써서 최솟값을 구해도 됨.--
/* SELECT MIN(salary) FROM EX01 WHERE job_id='ST_MAN';*/
SELECT first_name, salary FROM EX01 WHERE salary > ANY (SELECT salary FROM EX01 WHERE job_id='ST_MAN');
-- 전체. --
SELECT * FROM EX01 WHERE salary > (SELECT MIN(salary) FROM EX01 WHERE job_id='ST_MAN') AND department_id <> 20
ORDER BY EX01.department_id ASC;

select * from ex01;
select * from ex01 where first_name='Valli';
select * from departments;

--  EMPLOYEES 테이블에서 Valli라는 이름을 가진 직원과 업무명 및 월급이 같은 사원의 모든 정보를 출력하는 SELECT문을 작성하시오. (결과에서 Valli는 제외) --
SELECT * FROM EX01 WHERE EXISTS (SELECT * FROM departments WHERE department_name='IT' AND salary=4800);

-- 전체. --
SELECT * FROM EX01 WHERE job_id=(SELECT job_id FROM EX01 WHERE first_name='Valli')
AND salary=(SELECT salary FROM EX01 WHERE first_name='Valli')
and first_name <> 'Valli';



-- EMPLOYEES 테이블에서 월급이 자신이(‘Valli’) 속한 부서의 평균 월급보다 높은 사원의 부서번호, 이름,급여를 출력하는 SELECT문을 작성하시오. --
SELECT * FROM EX01 WHERE EXISTS (SELECT * FROM departments WHERE salary > 4800);

-- 전체. --
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

