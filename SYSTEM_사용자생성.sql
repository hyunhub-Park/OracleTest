-- ����� ���� ����� (�ý��� �����ڰ� ������ ��忡�� �����ϴ� ��.) --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SHOPPINGMALL CASCADE; -- ���� ����� ����
CREATE USER SHOPPINGMALL IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS    -- ������ �����. --
    TEMPORARY TABLESPACE TEMP;  -- �ӽ� ���� ���. --
GRANT connect, resource, dba TO SHOPPINGMALL; -- ���� �ο�

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SUBJECTDB CASCADE; -- ���� ����� ����
CREATE USER SUBJECTDB IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS    -- ������ �����. --
    TEMPORARY TABLESPACE TEMP;  -- �ӽ� ���� ���. --
GRANT connect, resource, dba TO SUBJECTDB; -- ���� �ο�

--------------------- CAFE DB ---------------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER CAFEDB CASCADE; -- ���� ����� ����
CREATE USER CAFEDB IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS    -- ������ �����. --
    TEMPORARY TABLESPACE TEMP;  -- �ӽ� ���� ���. --
GRANT connect, resource, dba TO CAFEDB; -- ���� �ο