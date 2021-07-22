--�Լ���()
*�׷��Լ�(���� P158~)
SELECT �÷���, �÷���,�׷��Լ�()
FROM   ���̺��
WHERE  ����
GROUP BY �׷����
HAVING     �׷�����
ORDER  BY ���ı���  ���,���ı���  ���,..;

*�м��Լ�(ROLLUP ����P167, CUBE ���� P176)
-- �μ��� JOB�� �ٹ��ڼ��� ���
SELECT DEPTNO,JOB,  COUNT(*)
FROM    EMP
GROUP BY   CUBE(DEPTNO,JOB);



SELECT DEPTNO,JOB,  COUNT(*)
FROM    EMP
GROUP BY   ROLLUP(DEPTNO,JOB);




-- �ٹ��μ��� 10 �Ǵ� 30�� �ٹ��ϴ�  �μ��� ����� �ѱ޿�, �ٹ��ڼ��� ���~~~~~~~~~~
SELECT  DEPTNO,  SUM(SAL), COUNT(*)
FROM    EMP
WHERE   DEPTNO IN(10,30)
GROUP BY  DEPTNO;


SELECT  DEPTNO,  SUM(SAL), COUNT(*)
FROM    EMP
GROUP BY  DEPTNO
HAVING     DEPTNO=10    OR    DEPTNO=30;
HAVING     DEPTNO IN(10,30)

-- job �� �ѱ޿�,��ձ޿�.. �Ҽ��� 1�ڸ�����
-- job�� ��ձ޿��� 2000 �ʰ�
SELECT job, SUM(SAL),   ROUND(AVG(SAL),1)
FROM    EMP
GROUP BY job
HAVING  ROUND(AVG(SAL),1) > 2000 ;

-- job�� �ְ�޿�, �����޿�, �ְ�޿��װ� �����޿����� ����, �ٹ��ڼ� ��ȸ
-- JOB�� �ٹ��ڼ��� 3�� �̻�
SELECT JOB, MAX(SAL), MIN(SAL), MAX(SAL)-MIN(SAL), COUNT(*)
FROM    EMP
GROUP BY JOB
HAVING   COUNT(*)>=3;


����!     �׷��Լ��� �Բ� ��ȸ�ϴ� �÷��� �׷�������� ���Ǵ� �÷��� ����
SQL> SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
         FROM    EMP
         GROUP  BY   DEPTNO
         ORDER  BY  DEPTNO ASC;
SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
       *
ERROR at line 1:
ORA-00979: not a GROUP BY expression


-- �ѱ޿�, ��ձ޿� �Ҽ�ù¥��
SELECT ENAME,DEPTNO, COUNT(DEPTNO), SUM(SAL),   ROUND(  AVG(SAL), 1)
FROM    EMP
GROUP  BY   DEPTNO
ORDER  BY  DEPTNO ASC; 




-- COUNT(*) : NULL���� ī��Ʈ�Ѵ�
SELECT COUNT(*), COUNT(EMPNO), COUNT(ENAME),COUNT(COMM)
FROM    EMP;

SELECT   MIN(SAL), MAX(SAL),  ROUND( AVG(SAL)  ,1)   , SUM(SAL), COUNT(*), STDDEV(SAL)
FROM    EMP;

-------------------------------------------------------------
*��Ÿ�Լ�(���� p110~)
-CASE    -���� P120~
����>
CASE ����  WHEN ���1  THEN  ���1
           [WHEN ���2  THEN  ���2]
            ELSE ���3
END  "�÷���"

-- �μ���ȣ�� 10�̸� '��ī���ú�',
                         20�̸� '����ġ��'
                         30�̸� '�������'
                         
SELECT   ENAME, DEPTNO,
               CASE DEPTNO  WHEN 10  THEN  '��ī���ú�'
                                        WHEN 20  THEN '����ġ��'
                                        WHEN 30  THEN '�������'
                                         ELSE '��Ÿ'       
                END  "�μ���" ,
                SAL,
                CASE   WHEN SAL>4000  THEN  'A���'
                            WHEN SAL>=3000  THEN 'B���'
                            WHEN SAL>1000  THEN 'C���'
                            ELSE '��Ÿ'
                END "���"                         
FROM  EMP
ORDER BY SAL ASC;
                         




