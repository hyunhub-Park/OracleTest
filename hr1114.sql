-- PL/SQL --
-- 내용을 화면에 출력하기. --

-- DECLARE 변수 선언할 것이 없을 때는 지우면 됨. --

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World ORACLE');

-- EXCEPTION --

END;

/

/* 곱하기 연산. */
DECLARE
    NUM NUMBER(4);
    NUM NUMBER; -- 자리수를 지정하지 않아도 됨. --
    -- NUM NUMBER := 20*40*60; --
    
BEGIN
    NUM:=100;   -- NUM에 초기값 100 대입.
    DBMS_OUTPUT.PUT_LINE(NUM);
    DBMS_OUTPUT.PUT_LINE('NUM = '||NUM);

-- EXCEPTION

END;

/

/* VARCHAR2 */
DECLARE
    PHONE_NUM VARCHAR2(13);
    NAME VARCHAR2(10);
BEGIN
    PHONE_NUM := '010-0000-0000';
    NAME := 'PSH';
    DBMS_OUTPUT.PUT_LINE('PHONE_NUM : '||PHONE_NUM);
    DBMS_OUTPUT.PUT_LINE('NAME : '||NAME);

-- EXCEPTION

END;

/

VEMPNO EMPLOYEES.EMPLOYEE_ID%NUMBER;

desc employees;

-- employee의 이름, 사원번호를 가져와 출력. --
DECLARE
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;

BEGIN
    SELECT first_name, employee_id INTO VFIRST_NAME, VEMPLOYEE_ID
    FROM employees WHERE first_name='Ellen';
    
    DBMS_OUTPUT.PUT_LINE('first_name = '||VFIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('employee_id = '||VEMPLOYEE_ID);
--EXCEPTION

END;

/

SELECT first_name, employee_id FROM employees WHERE first_name='Ellen';


-- employee의 이름, 직업, 사원번호를 출력해주는 프로그램 작성. --
DECLARE
    -- 배열 타입.(테이블 타입 정의) --
    TYPE FIRST_NAME_ARRAY_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE JOB_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE EMPLOYEE_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE
    INDEX BY BINARY_INTEGER;
    
    -- 배열타입 변수 선언. --
    FIRST_NAME_ARRAY FIRST_NAME_ARRAY_TYPE;
    JOB_ID_ARRAY JOB_ID_ARRAY_TYPE;
    EMPLOYEE_ID_ARRAY EMPLOYEE_ID_ARRAY_TYPE;
    ROW_ARRAY EMPLOYEES%ROWTYPE;
    I BINARY_INTEGER := 0;  /* count를 사용하는. 따라서 넘버 아닌 바이너리 인티저로. */
    J BINARY_INTEGER;

BEGIN
    -- 향상된 for문. RESULT SET값을 한개씩 가져와 각 컬럼배열에 저장함. --
    FOR ROW_ARRAY IN SELECT * FROM EMPLOYEES LOOP I := I+1;
    FIRST_NAME_ARRAY(I) := ROW_ARRAY.FIRST_NAME;
    
    JOB_ID_ARRAY(I) := ROW_ARRAY.JOB_ID;
    
    EMPLOYEE_ID_ARRAY(I) := ROW_ARRAY.EMPLOYEE_ID;
    
    END LOOP;
    -- 향상된 for문을 이용해 컬럼 배열값에 저장된 값을 가져와 출력. --
    FOR J IN 1..I LOOP
    DBMS_OUTPUT.PUT_LINE(FIRST_NAME_ARRAY(I)||'  /  '||JOB_ID_ARRAY(I)||'  /  '||EMPLOYEE_ID_ARRAY(I));
    
    END LOOP;
    
    
-- EXCEPTION

END;

/



DECLARE
    VCOUNT NUMBER;
    VSUM NUMBER;
    VAVG NUMBER(10,2);
BEGIN
    SELECT COUNT(*),SUM(SALARY),AVG(SALARY)
    INTO VCOUNT,VSUM,VAVG
    FROM EMPLOYEES;
      
    DBMS_OUTPUT.PUT_LINE('총 사원수: '||VCOUNT);  
    DBMS_OUTPUT.PUT_LINE('급여합: '||VSUM);
    DBMS_OUTPUT.PUT_LINE('급여평균: '||VAVG);
    
END;
/