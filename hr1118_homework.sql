-- 1118과제. --

-- 성적 처리 테이블. --
CREATE TABLE GRADE
(
    ID NUMBER(4),
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MATH NUMBER(4) NOT NULL,
    TOTAL NUMBER(4),
    AVG NUMBER(5, 1),
    RANK NUMBER(4)
);

ALTER TABLE GRADE ADD CONSTRAINT GRADE_STUDENT_ID_PK PRIMARY KEY(ID);

-- PROCEDURE --
CREATE OR REPLACE PROCEDURE GRADE_INPUT
(
    V_ID IN GRADE.ID%TYPE,
    V_NAME IN GRADE.NAME%TYPE,
    V_KOR IN GRADE.KOR%TYPE,
    V_ENG IN GRADE.ENG%TYPE,
    V_MATH IN GRADE.MATH%TYPE    
)
IS
    V_TOTAL GRADE.TOTAL%TYPE :=0;
    V_AVG GRADE.AVG%TYPE :=0;
    V_RANK GRADE.RANK%TYPE;

BEGIN
    V_TOTAL := V_KOR + V_ENG + V_MATH;
    V_AVG := (V_TOTAL)/3;
    
    INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH, TOTAL, AVG, RANK)
    VALUES(V_ID, V_NAME, V_KOR, V_ENG, v_MATH, V_TOTAL, V_AVG, V_RANK);
    
    DBMS_OUTPUT.PUT_LINE('학생 성적 입력 완료.');
END;
/
-- 프로시저 실행. --
EXECUTE GRADE_INPUT(2024, '김학생', 90, 90, 90);

-- TRIGGER --
CREATE OR REPLACE TRIGGER GRADE_TRIGGER
BEFORE INSERT ON GRADE
FOR EACH ROW
BEGIN
    :NEW.TOTAL := :NEW.KOR + :NEW.ENG + :NEW.MATH;
    :NEW.AVG := (:NEW.TOTAL)/3;
    DBMS_OUTPUT.PUT_LINE('학생 성적 입력 완료.');
END;
/

DROP TRIGGER GRADE_TRIGGER;

INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2024, '김학생', 70, 85, 90);
INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2023, '최학생', 70, 85, 90);
INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2022, '이학생', 80, 80, 80);
INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2021, '장학생', 90, 60, 80);
INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2020, '윤학생', 80, 70, 80);
INSERT INTO GRADE(ID, NAME, KOR, ENG, MATH) VALUES(2019, '임학생', 90, 90, 90);
    
DELETE FROM GRADE WHERE NAME='최학생';
SELECT * FROM GRADE;

-- RANK PROCEDURE --
CREATE OR REPLACE PROCEDURE GRADE_RANK
IS
BEGIN
UPDATE GRADE G SET RANK=(SELECT RANKING FROM(SELECT RANK() OVER(ORDER BY AVG DESC) AS RANKING,
ID, NAME, KOR, ENG, MATH, TOTAL FROM GRADE ORDER BY AVG DESC) B WHERE B.ID=G.ID);
DBMS_OUTPUT.PUT_LINE('순위 산정 완료.');
END;
/

EXECUTE GRADE_RANK;

SELECT RANK() OVER(ORDER BY AVG DESC) AS RANK, ID, NAME, KOR, ENG, MATH, TOTAL FROM GRADE ORDER BY AVG DESC;
/* ↓ 이렇게 줘야 AVG에 DESC가능한듯?? ↓ */
SELECT NAME, TOTAL, RANK() OVER(ORDER BY AVG DESC) AS RANK FROM GRADE ORDER BY AVG DESC;


------------------------------------ REVIEW ------------------------------------
-- score 테이블 생성
CREATE TABLE SCORE (
    STUNUM NUMBER(4),
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MAT NUMBER(4) NOT NULL,
    TOT NUMBER(4),
    AVE NUMBER(5,1),
    RANK NUMBER(4)
);
-- 제약조건 등록
ALTER TABLE SCORE ADD CONSTRAINT SCORE_STUNUM_PK PRIMARY KEY(STUNUM);