-DECODE(   )-���� P113~
=> IF��
  if(����){
    ���Ǹ�������
  }else {
    ���Ǹ���x����
  }
  DECODE(A,B,'1',�׿�)=> A�� B��� '1'
  --�����, �μ���ȣ   �μ���ȣ ����
  -- �μ���ȣ�� 10�̸� '��ī���úμ�',
                         20�̸� '����ġ�μ�'
                         30�̸� '������μ�'
  SELECT ENAME, DEPTNO,  DECODE(DEPTNO, 10, '��ī���úμ�', '��Ÿ�μ�'),
                                              DECODE(DEPTNO, 10, '��ī���úμ�', 20, '����ġ�μ�') ,
                                              DECODE(DEPTNO, 10, '��ī���úμ�', 20, '����ġ�μ�', 30,'������μ�','��Ÿ') ,
                                              DECODE(DEPTNO, 10, '��ī���úμ�',  decode(DEPTNO,20,'����ġ','�׿�') )
  FROM    EMP
  ORDER BY DEPTNO ASC;
  
 
-null���� �Լ�
-NVL2( ǥ����, NULL�ƴѴ�ü�� ,NULL�Ǵ�ü�� )-���� P112
SELECT  ENAME, SAL, COMM,  NVL( COMM, 0),  NVL2( COMM, 10,0) ,  NVL2( COMM, SAL*0.1, SAL*0.2)
FROM     EMP
ORDER   BY  COMM ASC;

-NVL( ǥ����, NULL�Ǵ�ü�� )
-- �����, �޿�, Ŀ�̼�    Ŀ�̼ǿ���
-- Ŀ�̼��� ��Ȯ���Ǿ��ٸ�   0�� ����
SELECT  ENAME, SAL, COMM,  NVL( COMM, 0),  SAL+COMM,  SAL+ NVL(COMM,0)
FROM     EMP
ORDER   BY  COMM ASC;

*����ȯ�Լ� �ڡڡڡ�
--������ ����ȯ
SELECT    '1'+'1' 
FROM      DUAL;

-- �����ȣ�� 7369�� ������� ��ȸ
SELECT EMPNO, ENAME
FROM    EMP
WHERE EMPNO=   TO_NUMBER('7369');
--WHERE EMPNO='7369';

--����� ����ȯ
*����Char->����Number : TO_NUMBER(����)
SELECT    TO_NUMBER('1')+TO_NUMBER('1')
FROM      DUAL;

*����Char->��¥Date : TO_DATE( ����, '����' )-���� P109
-- ���� ��ƿ� �ϼ�?
 SELECT    SYSDATE,   SYSDATE- TO_DATE( '2019-02-18',   'YYYY-MM-DD' ),
                 TRUNC(   SYSDATE- TO_DATE( '2019-02-18',   'YYYY-MM-DD' )   )
 FROM     DUAL;

 SELECT  '2000-02-16',   TO_DATE( '2000-02-16',   'YYYY-MM-DD' )+1
 FROM     DUAL;

*��¥Date     ->����Char : TO_CHAR(��¥, '����' ) -���� P102~
  ����Number->����Char : TO_CHAR(����, '����' ) -���� P107

-- �����,�޿�  �޿�����
SELECT   ENAME, SAL,  SAL*13 "���",    TO_CHAR( SAL*13   , '$999,999,999.00' )
FROM     EMP
ORDER BY  SAL DESC;


*��¥�Լ�(���� p89~)
-- ����� �Ի��� ù ���� �ٹ��ϼ��� ���϶�
-- ��, ��,�Ͽ��ϵ� �ٹ��ϼ��� �����Ѵ�
 SELECT    hiredate,    LAST_DAY(  hiredate  ),    (LAST_DAY(  hiredate  )-hiredate)+1 as �ٹ��ϼ�
FROM      EMP
ORDER BY  �ٹ��ϼ� desc;

--LAST_DAY : �־��� ��¥�� ����   ����  ������ ��¥ ���
SELECT    SYSDATE, LAST_DAY(  SYSDATE )
FROM       DUAL;

--NEXT_DAY : �־��� ��¥�� �������� ���ƿ��� ��¥ ���
SELECT    SYSDATE,  NEXT_DAY(  SYSDATE,  '�����'  )
FROM       DUAL;

-- ����Ի���, 6���� ��, 6���� ��
SELECT  hiredate,  ADD_MONTHS( hiredate, 6  ),  ADD_MONTHS( hiredate, -6  )
FROM    EMP;


 SELECT SYSDATE,   MONTHS_BETWEEN(SYSDATE+180, SYSDATE),
             ROUND(   MONTHS_BETWEEN(SYSDATE+180, SYSDATE)   ,   0)
 FROM    DUAL;


 SELECT SYSDATE, SYSDATE+(4/24) "4�ð���", 
                TO_CHAR(  SYSDATE+(4/24),  'YYYY.MONTH.DD  HH24:MI:SS AM DAY' )
 FROM    DUAL;
 
-- ��¥-��¥ => ����
 SELECT    hiredate,    LAST_DAY(  hiredate  ),    (LAST_DAY(  hiredate  )-hiredate)+1
FROM      EMP
ORDER BY  hiredate;
 
 
 
