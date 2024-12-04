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