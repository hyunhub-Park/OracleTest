CREATE SEQUENCE visit_seq  -- �������̸�
   START WITH 1             -- ������ 1�� ����
   INCREMENT BY 1          -- ���� ���� 1�� ����
   NOMAXVALUE             -- �ִ� ���� ���Ѵ�
   NOCACHE
   NOCYCLE;

CREATE table VISIT
(
    NO         NUMBER(5,0) NOT NULL,
    WRITER     VARCHAR2(20) NOT NULL,
    MEMO     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
-- constraint VISIT_PK primary key (NO)
);

ALTER TABLE VISIT ADD CONSTRAINT VISIT_NO_PK PRIMARY KEY(NO);

INSERT INTO VISIT VALUES(VISIT_seq.NEXTVAL, 'ppp', 'test', SYSDATE);

select * from visit;

-- ȸ������ ���̺�(MEMBER) --
CREATE TABLE MEMBER
(
    NO NUMBER,  -- pk
    ID VARCHAR2(20),    --uk
    PWD VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    REGDATE DATE NOT NULL
);

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_ID_UK UNIQUE(ID);

DROP TABLE MEMBER;
SELECT * FROM MEMBER;
SELECT * FROM MEMBER ORDER BY NO;

INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member01@daum.net', 'member01', '����� ���ʱ� ���ʵ�', SYSDATE);
INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member02@daum.net', 'member02', '����� ������ ���ﵿ', SYSDATE);
INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member03@daum.net', 'member03', '����� ������ ������', SYSDATE);

CREATE SEQUENCE MEMBER_seq  -- �������̸�
   START WITH 1             -- ������ 1�� ����
   INCREMENT BY 1          -- ���� ���� 1�� ����
   NOMAXVALUE             -- �ִ� ���� ���Ѵ�
   NOCACHE
   NOCYCLE;  

-- LOGIN -----------------------------------------------------------------------
CREATE table LOGIN
(
     ID VARCHAR2(12) NOT NULL,
     PASS VARCHAR2(12) NOT NULL
);
SELECT * FROM LOGIN;
ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_ID_PK PRIMARY KEY(ID);

CREATE SEQUENCE LOGIN_seq  -- �������̸�
   START WITH 1             -- ������ 1�� ����
   INCREMENT BY 1          -- ���� ���� 1�� ����
   NOMAXVALUE             -- �ִ� ���� ���Ѵ�
   NOCACHE
   NOCYCLE;
   
INSERT INTO LOGIN VALUES('member01', '123456');

SELECT * FROM LOGIN;





---------------
CREATE TABLE ACCOUNT
(
    NO NUMBER(5, 0)  NOT NULL,-- pk
    NAME VARCHAR2(20) NOT NULL,
    ID VARCHAR2(4000) NOT NULL,    --uk
    PWD VARCHAR2(4000) NOT NULL,
    REGDATE DATE NOT NULL
);

ALTER TABLE ACCOUNT ADD CONSTRAINT ACCOUNT_NO_PK PRIMARY KEY(NO);
ALTER table ACCOUNT add constraint ACCOUNT_ID_UK UNIQUE(id);


INSERT INTO ACCOUNT VALUES((select NVL(max(no),0)+1 from ACCOUNT), 'AAA', 'AAA', 'AAA', SYSDATE);
SELECT * FROM ACCOUNT ORDER BY NO;

SELECT PWD FROM ACCOUNT WHERE ID = 'BBB';

SELECT * FROM ACCOUNT ORDER BY NO;

SELECT * FROM ACCOUNT WHERE ID = '�½�Ʈ09' AND PWD = '123';


UPDATE ACCOUNT SET ID='BBB', PWD='BBB' WHERE ID='AAA';
COMMIT;