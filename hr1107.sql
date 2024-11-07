-- employees ����. --
create table emp03
as
select * from employees;

-- ��� ����� �μ���ȣ�� 30������ ����. --
select * from emp03;
UPDATE EMP03 SET DEPARTMENT_ID=30;  /* �̷��� ��ü�� �� �ٲ�. */
ROLLBACK;

-- ��� ����� �޿� 10%�λ�. --
UPDATE EMP03 SET SALARY=SALARY*1.1;
ROLLBACK;

-- �Ի����� ���ó�¥�� ����. --
UPDATE EMP03 SET HIRE_DATE=SYSDATE;
ROLLBACK;

-- �μ���ȣ�� 10���� ����� �μ���ȣ�� 30������ ����. --
UPDATE EMP03 SET DEPARTMENT_ID=30 WHERE DEPARTMENT_ID=10;
ROLLBACK;

-- �޿��� 3000 �̻��� ����� �޿��� 10% �λ�. --
UPDATE EMP03 SET SALARY=SALARY*1.1 WHERE SALARY>=3000;
ROLLBACK;

-- 2007�⿡ �Ի��� ����� �Ի����� ���ó�¥�� ����. --
UPDATE EMP03 SET HIRE_DATE=SYSDATE WHERE SUBSTR(HIRE_DATE, 1, 2)='07';

-- Susan�� �μ���ȣ�� 20������, ������ FI_MGR�� ����. --
UPDATE EMP03 SET DEPARTMENT_ID=20, JOB_ID='FI_MGR' WHERE UPPER(FIRST_NAME)=UPPER('Susan');
select * from emp03 where first_name='Susan';

-- LAST_NAME�� RUSSELL�� ����� �޿��� 17000, Ŀ�̼� ������ 0.45�� �λ�. --
UPDATE EMP03 SET SALARY=17000, COMMISSION_PCT=0.45 WHERE UPPER(LAST_NAME)=UPPER(RUSSELL);

-- 30�� �μ� ����. --
DELETE FROM EMP03 WHERE DEPARTMENTP_ID=30;
select * from emp03 where department_id=30;

create table MY_CUSTOMER
(
    CODE VARCHAR2(10),  --pk--
    NO VARCHAR2(5) NOT NULL,
    /*NO VARCHAR2(5) CONSTRAINT MY_CUSTOMER_NO_NN NOT NULL, default�� dd*/
    GENDER CHAR(2) NOT NULL,
    BIRTHDAY VARCHAR2(10) NOT NULL,
    PHONE VARCHAR2(20) --uk--
);

ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_CODE_PK PRIMARY KEY(CODE);
ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_GENDER_CK CHECK(GENDER in('M', 'W'));
ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_PHONE_UK UNIQUE(PHONE);

desc MY_CUSTOMER;
select * from user_constraints;
select * from user_constraints where table_name='MY_CUSTOMER';
select * from user_tables;
select * from user_cons_columns;

desc customer;

-- merge���. mycustomer�� customer�� ����. ������ insert, ���� �� update. --

INSERT INTO MY_CUSTOMER(code, no, gender, birthday, phone) VALUES ('27108','��','M','19430','010-2580-9919');

SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME='CUSTOMER';

-- CUSTOMER���̺��� email�������� ���ֱ�. --
ALTER TABLE CUSTOMER DROP CONSTRAINT CUSTOMER_EMAIL_UK;

-- MERGE MY_CUSTOMER -> CUSTOMER������ ����. ������ INSERT, ������ UPDATE. --
MERGE INTO CUSTOMER C
    USING MY_CUSTOMER M
    ON (C.NO=M.CODE)
    WHEN MATCHED THEN
        UPDATE SET C.NAME=M.NO,-- ���̺�� ���� ����. --
                    C.GENDER=M.GENDER,
                    C.BIRTH=M.BIRTHDAY,
                    C.PHONE=M.PHONE
    WHEN NOT MATCHED THEN
        INSERT (C.NO, C.NAME, C.GENDER, C.BIRTH, C.PHONE) VALUES(M.CODE, M.NO, M.GENDER, M.BIRTHDAY, M.PHONE);
        /*INSERT INTO ���̺��(�÷���...) VALUES(�÷���...)*/

