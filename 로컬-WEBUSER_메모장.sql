 CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
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

-- 회원가입 테이블(MEMBER) --
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

INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member01@daum.net', 'member01', '서울시 서초구 서초동', SYSDATE);
INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member02@daum.net', 'member02', '서울시 강남구 역삼동', SYSDATE);
INSERT INTO MEMBER VALUES(MEMBER_seq.NEXTVAL, 'member03@daum.net', 'member03', '서울시 강남구 강남동', SYSDATE);

CREATE SEQUENCE MEMBER_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
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

CREATE SEQUENCE LOGIN_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
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

SELECT * FROM ACCOUNT WHERE ID = '태스트09' AND PWD = '123';


UPDATE ACCOUNT SET ID='BBB', PWD='BBB' WHERE ID='AAA';
COMMIT;

-- TEMP MEMBER -----------------------------------------------------------------

CREATE TABLE TEMPMEMBER
(
    ID VARCHAR2(20) ,
    PASSWD VARCHAR2(20),
    NAME VARCHAR2(20),
    MEM_NUM1 VARCHAR2(6),
    MEM_NUM2 VARCHAR2(7), 
    E_MAIL VARCHAR2(30),
    PHONE VARCHAR2(30),
    ZIPCODE VARCHAR2(7),
    ADDRESS VARCHAR2(60),
    JOB VARCHAR2(30)
 );
 
ALTER TABLE TEMPMEMBER ADD CONSTRAINT TEMPMEMBER_ID_PK PRIMARY KEY(ID);
 
INSERT INTO TEMPMEMBER VALUES
('aaaa', '1111', '홍길동', '123456', '7654321', 'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');

INSERT INTO TEMPMEMBER VALUES
('bbbb', '1111', '홍길동', '123456', '7654321', 'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');

INSERT INTO TEMPMEMBER VALUES
('cccc', '1111', '홍길동', '123456', '7654321', 'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');

COMMIT;

SELECT * FROM TEMPMEMBER;

-- 회원가입 ---------------------------------------------------------------------
CREATE table STUDENT
(
 ID VARCHAR2(12) NOT NULL,
 PASS VARCHAR2(12) NOT NULL,
 NAME VARCHAR2(10) NOT NULL,
 PHONE1 VARCHAR2(3) NOT NULL,
 PHONE2 VARCHAR2(4) NOT NULL,
 PHONE3 VARCHAR2(4) NOT NULL,
 EMAIL VARCHAR2(30) NOT NULL,
 ZIPCODE VARCHAR2(7) NOT NULL,
 ADDRESS1 VARCHAR2(120) NOT NULL,
 ADDRESS2 VARCHAR2(50) NOT NULL
);

ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_ID_PK PRIMARY KEY(ID);
SELECT pass FROM STUDENT WHERE ID = 'kim01';

SELECT * FROm STUDENT;

create table zipcode
(
 seq NUMBER(10) not null,
 zipcode VARCHAR2(50),
 sido VARCHAR2(50),
 gugun VARCHAR2(50),
 dong VARCHAR2(50),
 bunji VARCHAR2(100)
);

ALTER TABLE zipcode add constraint zipcode_seq_PK primary key(seq);

desc student;
desc zipcode;

select * from zipcode;
select * from student;
commit;

SELECT COUNT(*) AS COUNT FROM STUDENT WHERE ID = 'aaa';

SELECT * FROM STUDENT WHERE ID = 'kim01';

SELECT * FROM zipcode WHERE dong LIKE '강남%';

UPDATE STUDENT SET pass='123456', phone1='02', phone2='1234', phone3='1234', email='kim01@naver.com', zipcode='135-836', address1='서울 강남구 대치1동', address2='123-123' WHERE id='kim01';
COMMIT;

