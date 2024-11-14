-- PL/SQL --
-- ������ ȭ�鿡 ����ϱ�. --

-- DECLARE ���� ������ ���� ���� ���� ����� ��. --

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World ORACLE');

-- EXCEPTION --

END;

/

/* ���ϱ� ����. */
DECLARE
    NUM NUMBER(4);
    NUM NUMBER; -- �ڸ����� �������� �ʾƵ� ��. --
    -- NUM NUMBER := 20*40*60; --
    
BEGIN
    NUM:=100;   -- NUM�� �ʱⰪ 100 ����.
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

-- employee�� �̸�, �����ȣ�� ������ ���. --
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


-- employee�� �̸�, ����, �����ȣ�� ������ִ� ���α׷� �ۼ�. --
DECLARE
    -- �迭 Ÿ��.(���̺� Ÿ�� ����) --
    TYPE FIRST_NAME_ARRAY_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE JOB_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE EMPLOYEE_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE
    INDEX BY BINARY_INTEGER;
    
    -- �迭Ÿ�� ���� ����. --
    FIRST_NAME_ARRAY FIRST_NAME_ARRAY_TYPE;
    JOB_ID_ARRAY JOB_ID_ARRAY_TYPE;
    EMPLOYEE_ID_ARRAY EMPLOYEE_ID_ARRAY_TYPE;
    ROW_ARRAY EMPLOYEES%ROWTYPE;
    I BINARY_INTEGER := 0;  /* count�� ����ϴ�. ���� �ѹ� �ƴ� ���̳ʸ� ��Ƽ����. */
    J BINARY_INTEGER;

BEGIN
    -- ���� for��. RESULT SET���� �Ѱ��� ������ �� �÷��迭�� ������. --
    FOR ROW_ARRAY IN SELECT * FROM EMPLOYEES LOOP I := I+1;
    FIRST_NAME_ARRAY(I) := ROW_ARRAY.FIRST_NAME;
    
    JOB_ID_ARRAY(I) := ROW_ARRAY.JOB_ID;
    
    EMPLOYEE_ID_ARRAY(I) := ROW_ARRAY.EMPLOYEE_ID;
    
    END LOOP;
    -- ���� for���� �̿��� �÷� �迭���� ����� ���� ������ ���. --
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
      
    DBMS_OUTPUT.PUT_LINE('�� �����: '||VCOUNT);  
    DBMS_OUTPUT.PUT_LINE('�޿���: '||VSUM);
    DBMS_OUTPUT.PUT_LINE('�޿����: '||VAVG);
    
END;
/