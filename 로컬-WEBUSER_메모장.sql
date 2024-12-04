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