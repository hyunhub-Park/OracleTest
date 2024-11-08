-- 생성자 Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   위치:        2024-11-08 12:32:33 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



CREATE USER hr 
    IDENTIFIED BY  
    DEFAULT TABLESPACE USERS 
    QUOTA UNLIMITED ON USERS 
    ACCOUNT UNLOCK 
;

GRANT UNLIMITED TABLESPACE,
    ALTER SESSION,
    CREATE SESSION,
    CREATE SYNONYM,
    CREATE DATABASE LINK,
    CREATE SEQUENCE, CREATE VIEW TO HR 
;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE hr.lesson (
    no         NUMBER(5) NOT NULL,
    lesson_num CHAR(2 BYTE) NOT NULL,
    name       VARCHAR2(10 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hr.lesson_lesson_num_pk ON
    hr.lesson (
        lesson_num
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hr.lesson
    ADD CONSTRAINT lesson_lesson_num_pk PRIMARY KEY ( lesson_num )
        USING INDEX hr.lesson_lesson_num_pk;

CREATE TABLE hr.student (
    no         NUMBER(5) NOT NULL,
    stu_num    CHAR(9 BYTE) NOT NULL,
    name       VARCHAR2(10 BYTE) NOT NULL,
    id         VARCHAR2(10 BYTE) NOT NULL,
    pwd        VARCHAR2(20 BYTE) NOT NULL,
    sub_num    CHAR(3 BYTE) NOT NULL,
    serial_num VARCHAR2(20 BYTE) NOT NULL,
    phone      VARCHAR2(20 BYTE) NOT NULL,
    address    VARCHAR2(30 BYTE) NOT NULL,
    email      VARCHAR2(25 BYTE) NOT NULL,
    sign_date  DATE DEFAULT sysdate NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hr.student_stu_num_pk ON
    hr.student (
        stu_num
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hr.student
    ADD CONSTRAINT student_stu_num_pk PRIMARY KEY ( stu_num )
        USING INDEX hr.student_stu_num_pk;

CREATE TABLE hr.subject (
    no      NUMBER(5) NOT NULL,
    sub_num CHAR(3 BYTE) NOT NULL,
    name    VARCHAR2(10 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hr.subject_sub_num_pk ON
    hr.subject (
        sub_num
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hr.subject
    ADD CONSTRAINT subject_sub_num_pk PRIMARY KEY ( sub_num )
        USING INDEX hr.subject_sub_num_pk;

ALTER TABLE hr.student
    ADD CONSTRAINT student_sub_num_fk FOREIGN KEY ( sub_num )
        REFERENCES hr.subject ( sub_num )
            ON DELETE CASCADE
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             3
-- CREATE INDEX                             3
-- ALTER TABLE                              4
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
