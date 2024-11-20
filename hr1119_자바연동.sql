-- employees
SELECT * FROM EMPLOYEES;

DESC EMPLOYEES;

-- books
CREATE TABLE books
(
    id number(4),
    title varchar2(50),
    publisher varchar2(30),
    year varchar2(10),
    price number(6)
);

select * from books;
drop table books;
desc books;

ALTER TABLe BOOKS ADD CONSTRAINT BOOKS_ID_PK PRIMARY KEY(ID);

CREATE SEQUENCE BOOKS_ID_SEQ
START WITH 1
INCREMENT BY 1;


INSERT INTO books VALUES (books_id_seq.nextval, 'Operating System Concepts', 'Wiley', '2003', 30700);
INSERT INTO books VALUES (books_id_seq.nextval, 'Head First PHP and MYSQL', 'OReilly', '2009', 58000);
INSERT INTO books VALUES (books_id_seq.nextval, 'C Programming Language', 'Prentice-Hall', '1989', 35000);
INSERT INTO books VALUES (books_id_seq.nextval, 'Head First SQL', 'OReilly', '2007', 43000);
commit;

SELECT * FROM BOOKS;

DELETE FROM BOOKS WHERE ID=5;

ROLLBACK;

UPDATE BOOKS SET TITLE='kkk', PUBLISHER='JAVA', YEAR='2024', PRICE=33000 WHERE ID=3;
commit;


-- Movie

CREATE TABLE MOVIE
(
    ID number(4),
    TITLE varchar2(20),
    DIRECTOR varchar2(30),
    YEAR varchar2(10),
    PRICE number(6)
);

select * from movie;

ALTER TABLE MOVIE ADD CONSTRAINT MOVIE_ID_PK PRIMARY KEY(ID);

/* 이거 왜주는거지? */
CREATE SEQUENCE MOVIE_ID_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO MOVIE VALUES (MOVIE_ID_SEQ.nextval, 'Movie ABC', 'Director ABC', '2024', 12000);
INSERT INTO MOVIE VALUES (MOVIE_ID_SEQ.nextval, 'Movie DEF', 'Director DEF', '2023', 12000);
INSERT INTO MOVIE VALUES (MOVIE_ID_SEQ.nextval, 'Movie GHI', 'Director GHI', '2022', 15000);
INSERT INTO MOVIE VALUES (MOVIE_ID_SEQ.nextval, 'Movie JKL', 'Director JKL', '2022', 10000);
COMMIT;

UPDATE MOVIE SET TITLE='kkk', DIRECTOR='JAVA', YEAR='2024', PRICE=33000 WHERE ID=3;
commit;

desc MOVIE;
SELECT * FROM MOVIE;