-- CallableStatement Test From 자바

DROP TABLE EMP1;

CREATE TABLE EMP1
AS
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES;

SELECT * FROM EMP1;
SELECT * FROM EMP1 ORDER BY DEPARTMENT_ID;

-- 부서별 번호와 인상률을 입력하면, 해당되는 부서만 인상률로 적용하는 SQL문 작성. 부서별 SALARY인상. (10이면 10%, 20이면 20%, 나머지는 동결.) --
/*CREATE OR REPLACE PROCEDURE EMP_PROCEDURE (VDEPARTMENT_NO IN EMP1.DEPARTMENT_ID%TYPE)

IS

BEGIN
-- decode or if문 작성.
    UPDATE EMP1 SET SALARY=DECODE(VDEPARTMENT_NO, 10, SALARY*1.1, 20, SALARY*1.2, SALARY)
    WHERE DEPARTMENT_ID=VDEPARTMENT_NO;
    COMMIT;
END;
/*/

CREATE OR REPLACE PROCEDURE BOOKS_PROCEDURE (VID IN BOOKS.ID%TYPE, VPRICE IN BOOKS.PRICE%TYPE, VMESSAGE OUT VARCHAR2)

IS
    VBOOKS_RT BOOKS%ROWTYPE;

BEGIN
-- decode or if문 작성.
    UPDATE BOOKS SET PRICE=PRICE+VPRICE WHERE ID=VID;
    COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID=VID;
    VMESSAGE:=VBOOKS_RT.ID||'번의 인상금액은'||VPRICE||'이고, 총 금액은 '||VBOOKS_RT.PRICE||'입니다.';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

CREATE OR REPLACE FUNCTION BOOKS_FUNCTION (VID IN BOOKS.ID%TYPE)
RETURN VARCHAR2

IS
    VBOOKS_RT BOOKS%ROWTYPE;
    VMESSAGE VARCHAR2(100);

BEGIN
-- decode or if문 작성.
    -- UPDATE BOOKS SET PRICE=PRICE+VPRICE WHERE ID=VID;
    -- COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID=VID;
    VMESSAGE:=VBOOKS_RT.ID||'번의 총 금액은 '||VBOOKS_RT.PRICE||'입니다.';
    RETURN VMESSAGE;
END;
/

SELECT BOOKS_FUNCTION(4) FROM DUAL;

EXECUTE EMP_PROCEDURE(10, 2);
-- 여기 왜 안되는지 확인해보기. --
EXECUTE BOOKS_PROCEDURE(3, 10000);

VARIABLE MESSAGE VARCHAR2(100);
EXECUTE BOOKS_PROCEDURE(5, 10000, :MESSAGE);

SELECT * FROM EMP1;
SELECT * FROM EMP1 ORDER BY DEPARTMENT_ID;

SELECT * FROM BOOKS;

-------------------------------MOVIE TEST----------------------------------------
CREATE OR REPLACE PROCEDURE MOVIE_PROCEDURE (VID IN MOVIE.ID%TYPE, VMESSAGE OUT VARCHAR2)
IS
    VMOVIE_RT MOVIE%ROWTYPE;
BEGIN
-- decode or if문 작성.
    UPDATE MOVIE SET PRICE=DECODE(VID, ID, PRICE-(PRICE*0.05))
    WHERE ID=VID;
    COMMIT;
    SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    VMESSAGE:='ID '||VMOVIE_RT.ID||'번에 5%의 할인이 적용되어 총 '||VMOVIE_RT.PRICE||'원 입니다.';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

CREATE OR REPLACE PROCEDURE MOVIE_PROCEDURE2 (VID IN MOVIE.ID%TYPE)
IS
    --VMOVIE_RT MOVIE%ROWTYPE;
BEGIN
-- decode or if문 작성.
    UPDATE MOVIE SET PRICE=DECODE(VID, ID, PRICE-(PRICE*0.05))
    WHERE ID=VID;
    COMMIT;
    --SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    --VMESSAGE:='ID '||VMOVIE_RT.ID||'번에 5%의 할인이 적용되어 총 '||VMOVIE_RT.PRICE||'원 입니다.';
    --DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/



EXECUTE MOVIE_PROCEDURE(36, ????);
EXECUTE MOVIE_PROCEDURE2(36);
COMMIT;
SELECT * FROM MOVIE;

CREATE OR REPLACE FUNCTION MOVIE_FUNCTION (VID IN MOVIE.ID%TYPE)
RETURN VARCHAR2

IS
    VMOVIE_RT MOVIE%ROWTYPE;
    VMESSAGE VARCHAR2(100);
BEGIN
    -- decode or if문 작성.
    UPDATE MOVIE SET PRICE=PRICE-(PRICE*0.05) WHERE ID=VID;
    -- COMMIT;
    SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    VMESSAGE:='ID '||VMOVIE_RT.ID||'번에 5%의 할인이 적용되어 총 '||VMOVIE_RT.PRICE||'원 입니다.';
    RETURN VMESSAGE;
END;
/

SELECT MOVIE_FUNCTION(4) FROM DUAL;
SELECT * FROM MOVIE;

CREATE OR REPLACE TRIGGER MOVIE2_TRIGGER
BEFORE INSERT ON MOVIE2
FOR EACH ROW
BEGIN
    :NEW.PRICE := :NEW.PRICE*1.1;
END;
/

DROP TRIGGER MOVIE_TRIGGER;

CREATE TABLE MOVIE2
AS
SELECT * FROM MOVIE;

INSERT INTO MOVIE2 VALUES (MOVIE_ID_SEQ.nextval, 'Movie PQR', 'Director PQR', '2021', 20000);
COMMIT;

CREATE SEQUENCE MOVIE2_ID_SEQ
START WITH 1
INCREMENT BY 1;

SELECT * FROM MOVIE2;
DELETE MOVIE2;
COMMIT;

SELECT * FROM MOVIE2;

--제약조건이 있는 테이블 강제삭제 DROP TABLE member_basic CASCADE CONSTRAINTS PURGE;--
--drop table board cascade constraints;--