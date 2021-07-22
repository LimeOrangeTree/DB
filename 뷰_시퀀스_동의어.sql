*SYNONYM(동의어 교재 P490)
 hr.emp
 hr.employees
 USER명.시퀀스명
 hr.employees_department_view

*SEQUENCE(교재 P482) 
=> 일정 증감규칙이 있는 연속적인 일련번호

시퀀스명.NEXTVAL : 다음값
시퀀스명.CURRVAL:  현재값

INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_1' );--1
INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_2' );--2
SELECT   EMPNO,ENAME  FROM EMP  ORDER BY EMPNO ASC;  -- 1, 2
INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_4' ); --4
SELECT   EMPNO,ENAME  FROM EMP  ORDER BY EMPNO ASC;

INSERT INTO   DEPT(DEPTNO,  DNAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_3' );--3
SELECT * FROM DEPT;  

1) 생성
CREATE SEQUENCE emp_seq
 INCREMENT BY 3
 --START WITH 100
 MAXVALUE 9999
 NOCYCLE;


CREATE  OR  REPLACE    SEQUENCE sequence_name 
 [INCREMENT BY n] <- 시퀀스 번호의 증가 값으로 기본값은 1
 [START WITH n] <- 시퀀스 시작번호로 기본값은 1
 [MAXVALUE n | NOMAXVALUE] <- 생성 가능한 시퀀스 최대값
 [MINVALUE n | NOMINVALUE] <-CYCLE일 경우 새로 시작되는 값
                               감소하는 Sequence 일 경우 최소값
 [CYCLE | NOCYCLE] <- 시퀀스 번호를 순환 사용할 것인지 지정
 [CACHE n | NOCACHE] <- 시퀀스 생성속도를 개선하기 위해 캐싱여부 지정



2) 수정
ALTER  SEQUENCE emp_seq
 INCREMENT BY 30
 --START WITH 100  주의!!!
 MAXVALUE 9999
 NOCYCLE;

3) 삭제
DROP SEQUENCE emp_seq;


====================================================
*VIEW(교재 P414)

*  VIEW 조회
SELECT *
FROM    USER_VIEWS;

1) VIEW생성 및 수정
CREATE   [ OR REPLACE  ]   VIEW 뷰명
AS
SUBQUERY;

*인라인 뷰(교재 p421)
SELECT  D.DEPTNO,  D.DNAME,  SP.SNAME,  SP.PNAME
FROM    DEPARTMENT D,  
              ( SELECT S.studno, S.name AS SNAME,   P.name AS PNAME, P.email,    P.DEPTNO AS DNO
                FROM   STUDENT S   JOIN   PROFESSOR P   ON  S.profno = P.profno
                WHERE S.profno IS NOT NULL  ) SP
WHERE  D.DEPTNO=SP.DNO;              



*복합 뷰(교재 p419)
 --v_student_prof   view를 생성하세요
    담당교수가 존재하는 학생들에 한하여   studno, sname, pname 데이터

SELECT profno, name
FROM    PROFESSOR;


SELECT S.studno, S.name,   S.profno,   P.profno, P.name
FROM   STUDENT S,   PROFESSOR P
WHERE S.profno IS NOT NULL
             AND
             S.profno = P.profno;
 
SELECT * FROM  v_student_prof;
  
CREATE    OR REPLACE     VIEW v_student_prof(studno, sname, pname)
AS
SELECT S.studno, S.name,   P.name, P.email
FROM   STUDENT S   JOIN   PROFESSOR P   ON  S.profno = P.profno
WHERE S.profno IS NOT NULL;


*단순 뷰(교재 P414)
문제발생    insufficient privileges
해결방법    필요한 권한을 부여받으면 된다
참고          뷰를 생성하기 위해서는 권한이 필요하다
conn /as sysdba
grant  create view
to      scott;
    

-- 입사년도가 1981인 사원에 한해     81/01/01~81/12/31
    emp테이블에서 사원번호,사원명,급여, 입사년도 가져와
    급여 오름차순된 
    view_emp_sal  VIEW생성하시오.
    이 때 급여가  미확정이면 0으로 대체
    
주의         must name this expression with a column alias

SELECT   *  FROM    emp;
SELECT   *  FROM    view_emp_sal;

-- emp에서  현빈의 입사일을   '99/01/10'으로 변경으로 변경 후 (뷰,테이블)확인
UPDATE  emp
SET         hiredate =  '99/01/10'
WHERE   ename='현빈';

-- emp에서  현빈의 급여를 9900으로 변경으로 변경 후 (뷰,테이블)확인
UPDATE  emp
SET         sal = 9900
WHERE   ename='현빈';

--  view_emp_sal에 대해 현빈의 급여를 4900으로 변경 후 (뷰,테이블)확인
UPDATE  view_emp_sal
SET         esal = 4900
WHERE   ename='현빈';


INSERT INTO    view_emp_sal( eno, ename, esal , ehire )
VALUES( 9110, '현빈' , 900, '1981/05/26');


INSERT INTO    view_emp_sal( eno, ename, esal , ehire )
VALUES( 9100, '현' , 900, '1981/05/26');
COMMIT;

CREATE    OR REPLACE       VIEW  view_emp_sal( eno, ename, esal , ehire )
AS
SELECT  empno, ename,  sal, hiredate
FROM     emp
WHERE  TO_CHAR(hiredate, 'YYYY')='1981'
ORDER BY sal asc;


------------------------------------------
2) VIEW삭제
DROP   VIEW  VIEW_EMP_SAL;

------------------------------------------
*DDL
1) 생성
CREATE 객체타입 객체명
~~

2) 수정
ALTER  객체타입 객체명
~~

3) 삭제
DROP 객체타입 객체명
~













