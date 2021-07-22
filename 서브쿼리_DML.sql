*SUBQUERY(서브쿼리)-교재 P438
=> 쿼리문안의 쿼리문을 뜻하는 것으로
    여러 개의 쿼리문을 하나의 쿼리문으로 수행할 수 있다
    
    안쪽에 들어가는 쿼리라고해서 INNER 쿼리라고도 한다
    먼저    실행해야 하므로  ()에 작성해 준다

 *DML(교재 P296~)
 *UPDATE(교재 P305~)
 형식>
 UPDATE 테이블명
 SET 컬럼명=새값, ...컬럼명=새값
 [WHERE 조건]
 
 *UPDATE+SUBQUERY+JOIN
 -- 마케팅부 위치를 SCOTT이 근무하는 부서가 있는 소재지로 변경
 UPDATE DEPT
 SET LOC=(  SELECT   D.LOC
                   FROM       EMP E, DEPT D
                   WHERE     E.DEPTNO=D.DEPTNO
                                    AND
                                    E.ENAME='SCOTT')
 WHERE  DNAME='마케팅부';                           
 
 
 *UPDATE+SUBQUERY
  -- 마케팅부 위치를 SCOTT이 근무하는 부서가 있는 소재지로 변경
                               SCOTT이 근무하는 부서번호?가 있는 소재지
                               부서번호의 소재지 
                               =>부서번호가 20인 소재지 조회
 UPDATE DEPT
 SET        LOC=(   SELECT LOC
                            FROM    DEPT
                            WHERE  DEPTNO= ( SELECT DEPTNO
                                                            FROM     EMP
                                                            WHERE   ENAME='SCOTT')
                        )        
 WHERE  DNAME='마케팅부';
 
 
 
 -- 마케팅부 위치를 NULL로 수정
 UPDATE    DEPT
 SET           LOC=NULL
 WHERE     DNAME='마케팅부';
 
 
 개발2부의 위치를 마케팅부서와 동일한 곳으로 하세요
 UPDATE DEPT
 SET        LOC=(SELECT  LOC
                        FROM      DEPT
                        WHERE    DNAME='마케팅부')
 WHERE  DNAME='개발2부'
 
 
 --마케팅부서의 위치를 울릉도로 이전하세요
 UPDATE  DEPT
 SET         LOC='울릉도'
 WHERE   DNAME='마케팅부';
 
 SELECT DNAME, LOC
 FROM    DEPT
 WHERE   DNAME='마케팅부';
 
 *DELETE와 SUBQUERY
 *DELETE문법(교재 P306~)
  DELETE [FROM] 테이블명
  [WEHRE 조건] 
  
  --부서명이 미확정된 동일소재지에 위치한 부서 삭제
  DELETE FROM DEPT
  WHERE  LOC = (SELECT LOC
                            FROM   DEPT
                            WHERE DNAME IS NULL);
 
   --소재지가 미확정되면서  부서명에 1이 포함된 부서 삭제
 DELETE  DEPT
 WHERE  LOC IS NULL
                AND
                DNAME LIKE '%1%';
  COMMIT;          
 
 
 *INSERT문법(교재 P296~)
  INSERT INTO 테이블[(컬럼명,컬럼명,..)]
 VALUES(값,값,..);
 
--묵시적 NULL 삽입 : 컬럼명 생략시
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(51, '개발1부');
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(52, '개발2부');
 
-- 명시적 NULL 삽입 : NULL, '' 
INSERT INTO DEPT VALUES(53, NULL , '제주도');

INSERT INTO DEPT VALUES( 54, '영업부', '제주도');
 
--DML작업(입력,수정,삭제,조회)시  주의 : 컬럼타입 ,크기, 제약조건(constraint : NN, UK, PK)
INSERT INTO DEPT VALUES( 55, '영업부~~~~~~~~~아무내용', '제주도');
value too large for column "SCOTT"."DEPT"."DNAME" (actual: 30, maximum: 14)
 
-- NN제약조건 위배 : NULL을 허용X 
INSERT INTO DEPT VALUES( NULL, '마케팅부', '독도'); 
cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

