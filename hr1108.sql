-- 1108 과제. --
/*uk나중에 따로 지정하기.*/
CREATE TABLE subject
(
    no NUMBER(5) NOT NULL,  -- 추후 시퀀스 사용 예정. --
    sub_num CHAR(3),    -- pk 학과번호. --
    name VARCHAR(10) NOT NULL
);

ALTER TABLE subject ADD CONSTRAINT subject_no_PK PRIMARY KEY(no);
ALTER TABLE subject DROP CONSTRAINT subject_no_PK;
ALTER TABLE subject ADD CONSTRAINT subject_sub_num_PK PRIMARY KEY(sub_num);

CREATE TABLE student
(
    no NUMBER(5) NOT NULL,   -- 추후 시퀀스 사용 예정. --
    stu_num CHAR(9),   -- pk 학번. --
    name VARCHAR2(10) NOT NULL,
    id VARCHAR2(10) NOT NULL,
    pwd VARCHAR2(20) NOT NULL,
    sub_num CHAR(3) NOT NULL,    -- fk 학과번호.--
    serial_num VARCHAR2(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(30) NOT NULL,
    email VARCHAR(25) NOT NULL,
    sign_date date NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_stu_num_PK PRIMARY KEY(stu_num);
ALTER TABLE student MODIFY sign_date default sysdate;
ALTER TABLE student ADD CONSTRAINT student_sub_num_FK FOREIGN KEY(sub_num)
        REFERENCES subject(sub_num) ON DELETE CASCADE;

CREATE TABLE lesson
(   /*pk로 설정할 부분이 없는데....*/
    no NUMBER(5) NOT NULL,
    lesson_num CHAR(2) NOT NULL,   --pk(trainee테이블에서 외래키로 사용돼야 함. inner join--
    name VARCHAR2(10) NOT NULL --check, inner join--
);

ALTER TABLE lesson ADD CONSTRAINT lesson_lesson_num_PK PRIMARY KEY(lesson_num);

CREATE TABLE trainee
(   /*pk로 설정할 부분이 없는데....*/
    no NUMBER(5) NOT NULL,
    stu_num CHAR(9),    --fk--
    lesson_num CHAR(2) NOT NULL, --fk--
    section CHAR(10) NOT NULL,  --check, inner join--
    sign_date date NOT NULL
);

ALTER TABLE trainee MODIFY sign_date default sysdate;
ALTER TABLE trainee ADD CONSTRAINT trainee_stu_num_FK FOREIGN KEY(stu_num)
            REFERENCES student(stu_num) ON DELETE CASCADE;
ALTER TABLE trainee ADD CONSTRAINT trainee_lesson_num_FK FOREIGN KEY(lesson_num)
            REFERENCES lesson(lesson_num) ON DELETE CASCADE;
            

/*SELECT * FROM lesson INNER JOIN trainee ON lesson.lesson_num=trainee.lesson_num;
SELECT T.lesson_num, L.lesson_num, 
    case
            when lesson.lesson_num = 'K' then section='culture'
            when lesson.lesson_num = 'M' then section='culture'
            when lesson.lesson_num = 'E' then section='culture'
            when lesson.lesson_num = 'H' then section='culture'
            when lesson.lesson_num = 'P' then section='major'
            when lesson.lesson_num = 'D' then section='major'
            when lesson.lesson_num = 'ED' then section='major'
            when lesson.lesson_num = 'etc' then section='minor'
            END TRAINEE_SECTION
FROM trainee T inner join lesson L on L.lesson_num=T.lesson_num
WHERE T.lesson_num in ('K', 'M', 'E', 'H', 'P', 'D', 'ED', 'etc')
ORDER BY TRAINEE_SECTION;*/