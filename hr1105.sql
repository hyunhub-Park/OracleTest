-- 테이블 설계하기.(사원번호, 사원명, 급여) --
/*class EMP01
{
    private가 아닌 public!
    private int no;
    private String name;
    private double salary;
}*/

-- get/set -> update, toString -> select, 추가 -> alter, 변경 -> alter의 modify, 삭제 -> alter의 drop. --
    -- 38자 사용 가능. 때문에 값 지정해주기.--
   /* no NUMBER(4) not null primary key,
    name VARCHAR2(20) not null unique,
    salary NUMBER(10, 2) not null*/
    
    --no NUMBER(4),CONSTRAINT emp01_no_nn not null,--
    --name VARCHAR2(20) default 'abc',--
    --salary NUMBER(10, 2),--
        --CONSTRAINT EMP01_NO_PK primary key(no),--
        /* 무결성 제약조건 - (cascade), primary key, unique, foreign key, not null, check, default */
        /* alter - add, modify, drop, rename, alter 제약조건 - 추가, 변경, 제거 */
        /*no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_PK primary key(no, name),
    CONSTRAINT emp01_salary_uk unique(salary)*/
    
/*select * from user_constraints where table_name='EMP01';
SELECT OWNER, constraint_name, table_name, column_name from user_cons_columns where table_name='EMP01';*/
/*SYS_C007701	Check	"NAME" IS NOT NULL -> emp01 table의 제약조건 탭.
제약조건이 나왔는데 이름이 없으면 NOT NULL임.
NOT NULL도 Check타입으로 들어옴.*/
        
        
 create table EMP01
 (
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_no_PK primary key(no),
    CONSTRAINT emp01_name_uk unique(name)
 );
 -- 테이블 정보 구하기. --
 select * from tab;
 
 -- 테이블 삭제하기. --
 drop table emp01;
 
 -- 테이블 복사하기. --
 desc employees;
 -- 전체 개수 확인(group by랑 같음.count). --
 select count(*) from employees;
 -- 수가 많으니까 복사. --
 create table emple02
 as
 select * from employees;
 desc emple02;
 select count(*) from emple02;  /* 테이블은 제약조건 복사 안됨. not null만 됨. */
 
 -- 해당된 테이블에 제약조건 걸기. pk --
 alter table emple02 add constraint emple02_id_pk primary key(employee_id);
 alter table emple02 add constraint emple02_email_uk unique(email); /* 이메일은 not null인데 unique까지 있으니 거의 pk급. */
 
 -- unique 제약조건 삭제하기. --
 alter table emple02 drop constraint emple02_email_uk;
 -- 제약조건 확인하기. --
 select * from user_constraints;    /* user_tables, user_constraint_columns */
 select * from user_constraints where table_name=upper('emple02');  /* 대소문자 식별 잊지말기!!!! */
 select table_name, constraint_type, constraint_name from user_constraints where table_name=upper('emple02');  /* 대소문자 식별 잊지말기!!!! */
 -- 컬럼 추가. emp01안에 job을! --
-- create table emp01 as select * from employees; --
alter table emp01 add jab varchar2(10) not null;
desc emp01;
-- 컬럼 제거. emp01의 jab을! 오타냄... --
alter table emp01 drop column jab;
desc emp01;
alter table emp01 add job varchar2(10) not null;
-- 컬럼 변경. emp01의 job을! ?????기존 값이 존재하는지 여부 확인 반드시 필요!! 같은 자료형의 확장만 가능. --
alter table emp01 modify job number(10) default 0;
desc emp01;
-- 컬럼 이름 변경. --
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;

drop table emp01;

select * from tab;

-- 휴지통 보기. --
select * from recyclebin;
/*휴지통 비우기 purge recyclebin;*/
-- 휴지통 복원. --
flashback table emp01 to before drop;
select * from tab;
 /* DDL : create, alter, drop rename, truncate(구조는 그대로 가지고 있고, 객체만 제거함.) */
 -- 테이블명 변경 emp01 -> emp02 --
 rename emp01 to emp02;
 select * from tab;
 
 alter table emp01 add credate date;
 select * from emp01;
 desc emp01;
 
 create table customer
 ( /* constraint customer_gender_ck check(gender in('M', 'W')) */
    no char(7) not null,    /* pk */
    name varchar2(10) not null,
    gender char(1) not null,    /* check */
    birth char(8) not null,
    phone varchar2(16),
    email varchar2(30), /* unique */
    point number(10, 0) default 0 /* dafault 0 */
 );
 
 alter table customer add constraint customer_no_pk primary key(no);
 alter table customer add constraint customer_gender_ck check(gender in('M', 'W'));
 /* alter table customer add constraint customer_gender_ck check(gender='M' or 'W'); */
 alter table customer add constraint customer_email_uk unique(email);
 
 desc customer;
 
 alter table customer add reg_dttm char(14);

select * from user_constraints where table_name='CUSTOMER';     /* 대문자 유의. */

desc emp01;
-- 제약조건 NOT NULL추가하기. --
alter table emp01 modify salary number(10,2) not null;



-- 1106 과제. --
create table GRADES
(
    NO NUMBER(10) NOT NULL, --pk--
    NAME CHAR(5) NOT NULL,
    KOR NUMBER(10) DEFAULT 0 NOT NULL,
    ENG NUMBER(10) DEFAULT 0 NOT NULL,
    MATH NUMBER(10) DEFAULT 0 NOT NULL,
    TOTAL NUMBER(10) DEFAULT 0,
    AVG NUMBER(10, 2) DEFAULT 0.0, 
    CODE NUMBER(10) --fk 부모테이블의 pk or uk--
);
/*식별, 비식별 관계*/
create table DEPARTMENT
(
    DEP_CODE NUMBER(10) NOT NULL, -- pk --
    DEP_NAME VARCHAR2(30) NOT NULL
);

desc grades;
select * from GRADES;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='GRADES';

ALTER TABLE GRADES ADD CONSTRAINT GRADES_NO_PK PRIMARY KEY(NO);
ALTER TABLE GRADES MODIFY CODE NUMBER(10) REFERENCES DEPARTMENT(DEP_CODE);  /* GRADES테이블의 CODE값은 DEPARTMENT의 학과코드를 참조한다. */


ALTER TABLE GRADES ADD CONSTRAINT GRADES_DEPARTMENT_CODE_FK FOREIGN KEY(CODE) REFERENCES DEPARTMENT(DEP_CODE) ON DELETE CASCADE;

ALTER TABLE GRADES MODIFY NAME CHAR(20);
ALTER TABLE GRADES RENAME CONSTRAINT SYS_C007741 TO GRADES_CODE_RK;
INSERT INTO GRADES(NO, NAME, KOR, ENG, MATH, TOTAL, AVG, CODE)
        VALUES(20241106, '김학생', 95, 80, 70, 245, 81.7, 10);
INSERT INTO GRADES(NO, NAME, KOR, ENG, MATH, TOTAL, AVG, CODE)
        VALUES(20241106, '최학생', 85, 85, 90, 260, 86.7, 50); -- 학과코드 50은 DEPARTMENT 테이블에 없는 값으로 오류. --


desc department;
select * from DEPARTMENT;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPARTMENT';

ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPARTMENT_DEP_CODE_PK PRIMARY KEY(DEP_CODE);
ALTER TABLE DEPARTMENT MODIFY DEP_NAME VARCHAR2(30);
INSERT INTO DEPARTMENT (DEP_CODE, DEP_NAME) VALUES (20241106, '컴퓨터공학');
INSERT INTO DEPARTMENT (DEP_CODE, DEP_NAME) VALUES (20241105, '생명공학');
UPDATE DEPARTMENT SET DEP_CODE=30 WHERE DEP_NAME='컴퓨터공학';
UPDATE DEPARTMENT SET DEP_CODE=10 WHERE DEP_NAME='생명공학';
SELECT DEP_CODE as 학과코드, DEP_NAME as 학과명 FROM DEPARTMENT;
/*1.학번의 (숫자)데이터는 중복되거나 null값을 허용하면 안 되고
2.이름은 문자데이터며 null값을 허용하지 않고
국어, 영어, 수학 컬럼을 number 타입으로 가지고 모두 다 null값을 허용하지 않습니다.
단, 국어,영어,수학 컬럼에 데이터를 넣지 않으면 기본값으로 0을 갖습니다.
총점과 평균 컬럼은 기본값을 0을 갖습니다.
학과코드는 학과 테이블에 학과 코드를 참조한다. -> 학과테이블의 학과코드를 참조. 외래키!
학번/이름/국어/영어/수학/총점/평균/학과코드 이게 컬럼명이다.

학과 테이블
학과코드 데이터는 중복되거나 null값을 허락하지 않는다.
학과명은 null값을 허락하지 않는다.

학과코드/학과명
샘플데이터 입력 :
select 한 결과를 보여주시면 됩니다.*/

/* 부서별에 따라 급여를 인상하도록 하자. (Join - inner join, outer join, self join, cross join) */
select table_name from user_tables;

select * from departments;
select employee_id, first_name, salary, department_id from employees;
select * from employees inner join departments on employees.department_id=departments.department_id;
                            /* department_id로만 실행 시, id가 2개 이므로 열의 정의가 애매하다는 오류가 뜸. */
/*select employee_id, first_name, job_id, salary, employees.department_id, department_name*/

/* decode로도 작성해보기. */
select employee_id, first_name, job_id, salary, E.department_id, D.department_name
        case 
            when upper(D.department_name = upper('Marketing') then salary*1.05
            when upper(D.department_name = upper('Purchasing') then salary*1.10
            when upper(D.department_name = upper('Human Resources') then salary*1.15
            when upper(D.department_name = upper('IT') then salary*1.20
            end NEWSALARY
from employees E inner join departments D on E.department_id=D.department_id
where upper(D.department_name) in(upper('Marketing'),upper('Purchasing'),upper('Human Resources'),upper('IT'))
order by NEWSALARY DESC;

select employee_id, salary, job_id, A.department_id, B.depratmenr_name,
        case when e.department_name='Marketing' then salary*1.05
            when b.department_name='Purchasing' then dalary*1.15
            when b.department_name='Human Resources' then salary*1.15;
            when departmnet_name='IT' then salary*1.20
 
 