-- 사용자 계정 만들기 (시스템 관리자가 관리자 모드에서 진행하는 것.) --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER STUDENTDB CASCADE; -- 기존 사용자 삭제
CREATE USER STUDENTDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO STUDENTDB; -- 권한 부여