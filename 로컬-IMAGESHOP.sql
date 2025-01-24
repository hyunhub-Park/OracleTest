-- 코드 그룹 테이블. -----------------------------------------------
CREATE TABLE code_group
(
    group_code VARCHAR2(3) NOT NULL,
    group_name VARCHAR2(30) NOT NULL,
    use_yn VARCHAR2(1) DEFAULT 'Y',
    reg_date DATE DEFAULT SYSDATE,
    upd_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (group_code)
);

SELECT * FROM CODE_GROUP;
		SELECT group_code,
				group_name,
				use_yn,
				reg_date
		FROM code_group
		ORDER BY group_code DESC,
		reg_date DESC;
        
INSERT INTO code_group (group_code, group_name) VALUES ('A00', '직업');

-- 코드 상세 테이블. -----------------------------------------------
CREATE TABLE code_detail
(
    group_code VARCHAR2(3) NOT NULL,
    code_value VARCHAR2(3) NOT NULL,
    code_name VARCHAR2(30) NOT NULL,
    sort_seq NUMBER NOT NULL,
    use_yn VARCHAR2(1) DEFAULT 'Y',
    reg_date DATE DEFAULT SYSDATE,
    upd_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (group_code, code_value)
);

SELECT * FROM code_detail;

INSERT INTO code_detail (group_code, code_value, code_name, sort_seq)
VALUES ('A00', '01', '개발자', 1);

INSERT INTO code_detail (group_code, code_value, code_name, sort_seq)
VALUES ('A00', '02', '디자이너', 2);

INSERT INTO code_detail (group_code, code_value, code_name, sort_seq)
VALUES ('A00', '03', '매니저', 3);

INSERT INTO code_detail (group_code, code_value, code_name, sort_seq)
VALUES ('A00', '04', '분석가', 4);

COMMIT;


CREATE TABLE member
(
    user_no NUMBER(5) NOT NULL,
    user_id VARCHAR2(50) NOT NULL,
    user_pw VARCHAR2(100) NOT NULL,
    user_name VARCHAR2(100) NOT NULL,
    job VARCHAR2(3) DEFAULT '00',
    coin NUMBER(10) DEFAULT 0,
    reg_date DATE DEFAULT SYSDATE,
    upd_date DATE DEFAULT SYSDATE,
    enabled VARCHAR2(1) DEFAULT '1',
    PRIMARY KEY (user_no)
);

create sequence member_seq
start with 1
increment by 1;

SELECT * FROM MEMBER;

CREATE TABLE member_auth 
(
    user_no NUMBER(5) NOT NULL,
    auth VARCHAR2(50) NOT NULL
);

select * from member_auth;

-- member, member_auth 테이블 join 제약조건.------------------------
ALTER TABLE member_auth ADD CONSTRAINT fk_member_auth_user_no
FOREIGN KEY (user_no) REFERENCES member(user_no);

CREATE TABLE persistent_logins 
(
    username VARCHAR2(64) NOT NULL,
    series VARCHAR2(64) NOT NULL,
    token VARCHAR2(64) NOT NULL,
    last_used DATE NOT NULL,
    PRIMARY KEY (series)
);

-- 로그인 상태 유지 테이블(REMEBER ME)-------------------------------
CREATE TABLE persistent_logins 
(
    username VARCHAR2(64) NOT NULL,
    series VARCHAR2(64) NOT NULL,
    token VARCHAR2(64) NOT NULL,
    last_used DATE NOT NULL,
    PRIMARY KEY (series)
);

-- 회원 게시판 --------------------------------------------------
CREATE TABLE board
(
    board_no NUMBER NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(3000),
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence board_seq
start with 1
increment by 1;

SELECT * FROM BOARD;


-- 공지사항 ---------------------------------------------------
CREATE TABLE notice 
(
    notice_no NUMBER NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(3000),
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (notice_no)
);

create sequence notice_seq
start with 1
increment by 1;

-- 상품 ---------------------------------------------------------
CREATE TABLE item
(
    item_id NUMBER(10) NOT NULL,
    item_name VARCHAR2(30) NOT NULL,
    price NUMBER(7) NOT NULL,
    description VARCHAR2(500) NOT NULL,
    picture_url VARCHAR2(200),
    preview_url VARCHAR2(200),
    PRIMARY KEY (item_id)
);

create sequence item_seq
start with 1
increment by 1;

-- 충전 내역----------------------------------------------------
CREATE TABLE charge_coin_history 
(
    history_no NUMBER(10) NOT NULL,
    user_no NUMBER(10) NOT NULL,
    amount NUMBER(10) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (history_no)
);

create sequence charge_coin_history_seq
start with 1
increment by 1;

-- 구매상품 ---------------------------------------------------
CREATE TABLE user_item
(
    user_item_no NUMBER(10) NOT NULL,
    user_no NUMBER(10) NOT NULL,
    item_id NUMBER(10) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (user_item_no)
);

create sequence user_item_seq
start with 1
increment by 1;

-- 지급 내역 --------------------------------------------------
CREATE TABLE pay_coin_history 
(
    history_no NUMBER(10) NOT NULL,
    user_no NUMBER(10) NOT NULL,
    item_id NUMBER(10) NOT NULL,
    amount NUMBER(10) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (history_no)
);

create sequence pay_coin_history_seq
start with 1
increment by 1;
