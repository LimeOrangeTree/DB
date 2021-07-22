SELECT *
	FROM   DEPT
	WHERE  LOC IS NOT NULL;



SELECT *
	FROM   DEPT
	WHERE dname like '%#_%'  escape '#' 
				OR
	      dname like '%@%%'  escape '@'; 


INSERT INTO DEPT(deptno,dname)
VALUES(53,'마케_팅');
INSERT INTO DEPT(deptno,dname)
VALUES(54,'회%계부');

commit;

INSERT INTO 테이블명[(컬럼명,컬럼명,...)]
	VALUES(값,값,..);

	INSERT INTO DEPT(deptno)
	VALUES(52);



INSERT INTO DEPT(deptno)
	VALUES(NULL);
cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

INSERT INTO DEPT(deptno, dname, loc)
	VALUES(52,NULL,'');


INSERT INTO DEPT(deptno, dname)
VALUES(51,'디자인부');


-- 부서(DEPT)테이블
INSERT INTO DEPT(deptno, dname, loc)
	VALUES(51,'슈퍼울트라캡숑최강개발부','서울');



-- 이름 2번째글자로 M이 포함된 사원
SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename  LIKE '_M%';

-- 이름에 M이 포함된 사원
SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename  LIKE '%M%';



SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename='SMITH';



-- 아래조건이 아닌 사원 조회
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE   sal not in(800, 1100, 1200, 1500);

-- 급여가 800, 1100, 1200,1500인 사원조회
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE   sal in(800, 1100, 1200, 1500);

SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE 	deptno>=20
	OR
	sal   >=3000
ORDER BY sal ASC;


-- 부서번호가 20이상이면서 급여가 3000이상
-- 급여 적게 받는 사원부터 출력
-- 사원번호,사원명,입사일,급여 조회
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE 	deptno>=20
	AND
	sal   >=3000
ORDER BY sal ASC;


-- 급여 1250이상~ 3000이하  급여가
-- 급여 적게 받는 사원부터 출력
-- 사원번호,사원명,입사일,급여 조회
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE sal between 1250 and 3000
ORDER BY sal ASC;

SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE sal not between 1250 and 3000
ORDER BY sal ASC;

--입사일이  80/12/17
-- 사원번호,사원명,입사일,급여 조회
SELECT empno,ename,hiredate,sal
FROM emp
WHERE hiredate > '80/12/17' ;


--SELECT * | 컬럼명
--FROM    테이블명
--WHERE 조건
--ORDER BY 정렬기준 방법