SELECT * FROM CUSTOMER;
SELECT * FROM MY_CUSTOMER;
UPDATE MY_CUSTOMER SET NAME='�ڽ¿�' WHERE CODE='2017108';
    
    
    
CREATE TABLE DEPT01
(
    DEPT VARCHAR2(20),
    REGION VARCHAR2(20) NOT NULL
);

ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_DEPT_PK PRIMARY KEY(DEPT);

desc dept01;
select * from user_constraints where table_name='DEPT01';

CREATE TABLE MEMBER01
( /*pk�� ���� ���� ����.*/
    EMPLOYEE CHAR(10) NOT NULL,
    JOB_ID VARCHAR2(20),
    SALARY NUMBER(10) NOT NULL,
    DEPT_NO VARCHAR2(20)
);

ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_EMPLOYEE_PK PRIMARY KEY(EMPLOYEE);

/* �ڷ��� ����ߵ�.................................. ��û��.................. �����ϰ� �ٽ� �ۼ��ϱ�. !!�Ϸ�!! */
ALTER TABLE MEMBER01 MODIFY DEPT_NO NUMBER(5) REFERENCES DEPT01(DEPT);  -- DEPT01�� ���� ����� ���� Ȯ���غ���. --
ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(DEPT) ON DELETE CASCADE;

ALTER TABLE MEMBER01 DROP COLUMN DEPT_NO;

desc member01;

ALTER TABLE MEMBER01 ADD DEPT_NO VARCHAR2(20);
select * from user_constraints where table_name='MEMBER01';

INSERT INTO DEPT01(DEPT, REGION) VALUES ('�繫��', '����'); 
INSERT INTO DEPT01(DEPT, REGION) VALUES ('�ѹ���', '����');
INSERT INTO DEPT01(DEPT, REGION) VALUES ('�濵��', '����');

select * from DEPT01;

INSERT INTO MEMBER01(EMPLOYEE, JOB_ID, SALARY, DEPT_NO) VALUES ('����', 'a20241107', '3000', '�繫��');
INSERT INTO MEMBER01(EMPLOYEE, JOB_ID, SALARY, DEPT_NO) VALUES ('�ڻ��', 'b20241107', '3000', '������');

select * from MEMBER01;

DELETE FROM MEMBER01 WHERE DEPT_NO=40;
DELETE FROM DEP01 WHERE NO=40;

ALTER TABLE MEMBER DROP CONSTRAINT MEMBER_DEPT_NO_FK;
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER01_DEPT_NO_FK 
        OREIGN KEY(DEPT_NO) REFERENCES DEPT01(DEPT) ON DELETE CASCADE;


-- 1107 ����. --
/* 1�� */
CREATE TABLE EMP001
(
    no NUMBER(4), --pk--
    name VARCHAR2(10) NOT NULL,
    job VARCHAR(9),
    manager_no NUMBER(4),
    hire_date date NOT NULL,
    salary NUMBER(7, 2) NOT NULL,
    commission NUMBER(7, 2) default 0.0,
    department_no NUMBER(2) NOT NULL
);

ALTER TABLE EMP001 ADD CONSTRAINT EMP001_no_PK PRIMARY KEY(no);

/* 2�� */
INSERT INTO EMP001 VALUES(7369, 'SMITH', 'CLEAK', 7836, '80/12/17', 800, 0.0, 10);
INSERT INTO EMP001 VALUES(7499, 'ALLEN', 'SALESMAN', 7369, '87/12/20', 1600, 300, 30);
INSERT INTO EMP001 VALUES(7839, 'KING', 'PRESIDENT', null, '81/02/08', 5000, null, 10);

select * from emp001;

select * from user_constraints where table_name='EMP001';

/* 3�� */
CREATE TABLE MEMBERS
(
    id VARCHAR2(20),    --pk--
    name VARCHAR2(20) not null,
    region VARCHAR2(13) not null,
    phone VARCHAR2(13) not null,    --uk--
    address VARCHAR2(100) not null
);

ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_id_PK PRIMARY KEY(id);
ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_phone_uk UNIQUE(phone);

INSERT INTO MEMBERS VALUES('id001', '���ֹ�', '����', '010-0000-0001', 'A��');
INSERT INTO MEMBERS VALUES('id002', '���ֹ�', '����', '010-0000-0002', 'B��');
select * from members;

