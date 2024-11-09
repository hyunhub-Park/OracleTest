-- 생성자 Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   위치:        2024-11-08 17:02:30 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE buy (
    code           CHAR(2 CHAR) NOT NULL,
    amount         NUMBER(3) NOT NULL,
    total          NUMBER(8) NOT NULL,
    customer_code1 CHAR(2 CHAR) NOT NULL,
    product_code1  CHAR(2 CHAR) NOT NULL,
    company_code1  CHAR(2) NOT NULL
);

ALTER TABLE buy ADD CONSTRAINT buy_pk PRIMARY KEY ( code );
ALTER TABLE buy drop column customer_code;
ALTER TABLE buy drop column product_code;
ALTER TABLE buy drop column company_code;

ALTER TABLE buy rename column customer_code1 to customer_code;
ALTER TABLE buy rename column product_code1 to product_code;
ALTER TABLE buy rename column company_code1 to company_code;

select * from buy;


CREATE TABLE company (
    code  CHAR(2) NOT NULL,
    name  VARCHAR2(10 CHAR) NOT NULL,
    price NUMBER(7) NOT NULL
);

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( code );
ALTER TABLE company ADD CONSTRAINT company_uk UNIQUE ( name );

CREATE TABLE customer (
    code    CHAR(2 CHAR) NOT NULL,
    id      VARCHAR2(15 CHAR) NOT NULL,
    pwd     VARCHAR2(15) NOT NULL,
    name    VARCHAR2(6 CHAR) NOT NULL,
    address VARCHAR2(50 CHAR) NOT NULL,
    phone   CHAR(13 CHAR) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( code );
ALTER TABLE customer ADD CONSTRAINT customer_uk UNIQUE ( id );

CREATE TABLE product (
    code   CHAR(2 CHAR) NOT NULL,
    name   VARCHAR2(10 CHAR) NOT NULL,
    price  NUMBER(7) NOT NULL,
    remain NUMBER(3) NOT NULL
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( code );
ALTER TABLE product ADD CONSTRAINT ptoduct_uk UNIQUE ( name );

ALTER TABLE buy
    ADD CONSTRAINT buy_company_code_fk FOREIGN KEY ( company_code1 )
        REFERENCES company ( code )
            ON DELETE CASCADE;

ALTER TABLE buy
    ADD CONSTRAINT buy_customer_code_fk FOREIGN KEY ( customer_code1 )
        REFERENCES customer ( code )
            ON DELETE CASCADE;

ALTER TABLE buy
    ADD CONSTRAINT buy_product_code_fk FOREIGN KEY ( product_code1 )
        REFERENCES product ( code )
            ON DELETE CASCADE;
            



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
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
-- CREATE USER                              0
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
