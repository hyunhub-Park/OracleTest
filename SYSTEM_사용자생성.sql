-- ����� ���� ����� (�ý��� �����ڰ� ������ ��忡�� �����ϴ� ��.) --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER STUDENTDB CASCADE; -- ���� ����� ����
CREATE USER STUDENTDB IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO STUDENTDB; -- ���� �ο