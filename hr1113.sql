-- 트랜잭션. --

drop table dep02;

-- 테이블 복사.(구조만) --
CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;

/* not null만 복사. */
SELECT * FROM user_constraints where table_name='dep02'; --> 여기까지가 커밋임.

-- 내용 복사. --
INSERT INTO dep02 SELECT * FROM departments;

select * from dep02;

ROLLBACK; -- 13행까지. --

DELETE FROM dep02;

SAVEPOINT C1;

DELETE FROM dep02 WHERE department_id=90;

ROLLBACK; --> 항상 커밋 기준으로 돌아감. 13행.

ROLLBACK TO C1;

-- VIEW 생성하기.(복사) --
CREATE VIEW VIEW_EMP01
AS
SELECT employee_id, first_name, salary, department_id FROM employees WHERE department_id=10;

SELECT * FROM view_emp01;

-- employees 복사본 만들기. --
CREATE TABLE emp_copy
AS
SELECT * FROM employees;

SELECT * FROM emp_copy; /* 제약조건은 not null만 복사 됐을 것. */

-- VIEW 제거하기. --
DROP VIEW view_emp01;

----
CREATE VIEW VIEW_EMP01
AS
SELECT employee_id, first_name, salary, department_id FROM emp_copy WHERE department_id=10;

-- 복사된 뷰 확인하기. --
SELECT * FROM view_emp01;
select * from emp_copy where employee_id=200;

-- VIEW 수정하기. --
UPDATE view_emp01 SET salary=4500 where employee_id=200;    /* 원본도 수정이 함께 됨. */

-- DATA DICTIONARY --
--USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS, USER_VIEWS, USER_INDEXES--
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_constraants_columns WHERE table_name='employees';
SELECT * FROM user_views;
SELECT * FROM user_indexes;

-- 가상 뷰에 입력하기. (가상테이블에 컬럼 4개를 입력) --
INSERT INTO view_emp01 VALUES(1000, 'JDK', 2000, 50);   /* not null 삽입 안됨. */
                                                        /* 컬럼명을 가상테이블에 넣어주면 넣을 수 있음. */
SELECT * FROM view_emp01;
SELECT * FROM user_constraints WHERE table_name='emp_copy';

CREATE VIEW view_emp02
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id FROM emp_copy WHERE department_id=10;

SELECT * FROM view_emp02;
/* 원본에 들어감. 77행의 쿼리문만 실행하는 것이니까! 가상이니까! */
INSERT INTO view_emp02 VALUES(1000, 'JDK', 'KDJ', 'JDKKDJ', TO_DATE('2020/01/01', 'yyyy/mm/dd'), 'IT_DEV');

select * from emp_copy where employee_id=1000;
DESC emp_copy;

-- VIEW 3 생성하기. --
CREATE VIEW view_emp03
AS                                                                               /*where을 안주면 91수행 시 보임.*/
SELECT employee_id, first_name, last_name, email, hire_date, job_id FROM emp_copy;

SELECT * FROM view_emp03;
/*제약조건은 not null만 있음.*/
INSERT INTO view_emp02 VALUES(2000, 'JDK', 'KDJ', 'JDKKDJ', TO_DATE('2020/01/01', 'yyyy/mm/dd'), 'IT_DEV');

select * from emp_copy where employee_id=2000;

SELECT * FROM view_emp03 where employee_id=2000;

-- 가상 뷰에서 삭제 진행하기. --
delete from view_emp03 where employee_id=2000;

-- 복합뷰 생성하기 (employees, departments)두 개의 테이블 조인하여 새로운 가상테이블 만들기. --
CREATE VIEW view_emp_dep
AS
SELECT employee_id, first_name, salary, E.department_id, department_name, location_id
FROM employees E INNER JOIN departments D ON E.department_id=D.department_id
ORDER BY department_id DESC;

SELECT * FROM view_emp_dep;
SELECT DISTINCT department_id, department_name FROM view_emp_dep;

-- 부서명 it 연봉 평균, 최고값, 최저값 구하기. --
SELECT department_name, MAX(salary), MIN(salary) FROM view_emp_dep WHERE department_name='IT' GROUP BY department_name;

-- VIEW에서 FORCE조건. --
CREATE OR REPLACE FORCE VIEW view_force
AS
SELECT employee_id, first_name, last_name, department_id FROM emp20;    /*만들기는 만들어주지만(FORCE) 내용물은 볼 수 없음.*/

select * from emp20;

select * from user_views;

-- ROWNUM. --
SELECT ROWNUM, employee_id, first_name FROM employees;
SELECT ROWNUM, department_id, first_name FROM employees WHERE department_id=100;
SELECT ROWNUM, department_id, first_name FROM employees WHERE department_id=100
ORDER BY first_name DESC;

-- ROWNUM 정렬 시, 순서가 흐트러지는 것을 재배치 하고싶을 때. --
SELECT ROWNUM, employee_id, first_name, hire_date FROM employees;
SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc;   /* 순서가 흐트러짐. */

CREATE OR REPLACE VIEW view_hiredate
AS
SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc;   /* ROWNUM이 insert순으로 배치 됨. */

SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate;

SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate WHERE ROMNUM <= 5; /* 5개만 출력. */
SELECT ROWNUM, employee_id, first_name, hire_date FROM view_hiredate WHERE ROMNUM=4; /* 출력X. */

SELECT ROWNUM, employee_id, first_name, hire_date
FROM(SELECT employee_id, first_name, hire_date FROM employees ORDER BY hire_date desc)
WHERE ROWNUM <= 4;

-- 사원번호, 사원명, 부서명, 부서위치 출력하는 VIEW_LOC 작성하기. --
CREATE VIEW VIEW_LOC
AS
SELECT E.employee_id, E.first_name, D.department_name, D.location_id from emp_copy E inner join dep02 d
ON E.department_id=D.department_id;

select * from view_loc;

-- 30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 VIEW_DEPT30 작성하기. --
CREATE VIEW VIEW_DEPT30
AS
SELECT E.first_name, E.hire_date, D.department_name from emp_copy E inner join dep02 d
ON E.department_id=D.department_id where D.department_id=30;

select * from view_dept30;

-- 부서별 최대 급여 정보를 가지는 뷰(VIEW_DEPT_MAXSAL) 생성. --
CREATE VIEW VIEW_DEPT_MAXSAL
AS
SELECT E.first_name, E.hire_date, D.department_name from emp_copy E inner join dep02 d
ON E.department_id=D.department_id where D.department_id=30;

select * from view_dept30;

-- 급여를 많이 받는 순서대로 3명만 출력하는 뷰(VIEW_SAL_TOP3) 생성. --


CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;
