

-- KING사원조회
SELECT deptno, empno,ename,hiredate
FROM   EMP
WHERE ename='KING';

SELECT deptno, empno,ename,hiredate
FROM   EMP
WHERE ename='King';


SELECT deptno, empno,ename,hiredate
FROM   EMP
WHERE deptno=30;


SELECT deptno, empno,ename,hiredate
FROM   EMP
WHERE deptno!=30;


