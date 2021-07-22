--함수명()
*그룹함수(교재 P158~)
SELECT 컬럼명, 컬럼명,그룹함수()
FROM   테이블명
WHERE  조건
GROUP BY 그룹기준
HAVING     그룹조건
ORDER  BY 정렬기준  방법,정렬기준  방법,..;

*분석함수(ROLLUP 교재P167, CUBE 교재 P176)
-- 부서별 JOB별 근무자수를 출력
SELECT DEPTNO,JOB,  COUNT(*)
FROM    EMP
GROUP BY   CUBE(DEPTNO,JOB);



SELECT DEPTNO,JOB,  COUNT(*)
FROM    EMP
GROUP BY   ROLLUP(DEPTNO,JOB);




-- 근무부서가 10 또는 30에 근무하는  부서별 사원의 총급여, 근무자수를 출력~~~~~~~~~~
SELECT  DEPTNO,  SUM(SAL), COUNT(*)
FROM    EMP
WHERE   DEPTNO IN(10,30)
GROUP BY  DEPTNO;


SELECT  DEPTNO,  SUM(SAL), COUNT(*)
FROM    EMP
GROUP BY  DEPTNO
HAVING     DEPTNO=10    OR    DEPTNO=30;
HAVING     DEPTNO IN(10,30)

-- job 별 총급여,평균급여.. 소수점 1자리까지
-- job별 평균급여가 2000 초과
SELECT job, SUM(SAL),   ROUND(AVG(SAL),1)
FROM    EMP
GROUP BY job
HAVING  ROUND(AVG(SAL),1) > 2000 ;

-- job별 최고급여, 최저급여, 최고급여액과 최저급여액의 차이, 근무자수 조회
-- JOB별 근무자수가 3명 이상
SELECT JOB, MAX(SAL), MIN(SAL), MAX(SAL)-MIN(SAL), COUNT(*)
FROM    EMP
GROUP BY JOB
HAVING   COUNT(*)>=3;


주의!     그룹함수와 함께 조회하는 컬럼은 그룹기준으로 사용되는 컬럼만 가능
SQL> SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
         FROM    EMP
         GROUP  BY   DEPTNO
         ORDER  BY  DEPTNO ASC;
SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression


-- 총급여, 평균급여 소수첫짜리
SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
FROM    EMP
GROUP  BY   DEPTNO
ORDER  BY  DEPTNO ASC; 




-- COUNT(*) : NULL포함 카운트한다
SELECT COUNT(*), COUNT(EMPNO), COUNT(ENAME),COUNT(COMM)
FROM    EMP;

SELECT   MIN(SAL), MAX(SAL),  ROUND( AVG(SAL)  ,1)   , SUM(SAL), COUNT(*), STDDEV(SAL)
FROM    EMP;

-------------------------------------------------------------
*기타함수(교재 p110~)
-CASE    -교재 P120~
형식>
CASE 조건  WHEN 결과1  THEN  출력1
           [WHEN 결과2  THEN  출력2]
            ELSE 출력3
END  "컬럼명"

-- 부서번호가 10이면 '어카운팅부',
                         20이면 '리서치보'
                         30이면 '세일즈부'
                         
SELECT   ENAME, DEPTNO,
               CASE DEPTNO  WHEN 10  THEN  '어카운팅부'
                                        WHEN 20  THEN '리서치부'
                                        WHEN 30  THEN '세일즈부'
                                         ELSE '기타'       
                END  "부서명" ,
                SAL,
                CASE   WHEN SAL>4000  THEN  'A등급'
                            WHEN SAL>=3000  THEN 'B등급'
                            WHEN SAL>1000  THEN 'C등급'
                            ELSE '기타'
                END "등급"                         
FROM  EMP
ORDER BY SAL ASC;
                         




-DECODE(   )-교재 P113~
=> IF문
  if(조건){
    조건만족실행
  }else {
    조건만족x실행
  }
  DECODE(A,B,'1',그외)=> A가 B라면 '1'
  --사원명, 부서번호   부서번호 오름
  -- 부서번호가 10이면 '어카운팅부서',
                         20이면 '리서치부서'
                         30이면 '세일즈부서'
  SELECT ENAME, DEPTNO,  DECODE(DEPTNO, 10, '어카운팅부서', '기타부서'),
                                              DECODE(DEPTNO, 10, '어카운팅부서', 20, '리서치부서') ,
                                              DECODE(DEPTNO, 10, '어카운팅부서', 20, '리서치부서', 30,'세일즈부서','기타') ,
                                              DECODE(DEPTNO, 10, '어카운팅부서',  decode(DEPTNO,20,'리서치','그외') )
  FROM    EMP
  ORDER BY DEPTNO ASC;
  
 
