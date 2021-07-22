
*조인 + 서브쿼리
SELECT go.gname, go.point, gi.gname
FROM   GOGAK go, GIFT gi
WHERE  gi.gname='노트북'
       and
       go.point >= (select g_start
                         from  GIFT
                         where gname='노트북'
                        )




*JOIN(교재 P224~)
=> 다수 개의 테이블을  대상으로 하여 손쉽게 조회
SELECT e1.ENAME,    e1.MGR "상사의 EMPNO",
             e2.EMPNO "사원번호",    e2.ENAME 
FROM    EMP e1, EMP e2
WHERE    e1.MGR  =  e2.EMPNO(+);

SELECT   EMPNO "사원번호",  ENAME  
FROM      EMP;



SELECT e.STUDNO,   s.NAME,  e.TOTAL,    
             h.GRADE, h.MIN_POINT||'~'||h.MAX_POINT
FROM   STUDENT s, EXAM_01 e,   HAKJUM h
WHERE   s.studno = e.studno
                AND
                e.TOTAL    BETWEEN   h.MIN_POINT   AND    h.MAX_POINT
ORDER  BY  TOTAL  ASC;


SELECT 컬럼명, 컬럼명 AS alias
FROM   테이블

select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s   FULL OUTER JOIN   DEPARTMENT D
                                                   ON S.DEPTNO1=D.DEPTNO;



select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s   LEFT JOIN DEPARTMENT D
                                    ON  S.DEPTNO1=D.DEPTNO;


select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s,  DEPARTMENT D
where  S.DEPTNO1=D.DEPTNO(+);



select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s  RIGHT JOIN   DEPARTMENT D
                              ON  S.DEPTNO1=D.DEPTNO;


select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s,  DEPARTMENT D
where  S.DEPTNO1(+)=D.DEPTNO;

-- scott유저의 테이블 중  학생(student)과   교수(professor) 을 이용하여
-- 학생이름, 학년(grade),  담당교수이름 출력
-- equi join 기법
select  D.DNAME,
            s.name AS SNAME,  s.grade, 
           p.profno ,p.name AS PNAME
from student s, professor p,  DEPARTMENT D
where s.profno = p.profno
            AND
           S.DEPTNO1(+)=D.DEPTNO;

-- JOIN  ON기법   --학생 소속(학과,학부)   DEPARTMENT 테이블의 DEPTNO
select   D.DNAME,
            s.name AS SNAME,  s.grade, 
           p.profno ,p.name AS PNAME
from student s   INNER JOIN   professor p           ON s.profno = p.profno
                           INNER JOIN  DEPARTMENT D    ON S.DEPTNO1=D.DEPTNO;






2. ANSI JOIN문법
* [INNER] JOIN  ON - p239
SELECT  E.EMPNO, E.ENAME,  E.DEPTNO,   D.DNAME,  LOWER(D.LOC)
FROM   EMP   E  INNER  JOIN   DEPT D    
                                          ON   E.deptno = D.deptno   --JOIN조건
WHERE   D.LOC=  UPPER('NEW york')                                       
ORDER BY E.DEPTNO ASC;

1. equi join(등가조인)- 교재 P234
=> 오라클에서 사용하는 조인문법
SELECT  E.EMPNO, E.ENAME,  E.DEPTNO,   D.DNAME
FROM   EMP   E,    DEPT D
WHERE     E.deptno = D.deptno   --JOIN조건
ORDER BY E.DEPTNO ASC;








