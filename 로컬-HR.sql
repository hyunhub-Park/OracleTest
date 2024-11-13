-- 테이블 설계하기.(사원번호, 사원명, 급여) --
/*class EMP01
{
    private가 아닌 public!
    private int no;
    private String name;
    private double salary;
}*/

-- get/set -> update, toString -> select, 추가 -> alter, 변경 -> alter의 modify, 삭제 -> alter의 drop. --
    -- 38자 사용 가능. 때문에 값 지정해주기.--
   /* no NUMBER(4) not null primary key,
    name VARCHAR2(20) not null unique,
    salary NUMBER(10, 2) not null*/
    
    --no NUMBER(4),CONSTRAINT emp01_no_nn not null,--
    --name VARCHAR2(20) default 'abc',--
    --salary NUMBER(10, 2),--
        --CONSTRAINT EMP01_NO_PK primary key(no),--
 create table EMP01
 (
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10, 2) default 1000.0,
    CONSTRAINT EMP01_PK primary key(no, name),
    CONSTRAINT emp01_salary_uk unique(salary)
 );
 
