-- ���̺� �����ϱ�.(�����ȣ, �����, �޿�) --
/*class EMP01
{
    private�� �ƴ� public!
    private int no;
    private String name;
    private double salary;
}*/

-- get/set -> update, toString -> select, �߰� -> alter, ���� -> alter�� modify, ���� -> alter�� drop. --
    -- 38�� ��� ����. ������ �� �������ֱ�.--
   /* no NUMBER(4) not null primary key,
    name VARCHAR2(20) not null unique,
    salary NUMBER(10, 2) not null*/
    
    --no NUMBER(4),CONSTRAINT emp01_no_nn not null,--
    --name VARCHAR2(20) default 'abc',--
    --salary NUMBER(10, 2),--
        --CONSTRAINT EMP01_NO_PK primary key(no),--
 create table EMP01
 (
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_PK primary key(no, name),
    CONSTRAINT emp01_salary_uk unique(salary)
 );
 
