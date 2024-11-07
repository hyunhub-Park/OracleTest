-- ���̺� �����ϱ�.(�����ȣ, �����, �޿�) --
/*class EMP01
{
    private�� �ƴ� public!
    private int no;
    private String name;
    private double salary;
}*/

-- get/set -> update, toString -> select, �߰� -> alter, ���� -> alter�� modify, ���� -> alter�� drop. --
    -- 38�� ��� ����. ������ �� �������ֱ�.--
   /* no NUMBER(4) not null primary key,
    name VARCHAR2(20) not null unique,
    salary NUMBER(10, 2) not null*/
    
    --no NUMBER(4),CONSTRAINT emp01_no_nn not null,--
    --name VARCHAR2(20) default 'abc',--
    --salary NUMBER(10, 2),--
        --CONSTRAINT EMP01_NO_PK primary key(no),--
        /* ���Ἲ �������� - (cascade), primary key, unique, foreign key, not null, check, default */
        /* alter - add, modify, drop, rename, alter �������� - �߰�, ����, ���� */
        /*no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_PK primary key(no, name),
    CONSTRAINT emp01_salary_uk unique(salary)*/
    
/*select * from user_constraints where table_name='EMP01';
SELECT OWNER, constraint_name, table_name, column_name from user_cons_columns where table_name='EMP01';*/
/*SYS_C007701	Check	"NAME" IS NOT NULL -> emp01 table�� �������� ��.
���������� ���Դµ� �̸��� ������ NOT NULL��.
NOT NULL�� CheckŸ������ ����.*/
        
        
 create table EMP01
 (
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_no_PK primary key(no),
    CONSTRAINT emp01_name_uk unique(name)
 );
 -- ���̺� ���� ���ϱ�. --
 select * from tab;
 
 -- ���̺� �����ϱ�. --
 drop table emp01;
 
 -- ���̺� �����ϱ�. --
 desc employees;
 -- ��ü ���� Ȯ��(group by�� ����.count). --
 select count(*) from employees;
 -- ���� �����ϱ� ����. --
 create table emple02
 as
 select * from employees;
 desc emple02;
 select count(*) from emple02;  /* ���̺��� �������� ���� �ȵ�. not null�� ��. */
 
 -- �ش�� ���̺� �������� �ɱ�. pk --
 alter table emple02 add constraint emple02_id_pk primary key(employee_id);
 alter table emple02 add constraint emple02_email_uk unique(email); /* �̸����� not null�ε� unique���� ������ ���� pk��. */
 
 -- unique �������� �����ϱ�. --
 alter table emple02 drop constraint emple02_email_uk;
 -- �������� Ȯ���ϱ�. --
 select * from user_constraints;    /* user_tables, user_constraint_columns */
 select * from user_constraints where table_name=upper('emple02');  /* ��ҹ��� �ĺ� ��������!!!! */
 select table_name, constraint_type, constraint_name from user_constraints where table_name=upper('emple02');  /* ��ҹ��� �ĺ� ��������!!!! */
 -- �÷� �߰�. emp01�ȿ� job��! --
-- create table emp01 as select * from employees; --
alter table emp01 add jab varchar2(10) not null;
desc emp01;
-- �÷� ����. emp01�� jab��! ��Ÿ��... --
alter table emp01 drop column jab;
desc emp01;
alter table emp01 add job varchar2(10) not null;
-- �÷� ����. emp01�� job��! ?????���� ���� �����ϴ��� ���� Ȯ�� �ݵ�� �ʿ�!! ���� �ڷ����� Ȯ�常 ����. --
alter table emp01 modify job number(10) default 0;
desc emp01;
-- �÷� �̸� ����. --
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;

drop table emp01;

select * from tab;

-- ������ ����. --
select * from recyclebin;
/*������ ���� purge recyclebin;*/
-- ������ ����. --
flashback table emp01 to before drop;
select * from tab;
 /* DDL : create, alter, drop rename, truncate(������ �״�� ������ �ְ�, ��ü�� ������.) */
 -- ���̺�� ���� emp01 -> emp02 --
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

select * from user_constraints where table_name='CUSTOMER';     /* �빮�� ����. */

desc emp01;
-- �������� NOT NULL�߰��ϱ�. --
alter table emp01 modify salary number(10,2) not null;



