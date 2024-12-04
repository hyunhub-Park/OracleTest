CREATE TABLE CUSTOMER
(
    NO CHAR(7), -- pk
    NAME VARCHAR2(20) NOT NULL, -- 이름
    BIRTH VARCHAR2(20), -- 생일(ex)20020707)
    PHONE VARCHAR2(15), -- uk 휴대폰번호
    REGIST DATE NOT NULL,   -- 등록날짜 SYSDATE 
    RIGHT NUMBER(1),    -- 권한
    ID VARCHAR2(20) NOT NULL,   -- uk 아이디
    PW VARCHAR2(20) NOT NULL,   -- PW 패스워드
    COUNT NUMBER(3) DEFAULT 0   -- 예매 합계(booking테이블에서 insert시 계수.)
);
SELECT * FROM CUSTOMER;
ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_NO_PK PRIMARY KEY(NO);
ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_PHONE_UQ UNIQUE(ID);
ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_ID_UQ UNIQUE(ID);
-- ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_GRADE_NO_FK FOREIGN KEY(GRADE_NO) REFERENCES GRADE(NO) ON DELETE SET NULL;

CREATE TABLE GRADE(
NO CHAR(1),             --PK
NAME VARCHAR2(10),      --등급이름
BENEFIT VARCHAR2(30)       --혜택
);
ALTER TABLE GRADE ADD CONSTRAINT GRADE_NO_PK PRIMARY KEY(NO);


CREATE TABLE PLANE(
NO CHAR(5),                  --PK
NAME VARCHAR2(10) NOT NULL,  --기종
ROWX NUMBER(2) NOT NULL,     --좌석의 행 개수
COLY NUMBER(2) NOT NULL,     --좌석의 열 개수
SEATS NUMBER(3)              --총 좌석 개수 트리거로 생성
);
ALTER TABLE PLANE ADD CONSTRAINT PLANE_NO_PK PRIMARY KEY(NO);
DELETE FROM PLANE;
INSERT INTO PLANE(NO,NAME,ROWX,COLY) VALUES('00001','A',20,8);--인서트 테스트
SELECT * FROM PLANE;
SELECT * FROM SEATS;

CREATE TABLE SEATS( --비행기 기종별 좌석정보 
NO CHAR(6),                  --PK   
PLANE_NO CHAR(5),            --비행기 기종 NO  FK
ROWX VARCHAR2(2) NOT NULL,   --행 코드 01~99
COLY VARCHAR2(2) NOT NULL    --열 코드 A...Z 
);
ALTER TABLE SEATS ADD CONSTRAINT SEATS_NO_PK PRIMARY KEY(NO);
ALTER TABLE SEATS ADD CONSTRAINT SEATS_PLANE_NO_FK FOREIGN KEY(PLANE_NO) REFERENCES PLANE(NO) ON DELETE CASCADE;


CREATE TABLE COUNTRY(
NO CHAR(5),                      --PK
NAME VARCHAR(15) NOT NULL,       --이름
DISTANCE NUMBER(5) NOT NULL,     --거리
HOUR NUMBER(3) NOT NULL          --소요시간
);
ALTER TABLE COUNTRY ADD CONSTRAINT COUNTRY_NO_PK PRIMARY KEY(NO);


CREATE TABLE FLIGHT(        --항공편
NO CHAR(5),                              --PK
PLANE_NO CHAR(5) NOT NULL,               --비행기 기종 NO FK
DEPARTURE_COUNTRY_NO CHAR(5) NOT NULL,   --출발 국가
ARRIVAL_COUNTRY_NO CHAR(5) NOT NULL,     --도착 국가
PRICE NUMBER(8),                         --가격
DEPARTURE_HOUR DATE NOT NULL,            --출발 시간
ARRIVAL_HOUR DATE NOT NULL               --도착 시간
);

ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_NO_PK PRIMARY KEY(NO);
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_PLANE_NO_FK FOREIGN KEY(PLANE_NO) REFERENCES PLANE(NO) ON DELETE CASCADE;
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_DEPARTURE_COUNTRY_NO_FK FOREIGN KEY(DEPARTURE_COUNTRY_NO) REFERENCES COUNTRY(NO) ON DELETE SET NULL;
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_ARRIVAL_COUNTRY_NO_FK FOREIGN KEY(ARRIVAL_COUNTRY_NO) REFERENCES COUNTRY(NO) ON DELETE SET NULL;