CREATE OR REPLACE NONEDITIONABLE PROCEDURE SCORE_PROC_INPUT (
    VSTUNUM IN SCORE.STUNUM%TYPE,
    VNAME IN SCORE.NAME%TYPE,
    VKOR IN SCORE.KOR%TYPE,
    VENG IN SCORE.ENG%TYPE,
    VMAT IN SCORE.MAT%TYPE
)
IS 
    VTOT NUMBER;
    VAVE NUMBER;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVE := (VTOT)/3;
    INSERT INTO SCORE(STUNUM,NAME,KOR,ENG,MAT,TOT,AVE)
    VALUES (VSTUNUM,VNAME,VKOR,VENG,VMAT,VTOT,VAVE);
END;
/

-- TRIGGER --

EXECUTE SCORE_PROC_INPUT (1,'홍길동',99,80,85);
SELECT * FROM SCORE;

CREATE OR REPLACE TRIGGER SCORE_TRIGGER AFTER
INSERT ON SCORE
FOR EACH ROW

DECLARE 
    VTOT NUMBER(3);
    VAVE NUMBER(5,2);
BEGIN
    VTOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    VAVE := VTOT / 3;
END;
/

INSERT INTO SCORE (STUNUM,NAME,KOR,ENG,MAT) VALUES (2,'김희진',95,84,79);
SELECT * FROM SCORE;
INSERT INTO SCORE (STUNUM,NAME,KOR,ENG,MAT) VALUES (3,'이현수',83,89,99);


-- AFTER --
CREATE OR REPLACE TRIGGER SUNG_INSERT_TRG
/* FOR EACH ROW하면 안됨. */
AFTER INSERT
ON
SUNG
BEGIN
/* 해당된 '컬럼'만 적용이 되기 때문에 행 전체가 바뀌지는 않음(?). */
UPDATE SUNG SET TOTAL=(KOR+ENG+MATH);
UPDATE SUNG SET AVG=(KOR+ENG+MATH)/3;
END;
/

-- BEFORE --
/* 동일한 테이블 내를 처리할 때, Oracle내에서 PRAGMA라는 개념을 사용함. 
DECLARE
PRAGMA AOTUNOMOUS_TRANSACTION;*/
CREATE OR REPLACE TRIGGER SCORE_TRIGGER01
    BEFORE INSERT ON SCORE
    FOR EACH ROW
BEGIN
    :NEW.TOTAL := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    :NEW.AVG := ROUND((:NEW.KOR + :NEW.ENG + :NEW.MAT) / 3, 1);
END;

/
INSERT INTO SCORE (STUNUM,NAME,KOR,ENG,MAT) VALUES (3,'이희진',95,84,79);

INSERT INTO SCORE(NO,NAME,KOR,ENG,MAT) VALUES((SELECT NVL(MAX(NO),0)+1 FROM SCORE),DBMS_RANDOM.STRING('U',5),
ROUND(DBMS_RANDOM.VALUE(50,100)),ROUND(DBMS_RANDOM.VALUE(50,100)),ROUND(DBMS_RANDOM.VALUE(50,100)));

SELECT * FROM SCORE;

-- RANK() PROCEDURE --
CREATE OR REPLACE PROCEDURE SCORE_RANK_PROC
IS 

BEGIN
UPDATE SCORE S SET RANK=(SELECT S_RANK FROM(SELECT STUNUM,RANK()OVER(ORDER BY AVE DESC) AS S_RANK FROM SCORE) WHERE S.STUNUM=STUNUM);
END;
/
EXECUTE SCORE_RANK_PROC;
SELECT * FROM SCORE ORDER BY RANK ASC, KOR DESC, ENG DESC, MAT DESC;

-- CURSOR 활용. --
CREATE OR REPLACE PROCEDURE SCORE_RANK_PROC
IS
    VSCORE_ROWTYPE SCORE%ROWTYPE;
    CURSOR C1 IS
    SELECT NAME, TOTAL, RANK() OVER(ORDER BY AVG DESC) AS RANK FROM GRADE ORDER BY AVG DESC;

BEGIN
UPDATE SCORE S SET RANK=(SELECT S_RANK FROM(SELECT STUNUM,RANK()OVER(ORDER BY AVE DESC) AS S_RANK FROM SCORE) WHERE S.STUNUM=STUNUM);
END;
/
EXECUTE SCORE_RANK_PROC;
SELECT * FROM SCORE ORDER BY RANK ASC, KOR DESC, ENG DESC, MAT DESC;