-- 1106 ����. --
create table GRADES
(
    NO NUMBER(10) NOT NULL, --pk--
    NAME CHAR(5) NOT NULL,
    KOR NUMBER(10) DEFAULT 0 NOT NULL,
    ENG NUMBER(10) DEFAULT 0 NOT NULL,
    MATH NUMBER(10) DEFAULT 0 NOT NULL,
    TOTAL NUMBER(10) DEFAULT 0,
    AVG NUMBER(10, 2) DEFAULT 0.0, 
    CODE NUMBER(10) --fk �θ����̺��� pk or uk--
);
/*�ĺ�, ��ĺ� ����*/
create table DEPARTMENT
(
    DEP_CODE NUMBER(10) NOT NULL, -- pk --
    DEP_NAME VARCHAR2(30) NOT NULL
);

desc grades;
select * from GRADES;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='GRADES';

ALTER TABLE GRADES ADD CONSTRAINT GRADES_NO_PK PRIMARY KEY(NO);
ALTER TABLE GRADES MODIFY CODE NUMBER(10) REFERENCES DEPARTMENT(DEP_CODE);  /* GRADES���̺��� CODE���� DEPARTMENT�� �а��ڵ带 �����Ѵ�. */


ALTER TABLE GRADES ADD CONSTRAINT GRADES_DEPARTMENT_CODE_FK FOREIGN KEY(CODE) REFERENCES DEPARTMENT(DEP_CODE) ON DELETE CASCADE;

ALTER TABLE GRADES MODIFY NAME CHAR(20);
ALTER TABLE GRADES RENAME CONSTRAINT SYS_C007741 TO GRADES_CODE_RK;
INSERT INTO GRADES(NO, NAME, KOR, ENG, MATH, TOTAL, AVG, CODE)
        VALUES(20241106, '���л�', 95, 80, 70, 245, 81.7, 10);
INSERT INTO GRADES(NO, NAME, KOR, ENG, MATH, TOTAL, AVG, CODE)
        VALUES(20241106, '���л�', 85, 85, 90, 260, 86.7, 50); -- �а��ڵ� 50�� DEPARTMENT ���̺� ���� ������ ����. --


desc department;
select * from DEPARTMENT;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPARTMENT';

ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPARTMENT_DEP_CODE_PK PRIMARY KEY(DEP_CODE);
ALTER TABLE DEPARTMENT MODIFY DEP_NAME VARCHAR2(30);
INSERT INTO DEPARTMENT (DEP_CODE, DEP_NAME) VALUES (20241106, '��ǻ�Ͱ���');
INSERT INTO DEPARTMENT (DEP_CODE, DEP_NAME) VALUES (20241105, '�������');
UPDATE DEPARTMENT SET DEP_CODE=30 WHERE DEP_NAME='��ǻ�Ͱ���';
UPDATE DEPARTMENT SET DEP_CODE=10 WHERE DEP_NAME='�������';
SELECT DEP_CODE as �а��ڵ�, DEP_NAME as �а��� FROM DEPARTMENT;
/*1.�й��� (����)�����ʹ� �ߺ��ǰų� null���� ����ϸ� �� �ǰ�
2.�̸��� ���ڵ����͸� null���� ������� �ʰ�
����, ����, ���� �÷��� number Ÿ������ ������ ��� �� null���� ������� �ʽ��ϴ�.
��, ����,����,���� �÷��� �����͸� ���� ������ �⺻������ 0�� �����ϴ�.
������ ��� �÷��� �⺻���� 0�� �����ϴ�.
�а��ڵ�� �а� ���̺� �а� �ڵ带 �����Ѵ�. -> �а����̺��� �а��ڵ带 ����. �ܷ�Ű!
�й�/�̸�/����/����/����/����/���/�а��ڵ� �̰� �÷����̴�.

�а� ���̺�
�а��ڵ� �����ʹ� �ߺ��ǰų� null���� ������� �ʴ´�.
�а����� null���� ������� �ʴ´�.

�а��ڵ�/�а���
���õ����� �Է� :
select �� ����� �����ֽø� �˴ϴ�.*/

/* �μ����� ���� �޿��� �λ��ϵ��� ����. (Join - inner join, outer join, self join, cross join) */
select table_name from user_tables;

select * from departments;
select employee_id, first_name, salary, department_id from employees;
select * from employees inner join departments on employees.department_id=departments.department_id;
                            /* department_id�θ� ���� ��, id�� 2�� �̹Ƿ� ���� ���ǰ� �ָ��ϴٴ� ������ ��. */
/*select employee_id, first_name, job_id, salary, employees.department_id, department_name*/

/* decode�ε� �ۼ��غ���. */
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
 
 