DROP TABLE BOOKING;
CREATE TABLE BOOKING
(
    NO CHAR(7), --PK
    GROUP_NO CHAR(6) NOT NULL,  --예매 그룹 NO
    CUSTOMER_NO CHAR(7) NOT NULL,   --고객 NO FK
    FLIGHT_NO CHAR(5) NOT NULL, --항공편 NO FK
    CODE CHAR(20),  --CODE NO-CUSTOMER_NO-FLIGHT_NO 로 생성 TRIGGER
    SEAT VARCHAR2(4) NOT NULL,  --좌석
    SEATS_NO CHAR(6),   --입력된 좌석에 맞춰서 좌석번호 가져오게. FK TRGGER
    BOOKING_DATE DATE NOT NULL  --예매 날짜
);
INSERT INTO BOOKING(NO,SEAT,BOOKING_DATE) VALUES('0000002','A02',SYSDATE);
SELECT * FROM BOOKING;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_NO_PK PRIMARY KEY(NO);
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_SEATS_NO_FK FOREIGN KEY(SEATS_NO) REFERENCES SEATS(NO) ON DELETE CASCADE;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_CUSTOMER_NO_FK FOREIGN KEY(CUSTOMER_NO) REFERENCES CUSTOMER(NO) ON DELETE CASCADE;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_FLIGHT_NO_FK FOREIGN KEY(FLIGHT_NO) REFERENCES FLIGHT(NO) ON DELETE CASCADE;

-----------------------------------------------------------------------------------------------------------------------------------------------------TRG

--BOOKING 입력또는 업데이트시 SEAT에 맞춰서 SEATS_NO를 업데이트
CREATE OR REPLACE TRIGGER BOOKING_SEATS_TRG
BEFORE INSERT OR UPDATE
ON BOOKING
FOR EACH ROW
DECLARE
SNO CHAR(6);
BEGIN
SELECT NO INTO SNO FROM SEATS WHERE ROWX=SUBSTR(:NEW.SEAT,1,1) AND COLY=SUBSTR(:NEW.SEAT,2);
:NEW.SEATS_NO:=SNO;
END;
/

--BOOKING INSERT 시 코드 자동 생성
CREATE OR REPLACE TRIGGER BOOKING_INSERT_TRG
BEFORE INSERT
ON BOOKING
FOR EACH ROW
BEGIN
:NEW.CODE:=:NEW.GROUP_NO||'-'||:NEW.CUSTOMER_NO||'-'||:NEW.FLIGHT_NO;
END;
/

--PLANE 추가시에 SEATS TABLE 자동으로 추가
CREATE OR REPLACE TRIGGER PLANE_INSERT_TRG
AFTER INSERT 
ON PLANE
FOR EACH ROW
BEGIN
FOR i IN ASCII('A') .. (ASCII('A') + :NEW.ROWX - 1) LOOP--FOR IN 구문으로 SEATS에 값 추가 ASCCII 코드를 사용해서 A...Z 반환
FOR j IN 1 .. :NEW.COLY LOOP
INSERT INTO SEATS VALUES (TO_CHAR((SELECT NVL(MAX(NO),0)+1 FROM SEATS),'FM000000'),:NEW.NO, CHR(i), TO_CHAR(j,'FM00'));
END LOOP;
END LOOP;
END;
/


--PLANE 테이블 INSERT시 X,Y에 맞춰서 SEATS 개수추가
CREATE OR REPLACE TRIGGER PLANE_BEFORE_INSERT_TRG
BEFORE INSERT 
ON PLANE
FOR EACH ROW
BEGIN
:NEW.SEATS := :NEW.ROWX*:NEW.COLY;
END;
/