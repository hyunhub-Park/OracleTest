-- ���̺� �ۼ�.
CREATE TABLE SUBJECT
( 
    NO NUMBER,  -- pk, sequence
    NUM VARCHAR2(2) NOT NULL,   -- �а���ȣ 01, 02, 03, 04 ... (�� �ڸ��� ����.)
    NAME VARCHAR2(24) NOT NULL -- �а��̸�
);

ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NO_PK PRIMARY KEY(NO);
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NUM_UK UNIQUE(NUM);

CREATE SEQUENCE SUBJECT_SEQ
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------------------------------
CREATE TABLE STUDENT
( 
    NO NUMBER, -- pk, seq
    NUM VARCHAR2(8) NOT NULL,   -- �й�(yy+�а���ȣ)
    NAME VARCHAR2(12) NOT NULL, -- �̸�
    ID VARCHAR2(12) NOT NULL,   -- ���̵�
    PASSWD VARCHAR2(12) NOT NULL,   -- �н�����
    S_NUM varchar2(2) NOT NULL, -- fk(�а���ȣ)
    BIRTHDAY VARCHAR2(8) NOT NULL,  -- �������
    PHONE VARCHAR2(15) NOT NULL,    -- ��ȭ��ȣ
    ADDRESS VARCHAR2(80) NOT NULL,  -- �ּ�
    EMAIL VARCHAR2(40) NOT NULL,    -- �̸���
    SDATE DATE DEFAULT SYSDATE  -- �����
);

ALTER TABLE STUDENT ADD CONSTRAINT STUDETN_NO_PK PRIMARY KEY(NO);
ALTER TABLE STUDENT ADD CONSTRAINT STUDETN_ID_UK UNIQUE(ID);
ALTER TABLE STUDENT ADD CONSTRAINT STUDETN_NUM_UK UNIQUE(NUM);

ALTER TABLE STUDENT ADD CONSTRAINT STUDETN_SUBJECT_NUM_FK
FOREIGN KEY(S_NUM) REFERENCES SUBJECT(NUM) ON DELETE SET NULL;

ALTER TABLE STUDENT DROP CONSTRAINT STUDETN_SUBJECT_NUM_FK;

desc student;

CREATE SEQUENCE STUDENT_SEQ
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------------------------------
CREATE TABLE LESSON
( 
    NO NUMBER, -- pk, seq
    ABBRE VARCHAR2(2) NOT NULL,  -- ������.  
    NAME VARCHAR2(20) NOT NULL  -- �����̸�.
);

ALTER TABLE LESSON ADD CONSTRAINT LESSON_NO_PK PRIMARY KEY(NO);
ALTER TABLE LESSON ADD CONSTRAINT LESSON_ABBRE_UK UNIQUE(ABBRE);

CREATE SEQUENCE LESSON_SEQ
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------------------
create table trainee
(
    no number , -- pk, seq
    s_num varchar2(8) not null,   -- student fk(�л���ȣ).
    abbre varchar2(2) not null,   -- lesson fk(������).
    section varchar2(20) not null,  -- ����, ������, ����
    tdate date default sysdate    -- ������û��.
);

create sequence trainee_seq 
start with 1
increment by 1;






select * from subject;