-null관련 함수
-NVL2( 표현식, NULL아닌대체값 ,NULL의대체값 )-교재 P112
SELECT  ENAME, SAL, COMM,  NVL( COMM, 0),  NVL2( COMM, 10,0) ,  NVL2( COMM, SAL*0.1, SAL*0.2)
FROM     EMP
ORDER   BY  COMM ASC;

-NVL( 표현식, NULL의대체값 )
-- 사원명, 급여, 커미션    커미션오름
-- 커미션이 미확정되었다면   0을 적용
SELECT  ENAME, SAL, COMM,  NVL( COMM, 0),  SAL+COMM,  SAL+ NVL(COMM,0)
FROM     EMP
ORDER   BY  COMM ASC;

*형변환함수 ★★★★
--묵시적 형변환
SELECT    '1'+'1' 
FROM      DUAL;

-- 사원번호가 7369인 사원정보 조회
SELECT EMPNO, ENAME
FROM    EMP
WHERE EMPNO=   TO_NUMBER('7369');
--WHERE EMPNO='7369';

--명시적 형변환
*문자Char->숫자Number : TO_NUMBER(문자)
SELECT    TO_NUMBER('1')+TO_NUMBER('1')
FROM      DUAL;

*문자Char->날짜Date : TO_DATE( 문자, '포맷' )-교재 P109
-- 내가 살아온 일수?
 SELECT    SYSDATE,   SYSDATE- TO_DATE( '2019-02-18',   'YYYY-MM-DD' ),
                 TRUNC(   SYSDATE- TO_DATE( '2019-02-18',   'YYYY-MM-DD' )   )
 FROM     DUAL;

 SELECT  '2000-02-16',   TO_DATE( '2000-02-16',   'YYYY-MM-DD' )+1
 FROM     DUAL;

*날짜Date     ->문자Char : TO_CHAR(날짜, '포맷' ) -교재 P102~
  숫자Number->문자Char : TO_CHAR(숫자, '포맷' ) -교재 P107

-- 사원명,급여  급여내림
SELECT   ENAME, SAL,  SAL*13 "년봉",    TO_CHAR( SAL*13   , '$999,999,999.00' )
FROM     EMP
ORDER BY  SAL DESC;


*날짜함수(교재 p89~)
-- 사원이 입사한 첫 달의 근무일수를 구하라
-- 단, 토,일요일도 근무일수에 포함한다
 SELECT    hiredate,    LAST_DAY(  hiredate  ),    (LAST_DAY(  hiredate  )-hiredate)+1 as 근무일수
FROM      EMP
ORDER BY  근무일수 desc;

--LAST_DAY : 주어진 날짜가 속한   달의  마지막 날짜 출력
SELECT    SYSDATE, LAST_DAY(  SYSDATE )
FROM       DUAL;

--NEXT_DAY : 주어진 날짜를 기준으로 돌아오는 날짜 출력
SELECT    SYSDATE,  NEXT_DAY(  SYSDATE,  '토요일'  )
FROM       DUAL;

-- 사원입사일, 6개월 뒤, 6개월 전
SELECT  hiredate,  ADD_MONTHS( hiredate, 6  ),  ADD_MONTHS( hiredate, -6  )
FROM    EMP;


 SELECT SYSDATE,   MONTHS_BETWEEN(SYSDATE+180, SYSDATE),
             ROUND(   MONTHS_BETWEEN(SYSDATE+180, SYSDATE)   ,   0)
 FROM    DUAL;


 SELECT SYSDATE, SYSDATE+(4/24) "4시간뒤", 
                TO_CHAR(  SYSDATE+(4/24),  'YYYY.MONTH.DD  HH24:MI:SS AM DAY' )
 FROM    DUAL;
 
-- 날짜-날짜 => 숫자
 SELECT    hiredate,    LAST_DAY(  hiredate  ),    (LAST_DAY(  hiredate  )-hiredate)+1
FROM      EMP
ORDER BY  hiredate;
 
 
 
--  날짜+-숫자 =>날짜
 SELECT   SYSDATE-7, SYSDATE, SYSDATE+1  "1일뒤"
 FROM    DUAL;




*숫자함수(교재 P86~)
 일의 자리               : -1
 소수점 첫번째 자리 : 0 (기본값)
 소수점 2번째 자리  : 1

--MOD(숫자1,숫자2) : 나머지
SELECT MOD(3,2), MOD(2,2)
FROM   DUAL;