----------- 답변형 게시판 --------------------------------------------------------
CREATE TABLE BOARD
(
    NUM NUMBER(7,0) NOT NULL,
    WRITER VARCHAR2(12) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    SUBJECT VARCHAR2(50) NOT NULL,
    PASS VARCHAR2(10) NOT NULL,
    READCOUNT NUMBER(5,0) DEFAULT 0, 
    "REF" NUMBER(5,0) DEFAULT 0, 
    STEP NUMBER(3,0) DEFAULT 0, 
    "DEPTH" NUMBER(3,0) DEFAULT 0, 
    REGDATE TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT" VARCHAR2(4000) NOT NULL,
    IP VARCHAR2(20) NOT NULL ENABLE
 );
 
 ALTER TABLE BOARD ADD CONSTRAINT BOARD_NUM_PK PRIMARY KEY(NUM);

CREATE SEQUENCE BOARD_SEQ-- 시퀀스이름
START WITH 1 -- 시작을 1로 설정
INCREMENT BY 1 -- 증가값을 1씩 증가
NOMAXVALUE -- 최대값이 무한대..
NOCACHE
NOCYCLE;

select * from board;
SELECT COUNT(*) AS COUNT FROM BOARD;
select * from board order by num desc;
select * from board where num = 1;
update board set readcount=readcount+1 where num = 1;

select COUNT(*) AS COUNT from board where num = 2 AND pass ='1234';

COMMIT;

CREATE TABLE jdbcBoard
(
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(1000) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence jdbcBoard_seq
start with 1
increment by 1;

select * from jdbcboard;

insert into jdbcBoard(board_no, title, content, writer) values(jdbcBoard_seq.NEXTVAL, 'aaa', 'aaa', 'aaa');
SELECT board_no, title, content, writer, reg_date FROM
jdbcBoard WHERE board_no > 0 ORDER BY board_no desc, reg_date DESC;

UPDATE jdbcBoard SET title ='test01', content ='test0101' WHERE board_no = 5;
commit;
---------------------------------------------------------------
CREATE TABLE jpaBoard
(
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(1000) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence jpaBoard_seq
start with 1
increment by 1;

select * from jpaboard;

CREATE TABLE mybatisboard
(
    board_no
    NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(500) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence mybatisboard_seq
start with 1
increment by 1;

SELECT * FROM MYBATISBOARD;

CREATE TABLE mybatismember
(
    user_no NUMBER,
    user_id VARCHAR2(50) NOT NULL,
    user_pw VARCHAR2(50) NOT NULL,
    user_name VARCHAR2(100) NOT NULL,
    coin NUMBER(10) DEFAULT 0,
    reg_date DATE DEFAULT SYSDATE,
    upd_date DATE DEFAULT SYSDATE,
    enabled CHAR(1) DEFAULT '1',
    PRIMARY KEY (user_no)
);

SELECT * FROM mybatismember;

CREATE TABLE mybatismember_auth
(
    user_no NUMBER NOT NULL,
    auth VARCHAR2(50) NOT NULL
);

SELECT * FROM mybatismember_auth;

ALTER TABLE mybatismember_auth ADD CONSTRAINT mybatismember_auth_userno_fk
FOREIGN KEY(user_no) REFERENCES mybatismember(user_no);

create sequence mybatismember_seq
start with 1
increment by 1;


-- File upload -----------------------------------------------------------------
CREATE TABLE item
(
    item_id NUMBER(5),
    item_name VARCHAR2(20),
    price NUMBER(6),
    description VARCHAR2(50),
    picture_url VARCHAR2(200),
    PRIMARY KEY (item_id)
);

create sequence item_seq
start with 1
increment by 1;

CREATE TABLE item2
(
    item_id NUMBER(5),
    item_name VARCHAR2(20),
    price NUMBER(6),
    description VARCHAR2(50),
    picture_url VARCHAR2(200),
    picture_url2 VARCHAR2(200),
    PRIMARY KEY (item_id)
);

create sequence item2_seq
start with 1
increment by 1;


-- File upload -----------------------------------------------------------------
CREATE TABLE aopBoard
(
    board_no 
    NUMBER,
    title VARCHAR2(100) NOT NULL, 
    content VARCHAR2(1000) NULL, 
    writer VARCHAR2(50) NOT NULL, 
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence aopBoard_seq 
start with 1
increment by 1;
