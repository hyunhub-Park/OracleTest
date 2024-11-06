-- INSERT INTO 테이블명(컬럼명,) VALUES(컬럼값,) --
-- ch 21 --
create table IT -- INSERT_TEST --
(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);

desc INSERT_TEST;   /* not null주지 않으면 기본이 null */
INSERT INTO INSERT_TEST VALUES(1, 2, 3);    /* 컬럼명 안적었을 시, */ 
select * from INSERT_TEST;
RENAME INSERT_TEST TO IT;
desc it;

INSERT INTO IT VALUES(1, 2); -- 오류. --
INSERT INTO IT VALUES(1, 2, NULL);
select * from it;
INSERT INTO IT(NO1, NO2) VALUES(11, 22);
select * from it;
INSERT INTO IT(NO1, NO2) VALUES(11, '문자');  -- 타입 미스매치로 오류. --
INSERT INTO IT(NO1, NO2) VALUES(111);   --  개수 미스매치로 오류. --
INSERT INTO IT(NO1, NO2) VALUES(111, 222, 333);   --  개수 미스매치로 오류. --
INSERT INTO IT(NO1, NO2) VALUES(111, 2222); -- 무결성 제약조건. 오류. --
INSERT INTO IT VALUES(11111, NULL, 333);    -- 명시적 방법. --

-- NO3 NOT NULL 제약조건 걸기. --
alter table IT modify NO3 NUMBER not null;  /* null값을 없앤 뒤 적용해야 함. */

/* NULL은 비교 연산 할당이 불가하다는 점 잊지 않기. */
DELETE FROM IT WHERE NO3 IS NULL;   /* NULL없애기. */

-- DEPT 테이블 생성. --
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
select * from dept; /* 롤백이 완료됐다고는 뜨지만 검색결과 나오지 않음. */