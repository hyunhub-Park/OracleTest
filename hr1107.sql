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
CREATE TABLE EMP001
(
    no NUMBER(4), --pk--
    name VARCHAR2(10) NOT NULL,
    job VARCHAR(9),
    manager_no NUMBER(4),
    hire_date date NOT NULL,
    salary NUMBER(7, 2),
    commission NUMBER(7, 2),
    department_no NUMBER(2)
);
