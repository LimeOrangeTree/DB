*SUBQUERY(��������)-���� P438
=> ���������� �������� ���ϴ� ������
    ���� ���� �������� �ϳ��� ���������� ������ �� �ִ�
    
    ���ʿ� ���� ��������ؼ� INNER ������� �Ѵ�
    ����    �����ؾ� �ϹǷ�  ()�� �ۼ��� �ش�
 
 *DELETE�� SUBQUERY
 *DELETE����
  DELETE [FROM] ���̺��
  [WEHRE ����]
 
 
 *INSERT����
  INSERT INTO ���̺�[(�÷���,�÷���,..)]
 VALUES(��,��,..);
 
--������ NULL ���� : �÷��� ������
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(51, '����1��');
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(52, '����2��');
 
-- ����� NULL ���� : NULL, '' 
INSERT INTO DEPT VALUES(53, NULL , '���ֵ�');

INSERT INTO DEPT VALUES( 54, '������', '���ֵ�');
 
--DML�۾�(�Է�,����,����,��ȸ)��  ���� : �÷�Ÿ�� ,ũ��, ��������(constraint : NN, UK, PK)
INSERT INTO DEPT VALUES( 55, '������~~~~~~~~~�ƹ�����', '���ֵ�');
value too large for column "SCOTT"."DEPT"."DNAME" (actual: 30, maximum: 14)
 
-- NN�������� ���� : NULL�� ���X 
INSERT INTO DEPT VALUES( NULL, '�����ú�', '����'); 
cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

-- UK�������� ���� : UNIQUE�� �ߺ������X. �����Ѱ�
-- PK(Primary key):  UK+NN+ ������ ���� ����+���̺����� ��ǥ�÷�
INSERT INTO DEPT VALUES( 40, '�����ú�', '����');
unique constraint (SCOTT.PK_DEPT) violated


INSERT INTO DEPT VALUES( 55, '�����ú�', '����');
COMMIT;

  INSERT INTO DEPT(DEPTNO, DNAME, LOC)
  VALUES( 50, '�μ�1' ,'����'  );


 
 --���������� ������ ������(���� P443)
    IN, ALL, ANY, EXISTS

-- EMPNO, ENAME, MGR
-- KING�� ������ MGR�� �ΰ� �ִ� ��� ���� ��ȸ
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
WHERE MGR=�˼����°�

-- �޿��� 30�� �μ��� �ٹ��ϴ� ����� 
    �����޿��� �ְ�޿� ���� ������ ������� ������ ��ȸ
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
                         
-- 10�� �μ��� �ٹ��ϴ� ������� �޿����ٴ� ���� �޿��� �޴� ���?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL >=ALL (SELECT SAL
                        FROM    EMP
                        WHERE DEPTNO=10);

-- 10�� �μ��� �ٹ��ϴ� ������� ���� �޿��� ������ �޿��� �޴� ���?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL IN(2450,5000,1300);
WHERE SAL = (SELECT SAL
                        FROM    EMP
                        WHERE DEPTNO=10);
-- 10�� �μ��� �ٹ��ϴ� ��� �� ���� ���� �޿��� �޴� �������
   �޿��� ���� �޴� ���?
SELECT ENAME, SAL
FROM    EMP
WHERE SAL>(SELECT MIN(SAL)
                       FROM  EMP
                       WHERE DEPTNO=10);



-- FORD�� �ϴ� ������ ������ ���� �ϴ� �����, ���� ��ȸ
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

    
-- 'RESEARCH'�μ��� �ٹ��ϴ� �����, ����, �μ��� ��ȸ
SELECT DEPTNO, DNAME
FROM   DEPT
WHERE DNAME='RESEARCH';  => DEPTNO�� 20

--20���μ� �ٹ����� ��ձ޿��ʰ�

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
                                --�μ����� 'RESEARCH'
                                
                                
                                
                                
                                