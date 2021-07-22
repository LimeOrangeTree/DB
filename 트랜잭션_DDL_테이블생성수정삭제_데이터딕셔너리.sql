*DATA DICIONARY(데이터 딕셔너리)- 교재 P287
* 오라클 데이터베이스의 메모리 구조와 파일에 대한 구조 정보들
 * 각 오브젝트들이 사용하고 있는 공간들의 정보들
 * 제약 조건 정보들
 * 사용자에 대한 정보들
 * 권한이나 프로파일 , 롤에 대한 정보들
 * 감사(Audit) 에 대한 정보들
 
 *데이터 딕셔너리 종류- 교재 P288
 1)DBA_ : DBA권한을 가진 유저가 사용
 2)ALL_ : 누구든 사용
 3)USER_ :일반 유저가 사용

CONN SCOTT/tiger
show user
SELECT * FROM USER_CONSTRAINTS;

CONN  /AS SYSDBA
SHOW USER
SELECT USERNAME    FROM    DBA_USERS;

*DDL : 객체조작
=> 생성(CREATE) / 변경(ALTER) /삭제(DROP)
=> AUTO COMMIT된다


*TABLE생성(교재 p267)
CREATE TALBE 테이블명(
    컬럼명     데이터타입(크기),
    컬럼명     데이터타입(크기),
    ..
    컬럼명     데이터타입(크기)
);


*TABLE복사생성(교재 p273)
CREATE TALBE   복사본테이블명
AS 
SELECT * FROM  원본테이블명;

-- emp 테이블에서 부서별 부서번호,  총급여, 평균급여, 인원수
    emp_sal 테이블생성하세요
    이 때 부서번호 확정,  부서번호 오름
문제발생=>> must name this expression with a column alias 
해결방법=>> 컬럼에 별칭을 부여하면 된다
SELECT * FROM emp_sal;

-- 하나의 계정에서 동일한 이름을 가진 객체(object)는 존재할 수 없다
   예) scott 계정에는 emp 테이블이 존재하면  동일한 이름으로 테이블을 생성할 수 없다

-- 테이블변경(교재 P274)
형식> ALTER  TABLE 테이블명
--추가 ADD
--수정 MODIFY
--삭제 DROP

참고 테이블명 변경
형식> RENAME  old테이블명 TO new테이블명;
--emp_hire를 emp_hiredate로 테이블명 변경
RENAME  emp_hire TO emp_hiredate;

참고  컬럼명 변경(교재 p277)
형식> ALTER  TABLE 테이블명
         RENAME COLUMN  old컬럼명  TO  new컬럼명;

--emp_hire 테이블의 sal컬럼명을 bigo컬럼명으로 이름변경
ALTER  TABLE emp_hire
RENAME COLUMN  sal  TO  bigo;

*테이블 수정
-- 컬럼 추가  테이블 변경(교재 p275)
-- 주의) 추가되는 컬럼은 가장 마지막에 추가
--          기존 데이터가 있다면 추가되는 컬럼의 값은 null
형식>ALTER  TABLE 테이블명
ADD 컬럼명 데이터타입(크기);

-- 추가한 sal컬럼의 데이터타입과 크기변경(교재 p277)
-- 주의) 데이터가 존재하는 컬럼에 변경을 가할 때는 데이터타입과 크기 주의
ALTER  TABLE emp_hire
MODIFY  sal  varchar2(30);

--  emp_hire테이블명   EMPNO, NAME, HIREDATE에   컬럼 sal추가
ALTER  TABLE emp_hire
ADD sal  number(10);

select * from emp_hire;

참고 delete, trucate, drop 명령어의 차이비교(교재 p279)

참고  테이블 TRUNCATE(교재 p278)
형식> TRUNCATE TABLE  테이블명;

-- emp_hiredate 테이블을 truncate후 확인
TRUNCATE TABLE  emp_hiredate;
rollback; -- x

-- emp_sal           테이블을 drop후       확인
DROP TABLE  emp_sal;
rollback; -- x

-- 테이블삭제(교재 P279)
형식> DROP TABLE  테이블명;

DROP TABLE emp_sal;

SELECT * FROM emp_sal;

CREATE TABLE  emp_sal
AS
SELECT E.deptno,  D.dname ,sum(E.SAL) as totalSal,  round(avg(E.SAL),0) as avgSal, count(*) as CNT
FROM    EMP E     JOIN     DEPT D    ON    E.deptno=D.deptno
WHERE  E.deptno is not null
GROUP  BY  E.deptno,  D.dname 
ORDER  BY  E.deptno asc;

-- emp 테이블에서 empno, ename, hiredate를 가져와 
    emp_hire 테이블생성하세요
    이 때 사원번호 9000미만 사원으로 제한
    이 때 hiredate는 최근입사한 사원부터 보이도록 합니다

SELECT * FROM emp_hire;

CREATE TABLE emp_hire
AS
SELECT empno, ename, hiredate
FROM    EMP
WHERE empno<9000
ORDER BY  hiredate DESC;


-- emp 테이블의 구조(모든컬럼, 컬럼명, 타입, 크기, 데이터 복사 )
CREATE TABLE   EMP_ALL
AS 
SELECT * FROM  EMP;





==================================================================
*TRANSCATION
=> DML의 연속적인 집합

*TRANSCATION조작어
-COMMIT : 하나의 트랜잭션을 반영
-ROLLBACK : 하나의 트랜잭션을 취소
  ROLLBACK TO 저장점;
-SAVEPOINT : 저장점
 형식>  SAVEPOINT 포인터명;

--SELECT
SELECT EMPNO, ENAME, JOB
FROM    EMP;

-----INSERT
INSERT   INTO  EMP(EMPNO, ENAME, JOB)
VALUES( 9001,  '홍1',  '사원1' );
COMMIT;------------------------------------TR 끝 / TR시작

--SELECT
SELECT EMPNO, ENAME, JOB
FROM    EMP;

--UPDATE
UPDATE EMP
SET        ENAME='호호';
ROLLBACK;------------------------------------TR 끝 / TR시작
COMMIT;------------------------------------TR 끝 / TR시작
SELECT EMPNO, ENAME, JOB   FROM    EMP; ====================>1번
--INSERT
INSERT INTO EMP(EMPNO,ENAME,JOB) VALUES(9002,'홍2', '사원2');
INSERT INTO EMP(EMPNO,ENAME)        VALUES(9003,'홍3');
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT  S1;=============================================>2번~~~~~~~~~

--UPDATE
UPDATE EMP    SET JOB='사원33'     WHERE  ENAME='홍3';
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT S2;=============================================>3번

--DELETE
DELETE FROM  EMP                          WHERE  ENAME='홍2';
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT S3;=============================================>4번

ROLLBACK TO S1;
SELECT EMPNO, ENAME, JOB   FROM    EMP;
ROLLBACK TO S2;



*DML : 데이터조작언어

*INSERT문법
INSERT INTO  테이블명[(컬럼명,...)]
VALUES(값,..);

*UPDATE문법
UPDATE  테이블명
SET          컬럼명=새값,.. 컬럼명=새값
[WHERE  조건];


*DELETE문법
DELETE  [FROM]   테이블명
[WHERE  조건];



*ROWID와 INDEX(교재 p336)
 : ROWID 는 오라클 나라의 주소 표현 방법이고 
 모든 데이터는 고유한 ROWID 를 가지고 있어서 
 그 데이터를 찾아 가려면 ROWID 를 알아야 하고 
 ROWID 정보를 모아서 가지고 있는 것이 INDEX 다
 
 SELECT ROWNUM, ROWID, ENAME
 FROM  EMP;