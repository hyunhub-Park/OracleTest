-- 프로시저를 통해 사원번호를 입력하면 사원이름/사원월급/사원직책 매개변수를 통해 전달. --

CREATE OR REPLACE PROCEDURE EMP_PROCEDURE_OUTMODE
(
    VEMPNO IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    VNAME OUT EMPLOYEES.FIRST_NAME%TYPE,
    VSALARY OUT EMPLOYEES.SALARY%TYPE,
    VJOBID OUT EMPLOYEES.JOB_ID%TYPE
)
IS
    -- 지역 변수. --

BEGIN
    --SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
    SELECT FIRST_NAME, SALARY, JOB_ID INTO VNAME, VSALARY, VJOBID FROM EMPLOYEES WHERE EMPLOYEE_ID=VEMPNO;

--EXCEPTION

END;
/

-- EXCE를 사용하면 값을 입력하는게 불가함.

DECLARE
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;

BEGIN
    -- 변수명은 달라도 되지만, 타입은 항상 같게 해야 함.
    EMP_PROCEDURE_OUTMODE(100,
    VEMP_ROWTYPE.FIRST_NAME,
    VEMP_ROWTYPE.SALARY,
    VEMP_ROWTYPE.JOB_ID
    );
    
    DBMS_OUTPUT.PUT_LINE('이름 : '||VEMP_ROWTYPE.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('봉급 : '||VEMP_ROWTYPE.SALARY);
    DBMS_OUTPUT.PUT_LINE('직책 : '||VEMP_ROWTYPE.JOB_ID);

END;
/

-- 프로시저를 워크시트 밖에서 불러 사용.
VARIABLE VNAME VARCHAR2(100)
VARIABLE VSALARY NUMBER
VARIABLE VJOBID VARCHAR2(10)

EXECUTE EMP_PROCEDURE_OUTMODE(200, :VNAME, :VSALARY, :VJOBID);

PRINT VNAME;
PRINT VSALARY;
PRINT VJOBID;

-- PROCEDURE IN/OUT MODE 동시 사용.
CREATE OR REPLACE PROCEDURE PROCEDURE_INOUTMODE(VSALARY IN OUT VARCHAR2)

IS

BEGIN
    VSALARY := TO_CHAR(VSALARY, '$999999999');
    VSALARY := '$'||SUBSTR(VSALARY, -9, 3)||','||SUBSTR(VSALARY, -6, 3)||','||SUBSTR(VSALARY, -3, 3);

END;
/

DECLARE
    VSALARY VARCHAR(20) := '123456789';

BEGIN
    PROCEDURE_INOUTMODE(VSALARY);
    DBMS_OUTPUT.PUT_LINE('VSALARY = '||VSALARY);
END;
/

-- 트리거 테스팅. --
DROP TABLE EMP01;
-- EMP01 만든 후, 트리거 생성. 입력될 때마다 입력값 출력해주는 트리거.
CREATE TABLE EMP01
(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR(20),
    JOB VARCHAR2(50)
);

desc emp01;

CREATE OR REPLACE TRIGGER EMP01_TRIGGER
    AFTER INSERT ON EMP01
    FOR EACH ROW
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(:NEW.EMPNO||', '||:NEW.ENAME||', '||'신입사원이 입사하였습니다.');

END;
/

INSERT INTO EMP01 VALUES((SELECT NVL(MAX(EMPNO), 0)+1 FROM EMP01), DBMS_RANDOM.STRING('U', 4), 'IT_DEV');

SELECT * FROM EMP01;

CREATE TABLE SAL01
(
    SALNO NUMBER(4),
    SALARY NUMBER,
    EMPNO NUMBER(4)    
);

alter table SAL01 add constraint SAL01_SALNO_pk primary key(SALNO);
alter table SAL01 add constraint SAL01_EMPNO_fk foreign key(EMPNO) REFERENCES EMP01(EMPNO);

SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME='SAL01';

CREATE SEQUENCE SAL01_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100000
NOCYCLE
CACHE 2;

-- 입력하면 저장이 되어야 하니까, 트리거 생성. --
CREATE OR REPLACE TRIGGER EMP01_TRRIGER2
AFTER INSERT ON EMP01
FOR EACH ROW
BEGIN
                            /* 시퀀스를 사용하기 싫다면, 아래방법으로. */
    -- INSERT INTO SAL01 VALUE((SELECT NVL(MAX(EMPNO), 0)+1 FROM SAL01));
    INSERT INTO SAL01 VALUES(SAL01_SEQ.NEXTVAL, 100000, :NEW.EMPNO);
    DBMS_OUTPUT.PUT_LINE(:NEW.EMPNO||'번호 사원이 성공적으로 입력되었습니다.');
END;
/

INSERT INTO EMP01 VALUES((SELECT NVL(MAX(EMPNO), 0)+1 FROM EMP01), DBMS_RANDOM.STRING('U', 4), 'IT_DEV');

SELECT * FROM SAL01;
SELECT * FROM EMP01;

-- EMP01에서 사원의 정보를 제거했을 때, SAL01에 해당되는 사원도 함께 삭제되도록 프로그래밍. --
CREATE OR REPLACE TRIGGER EMP01_TRIGGER3
    AFTER DELETE ON EMP01
    FOR EACH ROW
BEGIN
    -- SAL에 해당되는 사원의 정보가 삭제돼야 함.
    DELETE FROM SAL01 WHERE EMPNO=:OLD.EMPNO;
    DBMS_OUTPUT.PUT_LINE(:OLD.EMPNO||'가 SAL01에서 삭제 완료되었습니다.');

END;
/

DELETE FROM EMP01 WHERE EMPNO=4;
SELECT * FROM EMP01;
SELECT * FROM SAL01;

-- chapter 31 27p--

CREATE TABLE PRODUCT
(
    PCODE CHAR(6),
    PNAEM VARCHAR2(12) NOT NULL,
    PCOMPANY VARCHAR(12),
    PRICE NUMBER(8),
    STOCK NUMBER DEFAULT 0
);

ALTER TABLE PRODUCT RENAME COLUMN PNAEM TO PNAME;
ALTER TABLE PRODUCT RENAME COLUMN PRICE TO PPRICE;

ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PCODE_PK PRIMARY KEY(PCODE);

CREATE TABLE RECEIVING
(
    RNO NUMBER(6),
    PCODE CHAR(6),
    RDATE DATE DEFAULT SYSDATE,
    RQTY NUMBER(6),
    RPRICE NUMBER(8),
    RAMOUNT NUMBER(8)
);

ALTER TABLE RECEVING RENAME TO RECEIVING;

ALTER TABLE RECEIVING ADD CONSTRAINT RECEIVING_RNO_PK PRIMARY KEY(RNO);
ALTER TABLE RECEIVING ADD CONSTRAINT RECEIVING_PCODE_PK FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE);