select * from user_constraints where table_name='MEMBERS';

/* 4�� */
create table BOOKS
(
    code NUMBER(4), --pk--
    title VARCHAR2(50) not null,
    count NUMBER(6) not null,
    price NUMBER(10) not null,
    publish VARCHAR2(50) not null
);

ALTER TABLE BOOKS ADD CONSTRAINT BOOKS_code_PK PRIMARY KEY(code);

INSERT INTO BOOKS VALUES(1000, '������å', 1, 12000, '��������');
INSERT INTO BOOKS VALUES(1001, '�󸶹�å', 2, 15000, '�α�����');
select * from books;

select * from user_constraints where table_name='BOOKS';

/* 5�� */
CREATE TABLE v_gogek
(
    g_code NUMBER(5),
    g_name VARCHAR2(20) not null,
    g_age NUMBER(3) default 0,
    g_addr VARCHAR2(50),
    g_tel VARCHAR2(20)
);

ALTER TABLE v_gogek ADD CONSTRAINT v_gogek_g_code_PK PRIMARY KEY(g_code);

INSERT INTO v_gogek VALUES(1000, '���', 25, '����', '010-0000-0001');
INSERT INTO v_gogek VALUES(1001, '�ڰ�', 35, '���', '010-0000-0002');
INSERT INTO v_gogek VALUES(1002, '�ְ�', 47, '����', '010-0000-0003');
UPDATE v_gogek SET g_tel='010-0000-0001' WHERE g_name='���';
UPDATE v_gogek SET g_tel='010-0000-0002' WHERE g_name='�ڰ�';
UPDATE v_gogek SET g_tel='010-0000-0003' WHERE g_name='�ְ�';

select * from v_gogek;

select * from user_constraints where table_name='v_gogek';

create table video
(
    v_code NUMBER(5),
    v_title VARCHAR2(50) NOT NULL,
    v_genre VARCHAR2(30),
    v_pay NUMBER(7) NOT NULL,
    v_lend_state NUMBER(1),
    v_make_company VARCHAR2(50),
    v_make_date DATE,
    v_view_age NUMBER(1)
);

ALTER TABLE VIDEO ADD CONSTRAINT video_v_code_PK PRIMARY KEY(v_code);
INSERT INTO video VALUES(00100, '����1', 'ȣ��', 10000, 1, '���ѿ�ȭ��', '24/11/07', 5);
INSERT INTO video VALUES(00101, '����2', '�θǽ�', 8000, 2, '�α���ȭ��', '24/11/06', 3);
INSERT INTO video VALUES(00102, '����3', 'ȣ��', 9000, 1, '�α���ȭ��', '24/11/05', 5);
select * from video;

select * from user_constraints where table_name='video';

create table lend_return
(
    lr_code NUMBER(5), --pk--
    g_code NUMBER(5) not null, --fk--
    v_code NUMBER(5) not null, --fk--
    l_date DATE,
    r_plan_date DATE,
    l_total_pay NUMBER(7)
);

ALTER TABLE lend_return ADD CONSTRAINT lend_return_lr_code_PK PRIMARY KEY(lr_code);
ALTER TABLE lend_return ADD CONSTRAINT lend_return_g_code_FK
        FOREIGN KEY(g_code) REFERENCES v_gogek(g_code) ON DELETE CASCADE;
ALTER TABLE lend_return ADD CONSTRAINT lend_return_v_code_FK
        FOREIGN KEY(v_code) REFERENCES video(v_code) ON DELETE CASCADE; 

INSERT INTO lend_return VALUES(111, 1000, 00100, '2024/11/08', '2024/11/15', 12000);
INSERT INTO lend_return VALUES(121, 1001, 00101, '2024/11/12', '2024/11/19', 12000);
INSERT INTO lend_return VALUES(150, 1001, 00101, '2024/11/12', '2024/11/19', 12000);

INSERT INTO lend_return VALUES(131, 1080, 00101, '2024/11/12', '2024/11/19', 12000);    /* ���Ἲ �������� ����� ���� �Ұ�. */
INSERT INTO lend_return VALUES(141, 1003, 00201, '2024/11/12', '2024/11/19', 12000);    /* ���Ἲ �������� ����� ���� �Ұ�. */
select * from lend_return;

select * from user_constraints where table_name='lend_return';