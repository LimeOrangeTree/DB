*CONSTRAINT(제약조건)(교재  p332)
- Primary Key : 기본키 . nn+uk=>테이블성격
- Not Null : null값 허용x
- Unique   : 유일한 값 . 중복값 허용x
- Foreign Key : 외래키. null허용, 중복값허용
- Check : 조건

*제약조건 조회
SELECT     constraint_name,  constraint_type, table_name
FROM        USER_CONSTRAINTS
WHERE     table_name='EMP2'; -- 주의:테이블명은 대문자




conn hr/hr
--컬럼추가
형식>ALTER  TABLE 테이블명
ADD 컬럼명 데이터타입(크기); 

--제약조건추가(교재 P338 참고)/ 삭제 / 변경
형식>ALTER  TABLE 테이블명
-ADD     [CONSTRAINT 제약조건명]    제약조건(컬럼명);
-DROP   CONSTRAINT 제약조건명
-MODIFY  [CONSTRAINT 제약조건명]    제약조건(컬럼명)


--emp2테이블에서 ename컬럼의 nn제약조건 넣기(교재 P339 참고)
ALTER TABLE EMP2
MODIFY    ename CONSTRAINT   EMP2_ENAME_NN  NOT NULL;

--DROP  CONSTRAINT EMP2_ENAME_NN;

--emp2테이블에서 PK삭제
ALTER TABLE EMP2
DROP PRIMARY KEY;

--emp2테이블의 sal컬럼의 check제약조건 삭제
ALTER TABLE EMP2
DROP  CONSTRAINT EMP2_SAL_CK;

-- emp2테이블의 ssn컬럼에  unique제약조건을 추가
ALTER  TABLE emp2
ADD      CONSTRAINT emp2_ssn_uk     unique(ssn);

형식> CREATE   TABLE  테이블명(
    컬럼명     데이터타입(크기)  [CONSTRAINT 제약조건명] [제약조건]
);

--데이터입력
INSERT INTO  emp2    VALUES(  1, '홍길동' ,    100,  '청소',    '801123-1234567', '2015/06/20', '구로');
INSERT INTO  emp2    VALUES(  2, '제갈공명' , 100,  '디자인', '751123-2234567', '2019/02/26', '강남');
INSERT INTO  emp2    VALUES(  3, '박보검' ,    500,  '개발',    '911101-1234567', SYSDATE, null);
COMMIT;

--제약조건이 있는 사원 테이블생성

DROP TABLE DEPT;
CREATE TABLE   DEPT(
 dno            number(5)    CONSTRAINT  dept_dno_pk  Primary Key,
 dname      varchar2(20),
 loc            varchar2(50)
);

DROP       TABLE EMP2;
CREATE   TABLE  emp2(
    eno            number(5)        CONSTRAINT emp2_eno_pk         primary key,       /*사원번호*/
    ename       varchar2(50)     CONSTRAINT emp2_ename_nn   not null,               /*사원명*/
    sal             number(10)       default(50)  CONSTRAINT emp2_sal_ck          check( sal>=0  )  ,    /*급여*/
    job             varchar2(50)     CONSTRAINT emp2_job_ck          check(  job  in('청소','디자인','개발','영업')  ),  /*업무*/
    ssn             char(14)           CONSTRAINT emp2_ssn_nn         not null
                                               CONSTRAINT emp2_ssn_uk         unique,        /*주민번호*/
    hiredate     date                default SYSDATE   ,              /*입사일*/
    address     varchar2(100),  /*주소*/
    dno            number(5)
);

-- DEPT테이블 데이터입력
INSERT INTO   DEPT  VALUES( 10, '개발부', '서울' );
INSERT INTO   DEPT  VALUES( 20, '디자인부', '제주' );
INSERT INTO   DEPT  VALUES( 30, '최강개발부', '울산' );

--  EMP2테이블 데이터입력
-- 제약조건 위배X      SAL과 HIREDATE컬럼의 값은 묵시적NULL
INSERT INTO   EMP2(eno, ename, job, ssn, address,dno )
VALUES(1, '홍길동',  '개발', '801123-1234567', '구로', 10 );

INSERT INTO   EMP2(eno, ename, job, ssn, address,dno )
VALUES(2, '이길동',  '개발', '900525-2234567', '연평도', NULL );

- 부서테이블에서 10번 부서삭제
DELETE FROM  DEPT     WHERE   DNO=10;

- 10번 부서를 11으로 바꿔
UPDATE DEPT
SET        dno=11
WHERE  dno=10;

--부서번호 30번 근무자 퇴사
DELETE FROM EMP2   WHERE   DNO=30;

--이길동의 부서번호를 50으로 수정
UPDATE EMP2
SET        dno=50
WHERE  ename='이길동';

integrity constraint (HR.EMP2_DNO_FK) violated - parent key not found
                              

emp2의 dno컬럼은   DEPT테이블의 dno를 참조하는  fk
ALTER TABLE emp2
ADD   CONSTRAINT emp2_dno_fk    foreign key(dno)  references DEPT(dno);

* ON DELETE CASCADE 옵션 주의사항
  : 참조하는 부모키값이 존재해야 한다.
ALTER TABLE emp2
ADD   CONSTRAINT emp2_dno_fk    foreign key(dno)  references DEPT(dno) ON DELETE CASCADE;

-- 부서테이블에서 10번부서 삭제
DELETE FROM  DEPT    WHERE   DNO=10;

*서로 연관된 테이블간의 DML 작업시 주의사항
            DEPT(부모)   /  EMP(자식)
부서번호       pk        -   fk     
입력             O        /   부모키값 존재여부
수정       자식레코드 존재여부 /  부모키값 존재여부
삭제       자식레코드 존재여부 / O




-- 제약조건이 없는 테이블생성
CREATE   TABLE  emp(
    eno            number(5),       /*사원번호*/
    ename       varchar2(50),    /*사원명*/
    sal             number(10),     /*급여*/
    job             varchar2(50),   /*업무*/
    ssn             char(14),        /*주민번호*/
    hiredate     date,              /*입사일*/
    address     varchar2(100)  /*주소*/
);





*테이블삭제
DROP    TABLE  테이블명 [CASCADE CONSTRAINT];

* unique/primary keys in table referenced by foreign keys이면  테이블삭제불가하다
  하지만 강제로 참조관계(FK)를 제거하면 삭제가 가능하다
  CASCADE CONSTRAINT는  참조관계를 제거하면서   부모테이블을 삭제하는 옵션.
DROP      TABLE DEPT   CASCADE CONSTRAINT;






