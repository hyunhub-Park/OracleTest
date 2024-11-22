-- 테이블 작성.
CREATE TABLE SUBJECT
( 
    NO NUMBER,  -- pk, sequence
    NUM VARCHAR2(2) NOT NULL,   -- 학과번호 01, 02, 03, 04 ... (두 자리로 지정.)
    NAME VARCHAR2(24) NOT NULL -- 학과이름
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
    NUM VARCHAR2(8) NOT NULL,   -- 학번(yy+학과번호)
    NAME VARCHAR2(12) NOT NULL, -- 이름
    ID VARCHAR2(12) NOT NULL,   -- 아이디
    PASSWD VARCHAR2(12) NOT NULL,   -- 패스워드
    S_NUM varchar2(2) NOT NULL, -- fk(학과번호)
    BIRTHDAY VARCHAR2(8) NOT NULL,  -- 생년월일
    PHONE VARCHAR2(15) NOT NULL,    -- 전화번호
    ADDRESS VARCHAR2(80) NOT NULL,  -- 주소
    EMAIL VARCHAR2(40) NOT NULL,    -- 이메일
    SDATE DATE DEFAULT SYSDATE  -- 등록일
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
    ABBRE VARCHAR2(2) NOT NULL,  -- 과목요약.  
    NAME VARCHAR2(20) NOT NULL  -- 과목이름.
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
    s_num varchar2(8) not null,   -- student fk(학생번호).
    abbre varchar2(2) not null,   -- lesson fk(과목요약).
    section varchar2(20) not null,  -- 전공, 부전공, 교양
    tdate date default sysdate    -- 수강신청일.
);

create sequence trainee_seq 
start with 1
increment by 1;






select * from subject;