-- UK제약조건 위배 : UNIQUE는 중복값허용X. 유일한값
-- PK(Primary key):  UK+NN+ 각각의 행을 구분+테이블성격을 대표컬럼
INSERT INTO DEPT VALUES( 40, '마케팅부', '독도');
unique constraint (SCOTT.PK_DEPT) violated


INSERT INTO DEPT VALUES( 55, '마케팅부', '독도');
COMMIT;

  INSERT INTO DEPT(DEPTNO, DNAME, LOC)
  VALUES( 50, '부서1' ,'서울'  );


 
 --서브쿼리의 다중행 연산자(교재 P443)
    IN, ALL, ANY, EXISTS

-- EMPNO, ENAME, MGR
-- KING과 동일한 MGR을 두고 있는 사원 정보 조회
SELECT EMPNO,ENAME,MGR
FROM   EMP
WHERE  EXISTS(SELECT MGR
                                      FROM    EMP
                                       WHERE ENAME='king');

SELECT EMPNO,ENAME,MGR
FROM   EMP
WHERE  EXISTS(SELECT MGR
                                      FROM    EMP
                                       WHERE ENAME='KING');

SELECT EMPNO,ENAME,MGR
FROM   EMP
WHERE  MGR=(SELECT MGR
                        FROM    EMP
                        WHERE ENAME='KING');
WHERE MGR=알수없는값

-- 급여가 30번 부서에 근무하는 사원중 
    최저급여와 최고급여 범위 사이인 사원들의 정보를 조회
 SELECT ENAME,SAL
 FROM   EMP
 WHERE SAL  BETWEEN (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30)  
                                         AND
                                         (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30)
ORDER BY SAL;
    
    
SELECT ENAME, SAL
FROM    EMP
WHERE SAL >=ANY (SELECT SAL
                        FROM    EMP
                        WHERE DEPTNO=10);    
                         (2450,5000,1300);
                         
-- 10번 부서에 근무하는 사원들이 급여보다는 많이 급여를 받는 사원?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL >=ALL (SELECT SAL
                        FROM    EMP
                        WHERE DEPTNO=10);

-- 10번 부서에 근무하는 사원들이 받은 급여랑 동일한 급여를 받는 사원?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL IN(2450,5000,1300);
WHERE SAL = (SELECT SAL
                        FROM    EMP
                        WHERE DEPTNO=10);
-- 10번 부서에 근무하는 사원 중 제일 높은 급여를 받는 사원보다
   급여를 많이 받는 사원?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL>(SELECT MIN(SAL)
                       FROM  EMP
                       WHERE DEPTNO=10);



-- FORD가 하는 업무와 동일한 일을 하는 사원명, 업무 조회
SELECT ENAME, JOB
FROM   EMP
WHERE  JOB=(SELECT JOB
                        FROM   EMP
                        WHERE ENAME='FORD' );

SELECT ENAME, HIREDATE, SAL
FROM   EMP
WHERE  SAL>= ( SELECT SAL
                            FROM    EMP
                            WHERE ENAME='FORD')
ORDER BY SAL;

    
-- 'RESEARCH'부서에 근무하는 사원명, 업무, 부서명 조회
SELECT DEPTNO, DNAME
FROM   DEPT
WHERE DNAME='RESEARCH';  => DEPTNO가 20

--20번부서 근무자의 평균급여초과

SELECT AVG(SAL)
FROM   EMP
WHERE DEPTNO=20;

SELECT E.ENAME, E.JOB, E.DEPTNO,  E.SAL,
              D.DNAME
FROM    EMP E, DEPT D
WHERE  E.DEPTNO=(SELECT DEPTNO
                                FROM   DEPT
                                WHERE DNAME='RESEARCH')
               AND
               E.DEPTNO=D.DEPTNO
               AND
               E.SAL>(SELECT AVG(SAL)
                                FROM   EMP
                                WHERE DEPTNO=20)
ORDER BY E.JOB ASC, E.ENAME ASC;
                                --부서명이 'RESEARCH'
                                
                                
                                
                                
                                