--  ��¥+-���� =>��¥
 SELECT   SYSDATE-7, SYSDATE, SYSDATE+1  "1�ϵ�"
 FROM    DUAL;




*�����Լ�(���� P86~)
 ���� �ڸ�               : -1
 �Ҽ��� ù��° �ڸ� : 0 (�⺻��)
 �Ҽ��� 2��° �ڸ�  : 1

--MOD(����1,����2) : ������
SELECT MOD(3,2), MOD(2,2)
FROM   DUAL;

--TRUNC(ǥ����, �ڸ���) : �ڸ������� ����
SELECT TRUNC(356.739), TRUNC(356.739,0), TRUNC(356.739,1)
FROM  DUAL;

-- CEIL(ǥ����) : �ø�
--FLOOR(ǥ����) : ����
SELECT CEIL(356.739), FLOOR(356.739)
FROM  DUAL;
 
--ROUND( ǥ����, �ڸ��� ) : �ݿø�  �ڡ�
SELECT ROUND(356.739,  -1),
              ROUND(356.739), 
              ROUND(356.739, 0),  ROUND(356.739, 1)  
FROM    DUAL;
 

*���ڿ��Լ�(���� P70~)
--REPLACE(ǥ����,'old����','new����') ���� P83~ �ڡڡ�
SELECT ENAME,
               SUBSTR( ENAME, 1, 3),
               REPLACE( ENAME,  SUBSTR( ENAME, 1, 3)     , '***'  )
FROM   EMP;

���� 7. ������̺��� �������  �ڿ��� 3���ڴ� ***�� �����Ͽ� ����ϼ���
           SMITH => SM***

--INSTR(ǥ����, ã�¹���[, ã�¹����� ������ġ, �������]) �ڡڡ�
-- ã�� ���ڴ� ������ҹ��ڸ� ����
-- ã�� ���ڰ� ������ �ش� ������ ��ġ�� ���Ϲ޴´�
    ������ ��ġ�� 1����..
-- ã�� ���ڰ� ������ 0�� ���Ϲ޴´�
-- ã�¹����� ������ġ, ��������� �����Ǹ� 1
    ã�¹����� ������ġ�� ������ 1��° ���ں��� ã�ڴ�
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

����3. 
  02-111-1234 ���� ù��° �����ϴ� '-'������ ��ġ��?
����4.
  033)1111-1234 ����  ')'������ ��ġ��?

����5.  �ʿ��ϴٸ� �Լ�2���̻��� ����Ͽ�
  02)111-1234 ����      ������ȣ ����  
            ��°��    02
            
����6.   Student���̺��� tel�÷����� ������ȣ�� �����ϼ���           


--SUBSTR( ǥ����, ������ġ[, ���ڼ�])   �ڡڡڡڡ�
--������ġ�� ù������ ��ġ�� 1
   SUBSTR(DNAME, 1, 3)=>1��°�� ù���ں��� 3����
   SUBSTR(DNAME, -3, 2)   => �ڿ��� 3��° ���� ���� 2����
                                               ����   ���� �ڿ� �ִ� ���ڴ� -1
--���ڼ��� �����ϸ� �ش� ���ڿ��� ������
   SUBSTR(DNAME, 5)=> 5��° ���ں��� ���ڿ�������
   
SELECT   DNAME ,  SUBSTR(DNAME, 3, 2)  , SUBSTR(DNAME, -3, 2)   
FROM     DEPT;

*�Լ��� �̿��Ͽ�  ���Ǹ�ɹ��� �ۼ��Ͽ� �����ϼ���
����1.   02)111-1234 ����      ������ȣ ����  
            ��°��    02
����2.   032)1111-1234 ����    ������ȣ ����
            ��°��    032



SELECT  DNAME,    LTRIM(DNAME, 'S'), RTRIM(DNAME, 'S')
FROM    DEPT
--  �μ��� S����
WHERE DNAME LIKE '%S%';



SELECT   length(DNAME) ,  length( LPAD( DNAME, 10,  '*' )   ),  
                LPAD( DNAME, 10,  '*' ),  RPAD( DNAME, 10,  '?' )
FROM    DEPT;

SELECT  '�ְ� ' || DNAME || '�μ�',   CONCAT(  DNAME,  '�μ�')
FROM   DEPT;

SELECT  LENGTH('oralce11g'), LENGTH('���ѹα�'), LENGTH('2019 !'),
              LENGTHB('oralce11g'), LENGTHB('���ѹα�'), LENGTHB('2019 !')
FROM    DUAL;


SELECT  dname, LENGTH(dname), LENGTHB(dname)
FROM   DEPT;

SELECT  dname,  INITCAP(dname), LOWER(dname), UPPER('deDt')
FROM     DEPT;

