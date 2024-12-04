-- 사용자 계정 만들기 (시스템 관리자가 관리자 모드에서 진행하는 것.) --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SHOPPINGMALL CASCADE; -- 기존 사용자 삭제
CREATE USER SHOPPINGMALL IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO SHOPPINGMALL; -- 권한 부여

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER SUBJECTDB CASCADE; -- 기존 사용자 삭제
CREATE USER SUBJECTDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO SUBJECTDB; -- 권한 부여

--------------------- CAFE DB ---------------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER CAFEDB CASCADE; -- 기존 사용자 삭제
CREATE USER CAFEDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO CAFEDB; -- 권한 부여

--------------------- TEAMPROJECT_02 ---------------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER TEAMPROJECT_02 CASCADE; -- 기존 사용자 삭제
CREATE USER TEAMPROJECT_02 IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO TEAMPROJECT_02; -- 권한 부여


--------------------- 웹 프로젝트 사용자계정 생성하기. ---------------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER webuser CASCADE; -- 기존 사용자 삭제
CREATE USER webuser IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO webuser; -- 권한 부여
