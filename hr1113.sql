-- Ʈ�����. --

drop table dep02;

-- ���̺� ����.(������) --
CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;

/* not null�� ����. */
SELECT * FROM user_constraints where table_name='dep02'; --> ��������� Ŀ����.

-- ���� ����. --
INSERT INTO dep02 SELECT * FROM departments;

select * from dep02;

ROLLBACK; -- 13�����. --

DELETE FROM dep02;

ROLLBACK; --> �׻� Ŀ�� �������� ���ư�. 13��.