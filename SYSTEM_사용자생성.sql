-- ����� ���� ����� (�ý��� �����ڰ� ������ ��忡�� �����ϴ� ��.) --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SHOPPINGMALL CASCADE; -- ���� ����� ����
CREATE USER SHOPPINGMALL IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS    -- ������ �����. --
    TEMPORARY TABLESPACE TEMP;  -- �ӽ� ���� ���. --
GRANT connect, resource, dba TO SHOPPINGMALL; -- ���� �ο