-- INSERT INTO ���̺��(�÷���,) VALUES(�÷���,) --
-- ch 21 --
create table IT -- INSERT_TEST --
(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);

desc INSERT_TEST;   /* not null���� ������ �⺻�� null */
INSERT INTO INSERT_TEST VALUES(1, 2, 3);    /* �÷��� �������� ��, */ 
select * from INSERT_TEST;
RENAME INSERT_TEST TO IT;
desc it;

INSERT INTO IT VALUES(1, 2); -- ����. --
INSERT INTO IT VALUES(1, 2, NULL);
select * from it;
INSERT INTO IT(NO1, NO2) VALUES(11, 22);
select * from it;
INSERT INTO IT(NO1, NO2) VALUES(11, '����');  -- Ÿ�� �̽���ġ�� ����. --
INSERT INTO IT(NO1, NO2) VALUES(111);   --  ���� �̽���ġ�� ����. --
INSERT INTO IT(NO1, NO2) VALUES(111, 222, 333);   --  ���� �̽���ġ�� ����. --
INSERT INTO IT(NO1, NO2) VALUES(111, 2222); -- ���Ἲ ��������. ����. --
INSERT INTO IT VALUES(11111, NULL, 333);    -- ����� ���. --

-- NO3 NOT NULL �������� �ɱ�. --
alter table IT modify NO3 NUMBER not null;  /* null���� ���� �� �����ؾ� ��. */

/* NULL�� �� ���� �Ҵ��� �Ұ��ϴٴ� �� ���� �ʱ�. */
DELETE FROM IT WHERE NO3 IS NULL;   /* NULL���ֱ�. */

-- DEPT ���̺� ����. --
CREATE TABLE DEPT
AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM DEPARTMENTS;
-- INSERT INTO DEPT SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM DEPARTMENTS; --
select * from dept;
delete from dept;
ROLLBACK;
TRUNCATE TABLE DEPT;
select * from dept;
ROLLBACK;
select * from dept; /* �ѹ��� �Ϸ�ƴٰ�� ������ �˻���� ������ ����. */