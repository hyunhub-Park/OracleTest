-- CallableStatement Test From �ڹ�

DROP TABLE EMP1;

CREATE TABLE EMP1
AS
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES;

SELECT * FROM EMP1;
SELECT * FROM EMP1 ORDER BY DEPARTMENT_ID;

-- �μ��� ��ȣ�� �λ���� �Է��ϸ�, �ش�Ǵ� �μ��� �λ���� �����ϴ� SQL�� �ۼ�. �μ��� SALARY�λ�. (10�̸� 10%, 20�̸� 20%, �������� ����.) --
/*CREATE OR REPLACE PROCEDURE EMP_PROCEDURE (VDEPARTMENT_NO IN EMP1.DEPARTMENT_ID%TYPE)

IS

BEGIN
-- decode or if�� �ۼ�.
    UPDATE EMP1 SET SALARY=DECODE(VDEPARTMENT_NO, 10, SALARY*1.1, 20, SALARY*1.2, SALARY)
    WHERE DEPARTMENT_ID=VDEPARTMENT_NO;
    COMMIT;
END;
/*/

CREATE OR REPLACE PROCEDURE BOOKS_PROCEDURE (VID IN BOOKS.ID%TYPE, VPRICE IN BOOKS.PRICE%TYPE, VMESSAGE OUT VARCHAR2)

IS
    VBOOKS_RT BOOKS%ROWTYPE;

BEGIN
-- decode or if�� �ۼ�.
    UPDATE BOOKS SET PRICE=PRICE+VPRICE WHERE ID=VID;
    COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID=VID;
    VMESSAGE:=VBOOKS_RT.ID||'���� �λ�ݾ���'||VPRICE||'�̰�, �� �ݾ��� '||VBOOKS_RT.PRICE||'�Դϴ�.';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

CREATE OR REPLACE FUNCTION BOOKS_FUNCTION (VID IN BOOKS.ID%TYPE)
RETURN VARCHAR2

IS
    VBOOKS_RT BOOKS%ROWTYPE;
    VMESSAGE VARCHAR2(100);

BEGIN
-- decode or if�� �ۼ�.
    -- UPDATE BOOKS SET PRICE=PRICE+VPRICE WHERE ID=VID;
    -- COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID=VID;
    VMESSAGE:=VBOOKS_RT.ID||'���� �� �ݾ��� '||VBOOKS_RT.PRICE||'�Դϴ�.';
    RETURN VMESSAGE;
END;
/

SELECT BOOKS_FUNCTION(4) FROM DUAL;

EXECUTE EMP_PROCEDURE(10, 2);
-- ���� �� �ȵǴ��� Ȯ���غ���. --
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
-- decode or if�� �ۼ�.
    UPDATE MOVIE SET PRICE=DECODE(VID, ID, PRICE-(PRICE*0.05))
    WHERE ID=VID;
    COMMIT;
    SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    VMESSAGE:='ID '||VMOVIE_RT.ID||'���� 5%�� ������ ����Ǿ� �� '||VMOVIE_RT.PRICE||'�� �Դϴ�.';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

CREATE OR REPLACE PROCEDURE MOVIE_PROCEDURE2 (VID IN MOVIE.ID%TYPE)
IS
    --VMOVIE_RT MOVIE%ROWTYPE;
BEGIN
-- decode or if�� �ۼ�.
    UPDATE MOVIE SET PRICE=DECODE(VID, ID, PRICE-(PRICE*0.05))
    WHERE ID=VID;
    COMMIT;
    --SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    --VMESSAGE:='ID '||VMOVIE_RT.ID||'���� 5%�� ������ ����Ǿ� �� '||VMOVIE_RT.PRICE||'�� �Դϴ�.';
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
    -- decode or if�� �ۼ�.
    UPDATE MOVIE SET PRICE=PRICE-(PRICE*0.05) WHERE ID=VID;
    -- COMMIT;
    SELECT * INTO VMOVIE_RT FROM MOVIE WHERE ID=VID;
    VMESSAGE:='ID '||VMOVIE_RT.ID||'���� 5%�� ������ ����Ǿ� �� '||VMOVIE_RT.PRICE||'�� �Դϴ�.';
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