INSERT INTO PRODUCT(PCODE, PNAME, PCOMPANY, PPRICE) VALUES('A00001', '세탁기', 'LG', 1500000);
INSERT INTO PRODUCT(PCODE, PNAME, PCOMPANY, PPRICE) VALUES('A00002', '컴퓨터', 'LG', 1000000);
INSERT INTO PRODUCT(PCODE, PNAME, PCOMPANY, PPRICE) VALUES('A00003', '냉장고', '삼성', 4500000);

SELECT * FROM PRODUCT;

CREATE OR REPLACE TRIGGER TRG_IN
AFTER INSERT ON RECEIVING
FOR EACH ROW
BEGIN
    UPDATE PRODUCT
    SET STOCK=STOCK+:NEW.RQTY
    WHERE PCODE=:NEW.PCODE;
END;
/

INSERT INTO RECEIVING(RNO, PCODE, RQTY, RPRICE, RAMOUNT) VALUES(1, 'A00001', 5, 850000, 950000);

SELECT * FROM RECEIVING;
SELECT * FROM PRODUCT;

CREATE OR REPLACE TRIGGER TRG_UP
AFTER UPDATE ON RECEIVING
FOR EACH ROW
BEGIN
    UPDATE PRODUCT
    SET STOCK=STOCK+(-:OLD.RQTY+:NEW.RQTY)
    WHERE PCODE=:NEW.PCODE;
END;
/

UPDATE RECEIVING SET RQTY=8, RAMOUNT=280000 WHERE RNO=3;

SELECT * FROM PRODUCT;
SELECT * FROM RECEIVING;

-- FUNCTION : 부서번호 입력 시, 부서명을 리턴해주는 함수 작성하기. --
-- 부서번호가 존재하지 않을 시, '해당부서 없음'값으로 리턴.


