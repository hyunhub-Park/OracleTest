-- 사용자가 정의한 TABLE SPACE 만들기. --
create TABLESPACE firstdata
DATAFILE 'D:\app\user\oradata\ORCL\first01.dbf' size 10M;

-- TABLE SPACE 확장하기. --
alter TABLESPACE firstdata
add DATAFILE 'D:\app\user\oradata\ORCL\first02.dbf' size 1M;

-- TABLE SPACE 자체 용량 늘리기. --
alter database
DATAFILE 'D:\app\user\oradata\ORCL\first02.dbf' resize 10M;

-- 자동으로 1M씩 확장 및 최대 20M까지 확장 가능하도록 설정. --
alter DATABASE
DATAFILE 'D:\app\user\oradata\ORCL\first01.dbf'
AUTOEXTEND ON
NEXT 1M -- 1M씩 확장. --
MAXSIZE 20M;

-- 자바 프로젝트를 위한 사용자 계정 및 TABLE SPACE(javadata), 파일명(app_data.dbf) 생성. --
CREATE TABLESPACE javadata
DATAFILE 'D:\app\user\oradata\ORCL\app_data.dbf' size 20M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 500M;

-- 자바 프로젝트를 위한 사용자 계정 생성. --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER JAVAUSER CASCADE; -- 기존 사용자 삭제
CREATE USER JAVAUSER IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE javadata    -- 데이터 저장소. --
    TEMPORARY TABLESPACE TEMP;  -- 임시 저장 장소. --
GRANT connect, resource, dba TO JAVAUSER; -- 권한 부여

