-- 트랜잭션. --

drop table dep02;

-- 테이블 복사.(구조만) --
CREATE TABLE DEP02
AS
SELECT * FROM departments WHERE 1=0;

DESC dep02;

/* not null만 복사. */
SELECT * FROM user_constraints where table_name='dep02'; --> 여기까지가 커밋임.

-- 내용 복사. --
INSERT INTO dep02 SELECT * FROM departments;

select * from dep02;

ROLLBACK; -- 13행까지. --

DELETE FROM dep02;

ROLLBACK; --> 항상 커밋 기준으로 돌아감. 13행.