--TRUNC(표현식, 자릿수) : 자릿수에서 절삭
SELECT TRUNC(356.739), TRUNC(356.739,0), TRUNC(356.739,1)
FROM  DUAL;

-- CEIL(표현식) : 올림
--FLOOR(표현식) : 내림
SELECT CEIL(356.739), FLOOR(356.739)
FROM  DUAL;
 
--ROUND( 표현식, 자릿수 ) : 반올림  ★★
SELECT ROUND(356.739,  -1),
              ROUND(356.739), 
              ROUND(356.739, 0),  ROUND(356.739, 1)  
FROM    DUAL;
 

*문자열함수(교재 P70~)
--REPLACE(표현식,'old문자','new문자') 교재 P83~ ★★★
SELECT ENAME,
               SUBSTR( ENAME, 1, 3),
               REPLACE( ENAME,  SUBSTR( ENAME, 1, 3)     , '***'  )
FROM   EMP;

문제 7. 사원테이블의 사원명이  뒤에서 3글자는 ***로 변경하여 출력하세요
           SMITH => SM***

--INSTR(표현식, 찾는문자[, 찾는범위의 시작위치, 등장순서]) ★★★
-- 찾는 문자는 영문대소문자를 구분
-- 찾는 문자가 있으면 해당 문자의 위치를 리턴받는다
    문자의 위치는 1부터..
-- 찾는 문자가 없으면 0을 리턴받는다
-- 찾는범위의 시작위치, 등장순서가 생략되면 1
    찾는범위의 시작위치가 없으면 1번째 문자부터 찾겠다
SELECT  'ACCOUNTING',
        INSTR(  'ACCOUNTING',   'TING' ),        ==>7
        INSTR(  'ACCOUNTING',   'TING' , 1,1)  ==>7
FROM    DUAL;  
    
SELECT  'ACCOUNTING',
         INSTR(  'ACCOUNTING',   'C' , 2,1),  ==>2
         INSTR(  'ACCOUNTING',   'C' , 2,2);  ==>3  
    
SELECT  'ACCOUNTING',   INSTR(  'ACCOUNTING',   'C' , 3,1) 
FROM    DUAL;   
    
SELECT  'ACCOUNTING',   INSTR(  'ACCOUNTING',   'A' ) , INSTR(  'ACCOUNTING',   'a' ) 
FROM    DUAL;

문제3. 
  02-111-1234 에서 첫번째 등장하는 '-'문자의 위치는?
문제4.
  033)1111-1234 에서  ')'문자의 위치는?

문제5.  필요하다면 함수2개이상을 사용하여
  02)111-1234 에서      지역번호 추출  
            출력결과    02
            
문제6.   Student테이블의 tel컬럼에서 지역번호를 추출하세요           


--SUBSTR( 표현식, 시작위치[, 글자수])   ★★★★★
--시작위치는 첫글자의 위치는 1
   SUBSTR(DNAME, 1, 3)=>1번째인 첫글자부터 3글자
   SUBSTR(DNAME, -3, 2)   => 뒤에서 3번째 글자 붙터 2글자
                                               참고   가장 뒤에 있는 글자는 -1
--글자수를 생략하면 해당 문자열의 끝까지
   SUBSTR(DNAME, 5)=> 5번째 글자부터 문자열끝까지
   
SELECT   DNAME ,  SUBSTR(DNAME, 3, 2)  , SUBSTR(DNAME, -3, 2)   
FROM     DEPT;

*함수를 이용하여  질의명령문을 작성하여 저장하세요
문제1.   02)111-1234 에서      지역번호 추출  
            출력결과    02
문제2.   032)1111-1234 에서    지역번호 추출
            출력결과    032



SELECT  DNAME,    LTRIM(DNAME, 'S'), RTRIM(DNAME, 'S')
FROM    DEPT
--  부서명에 S포함
WHERE DNAME LIKE '%S%';



SELECT   length(DNAME) ,  length( LPAD( DNAME, 10,  '*' )   ),  
                LPAD( DNAME, 10,  '*' ),  RPAD( DNAME, 10,  '?' )
FROM    DEPT;

SELECT  '최강 ' || DNAME || '부서',   CONCAT(  DNAME,  '부서')
FROM   DEPT;

SELECT  LENGTH('oralce11g'), LENGTH('대한민국'), LENGTH('2019 !'),
              LENGTHB('oralce11g'), LENGTHB('대한민국'), LENGTHB('2019 !')
FROM    DUAL;


SELECT  dname, LENGTH(dname), LENGTHB(dname)
FROM   DEPT;

SELECT  dname,  INITCAP(dname), LOWER(dname), UPPER('deDt')
FROM     DEPT;

