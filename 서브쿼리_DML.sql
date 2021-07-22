*SUBQUERY(��������)-���� P438
=> ���������� �������� ���ϴ� ������
    ���� ���� �������� �ϳ��� ���������� ������ �� �ִ�
    
    ���ʿ� ���� ��������ؼ� INNER ������� �Ѵ�
    ����    �����ؾ� �ϹǷ�  ()�� �ۼ��� �ش�

 *DML(���� P296~)
 *UPDATE(���� P305~)
 ����>
 UPDATE ���̺��
 SET �÷���=����, ...�÷���=����
 [WHERE ����]
 
 *UPDATE+SUBQUERY+JOIN
 -- �����ú� ��ġ�� SCOTT�� �ٹ��ϴ� �μ��� �ִ� �������� ����
 UPDATE DEPT
 SET LOC=(  SELECT   D.LOC
                   FROM       EMP E, DEPT D
                   WHERE     E.DEPTNO=D.DEPTNO
                                    AND
                                    E.ENAME='SCOTT')
 WHERE  DNAME='�����ú�';                           
 
 
 *UPDATE+SUBQUERY
  -- �����ú� ��ġ�� SCOTT�� �ٹ��ϴ� �μ��� �ִ� �������� ����
                               SCOTT�� �ٹ��ϴ� �μ���ȣ?�� �ִ� ������
                               �μ���ȣ�� ������ 
                               =>�μ���ȣ�� 20�� ������ ��ȸ
 UPDATE DEPT
 SET        LOC=(   SELECT LOC
                            FROM    DEPT
                            WHERE  DEPTNO= ( SELECT DEPTNO
                                                            FROM     EMP
                                                            WHERE   ENAME='SCOTT')
                        )        
 WHERE  DNAME='�����ú�';
 
 
 
 -- �����ú� ��ġ�� NULL�� ����
 UPDATE    DEPT
 SET           LOC=NULL
 WHERE     DNAME='�����ú�';
 
 
 ����2���� ��ġ�� �����úμ��� ������ ������ �ϼ���
 UPDATE DEPT
 SET        LOC=(SELECT  LOC
                        FROM      DEPT
                        WHERE    DNAME='�����ú�')
 WHERE  DNAME='����2��'
 
 
 --�����úμ��� ��ġ�� �︪���� �����ϼ���
 UPDATE  DEPT
 SET         LOC='�︪��'
 WHERE   DNAME='�����ú�';
 
 SELECT DNAME, LOC
 FROM    DEPT
 WHERE   DNAME='�����ú�';
 
 *DELETE�� SUBQUERY
 *DELETE����(���� P306~)
  DELETE [FROM] ���̺��
  [WEHRE ����] 
  
  --�μ����� ��Ȯ���� ���ϼ������� ��ġ�� �μ� ����
  DELETE FROM DEPT
  WHERE  LOC = (SELECT LOC
                            FROM   DEPT
                            WHERE DNAME IS NULL);
 
   --�������� ��Ȯ���Ǹ鼭  �μ��� 1�� ���Ե� �μ� ����
 DELETE  DEPT
 WHERE  LOC IS NULL
                AND
                DNAME LIKE '%1%';
  COMMIT;          
 
 
 *INSERT����(���� P296~)
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
                                
                                
                                
                                
                                