CREATE OR REPLACE FUNCTION GET_DEPARTMENT_NAME_FUNC(VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE)
RETURN VARCHAR2

IS
    VDEPARTMENT_NAME VARCHAR2(100);
    VCOUNT NUMBER :=0;

BEGIN
    -- 해당 부서의 카운트 체크.
    -- SELECT COUNT(*) FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    SELECT COUNT(*) INTO VCOUNT FROM EMPLOYEES WHERE DEPARTMENT_ID=VDEPARTMENT_ID;
    
    IF (VCOUNT=0) THEN
        VDEPARTMENT_NAME := '해당부서 없음.';
    ELSE
        SELECT DEPARTMENT_NAME INTO VDEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID=VDEPARTMENT_ID;
    END IF;
    
    RETURN VDEPARTMENT_NAME;
END;
/

SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID,  GET_DEPARTMENT_NAME_FUNC(DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES WHERE FIRST_NAME='Steven';

VARIABLE VNAME VARCHAR2;
/*EXECUTE :VNAME:=  GET_DEPARTMENT_NAME_FUNC(90);
O*/

-- RANK(), DENSE RANK(), ROW NUMBER --

DROP TABLE EMP02;

CREATE TABLE EMP02
AS
SELECT * FROM EMPLOYEES WHERE 1=1;

/* ORDER BY전에 select에서 붙인 번호임. 따라서 ROWNUM실행 시 번호가 흐트러짐. */
SELECT ROWNUM, FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;

/* F W G H S O */
SELECT ROWNUM, FIRST_NAME, SALARY FROM(SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC);

-- RANK(), DENSE_RANK() --
SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;
SELECT RANK() OVER(ORDER BY SALARY DESC) AS RANK, FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;
SELECT ROWNUM, RANK() OVER(ORDER BY SALARY DESC) AS RANK, FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC; -- 앞에 ROWNUM붙이면 순서 흐트러짐.

SELECT ROWNUM, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK, FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;
SELECT ROWNUM, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) ORDER BY SALARY DESC;

SELECT ROWNUM, RANK() OVER(ORDER BY SALARY DESC) AS RANK, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) ORDER BY SALARY DESC;

-- Steven의 연봉 순위. --
/*SELECT RANK() OVER(ORDER BY SALARY DESC) AS RANK, FIRST_NAME, SALARY
FROM EMP02 WHERE FIRST_NAME='Steven' ORDER BY SALARY DESC;*/

-- 중복 순위 없애기. --
SELECT RANK() OVER(ORDER BY SALARY DESC) AS RANK , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK 
, FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;

SELECT RANK() OVER(ORDER BY SALARY DESC, COMMISSION_PCT DESC) AS RANK ,FIRST_NAME, SALARY, COMMISSION_PCT FROM EMPLOYEES ORDER BY SALARY DESC;

-- 부서별 순위 구하기. --
SELECT DEPARTMENT_ID, RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC, COMMISSION_PCT DESC, DEPARTMENT_ID DESC) AS RANK,
FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES ORDER BY DEPARTMENT_ID, SALARY DESC, COMMISSION_PCT DESC;

-- ROWNUM 규칙. ? --
-- 2PAGE
-- start := ((num_page_no-1)*num_page_size)+1 # 출력 페이지 시작 행 ex) 11
-- end := (num_page_no* num_page_size) # 출력 페이지 ㅁ자ㅣ막 행 ex) 20
SELECT ROWNUM, E.*FROM EMPLOYEES E WHERE ROWNUM BETWEEN 11 AND 20;
SELECT ROWNUM, E.*FROM EMPLOYEES E;

-- 비추천.
SELECT RNUM, FIRST_NAME, SALARY, DEPARTMENT_ID FROM(SELECT ROWNUM AS RNUM, E.*FROM EMPLOYEES E)
WHERE RNUM BETWEEN 11 AND 20;

-- 추천.
                                                                        /*ORDER BY하지 않았으니 RNUM이 아닌 ROWNUM사용.*/
SELECT RNUM, FIRST_NAME, SALARY, DEPARTMENT_ID FROM(SELECT ROWNUM AS RNUM, E.*FROM EMPLOYEES E WHERE ROWNUM<=110)
WHERE RNUM >= 100;