-- ����ڰ� ������ TABLE SPACE �����. --
create TABLESPACE firstdata
DATAFILE 'D:\app\user\oradata\ORCL\first01.dbf' size 10M;

-- TABLE SPACE Ȯ���ϱ�. --
alter TABLESPACE firstdata
add DATAFILE 'D:\app\user\oradata\ORCL\first02.dbf' size 1M;

-- TABLE SPACE ��ü �뷮 �ø���. --
alter database
DATAFILE 'D:\app\user\oradata\ORCL\first02.dbf' resize 10M;

-- �ڵ����� 1M�� Ȯ�� �� �ִ� 20M���� Ȯ�� �����ϵ��� ����. --
alter DATABASE
DATAFILE 'D:\app\user\oradata\ORCL\first01.dbf'
AUTOEXTEND ON
NEXT 1M -- 1M�� Ȯ��. --
MAXSIZE 20M;

-- �ڹ� ������Ʈ�� ���� ����� ���� �� TABLE SPACE(javadata), ���ϸ�(app_data.dbf) ����. --
CREATE TABLESPACE javadata
DATAFILE 'D:\app\user\oradata\ORCL\app_data.dbf' size 20M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 500M;

-- �ڹ� ������Ʈ�� ���� ����� ���� ����. --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER JAVAUSER CASCADE; -- ���� ����� ����
CREATE USER JAVAUSER IDENTIFIED BY 123456 -- ����� �̸�: Model, ��й�ȣ : 1234
    DEFAULT TABLESPACE javadata    -- ������ �����. --
    TEMPORARY TABLESPACE TEMP;  -- �ӽ� ���� ���. --
GRANT connect, resource, dba TO JAVAUSER; -- ���� �ο�

