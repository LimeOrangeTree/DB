*DATA DICIONARY(������ ��ųʸ�)- ���� P287
* ����Ŭ �����ͺ��̽��� �޸� ������ ���Ͽ� ���� ���� ������
 * �� ������Ʈ���� ����ϰ� �ִ� �������� ������
 * ���� ���� ������
 * ����ڿ� ���� ������
 * �����̳� �������� , �ѿ� ���� ������
 * ����(Audit) �� ���� ������
 
 *������ ��ųʸ� ����- ���� P288
 1)DBA_ : DBA������ ���� ������ ���
 2)ALL_ : ������ ���
 3)USER_ :�Ϲ� ������ ���

CONN SCOTT/tiger
show user
SELECT * FROM USER_CONSTRAINTS;

CONN  /AS SYSDBA
SHOW USER
SELECT USERNAME    FROM    DBA_USERS;

*DDL : ��ü����
=> ����(CREATE) / ����(ALTER) /����(DROP)
=> AUTO COMMIT�ȴ�


*TABLE����(���� p267)
CREATE TALBE ���̺��(
    �÷���     ������Ÿ��(ũ��),
    �÷���     ������Ÿ��(ũ��),
    ..
    �÷���     ������Ÿ��(ũ��)
);


*TABLE�������(���� p273)
CREATE TALBE   ���纻���̺��
AS 
SELECT * FROM  �������̺��;

-- emp ���̺��� �μ��� �μ���ȣ,  �ѱ޿�, ��ձ޿�, �ο���
    emp_sal ���̺�����ϼ���
    �� �� �μ���ȣ Ȯ��,  �μ���ȣ ����
�����߻�=>> must name this expression with a column alias 
�ذ���=>> �÷��� ��Ī�� �ο��ϸ� �ȴ�
SELECT * FROM emp_sal;

-- �ϳ��� �������� ������ �̸��� ���� ��ü(object)�� ������ �� ����
   ��) scott �������� emp ���̺��� �����ϸ�  ������ �̸����� ���̺��� ������ �� ����

-- ���̺���(���� P274)
����> ALTER  TABLE ���̺��
--�߰� ADD
--���� MODIFY
--���� DROP

���� ���̺�� ����
����> RENAME  old���̺�� TO new���̺��;
--emp_hire�� emp_hiredate�� ���̺�� ����
RENAME  emp_hire TO emp_hiredate;

����  �÷��� ����(���� p277)
����> ALTER  TABLE ���̺��
         RENAME COLUMN  old�÷���  TO  new�÷���;

--emp_hire ���̺��� sal�÷����� bigo�÷������� �̸�����
ALTER  TABLE emp_hire
RENAME COLUMN  sal  TO  bigo;

*���̺� ����
-- �÷� �߰�  ���̺� ����(���� p275)
-- ����) �߰��Ǵ� �÷��� ���� �������� �߰�
--          ���� �����Ͱ� �ִٸ� �߰��Ǵ� �÷��� ���� null
����>ALTER  TABLE ���̺��
ADD �÷��� ������Ÿ��(ũ��);

-- �߰��� sal�÷��� ������Ÿ�԰� ũ�⺯��(���� p277)
-- ����) �����Ͱ� �����ϴ� �÷��� ������ ���� ���� ������Ÿ�԰� ũ�� ����
ALTER  TABLE emp_hire
MODIFY  sal  varchar2(30);

--  emp_hire���̺��   EMPNO, NAME, HIREDATE��   �÷� sal�߰�
ALTER  TABLE emp_hire
ADD sal  number(10);

select * from emp_hire;

���� delete, trucate, drop ��ɾ��� ���̺�(���� p279)

����  ���̺� TRUNCATE(���� p278)
����> TRUNCATE TABLE  ���̺��;

-- emp_hiredate ���̺��� truncate�� Ȯ��
TRUNCATE TABLE  emp_hiredate;
rollback; -- x

-- emp_sal           ���̺��� drop��       Ȯ��
DROP TABLE  emp_sal;
rollback; -- x

-- ���̺����(���� P279)
����> DROP TABLE  ���̺��;

DROP TABLE emp_sal;

SELECT * FROM emp_sal;

CREATE TABLE  emp_sal
AS
SELECT E.deptno,  D.dname ,sum(E.SAL) as totalSal,  round(avg(E.SAL),0) as avgSal, count(*) as CNT
FROM    EMP E     JOIN     DEPT D    ON    E.deptno=D.deptno
WHERE  E.deptno is not null
GROUP  BY  E.deptno,  D.dname 
ORDER  BY  E.deptno asc;

-- emp ���̺��� empno, ename, hiredate�� ������ 
    emp_hire ���̺�����ϼ���
    �� �� �����ȣ 9000�̸� ������� ����
    �� �� hiredate�� �ֱ��Ի��� ������� ���̵��� �մϴ�

SELECT * FROM emp_hire;

CREATE TABLE emp_hire
AS
SELECT empno, ename, hiredate
FROM    EMP
WHERE empno<9000
ORDER BY  hiredate DESC;


-- emp ���̺��� ����(����÷�, �÷���, Ÿ��, ũ��, ������ ���� )
CREATE TABLE   EMP_ALL
AS 
SELECT * FROM  EMP;





==================================================================
*TRANSCATION
=> DML�� �������� ����

*TRANSCATION���۾�
-COMMIT : �ϳ��� Ʈ������� �ݿ�
-ROLLBACK : �ϳ��� Ʈ������� ���
  ROLLBACK TO ������;
-SAVEPOINT : ������
 ����>  SAVEPOINT �����͸�;

--SELECT
SELECT EMPNO, ENAME, JOB
FROM    EMP;

-----INSERT
INSERT   INTO  EMP(EMPNO, ENAME, JOB)
VALUES( 9001,  'ȫ1',  '���1' );
COMMIT;------------------------------------TR �� / TR����

--SELECT
SELECT EMPNO, ENAME, JOB
FROM    EMP;

--UPDATE
UPDATE EMP
SET        ENAME='ȣȣ';
ROLLBACK;------------------------------------TR �� / TR����
COMMIT;------------------------------------TR �� / TR����
SELECT EMPNO, ENAME, JOB   FROM    EMP; ====================>1��
--INSERT
INSERT INTO EMP(EMPNO,ENAME,JOB) VALUES(9002,'ȫ2', '���2');
INSERT INTO EMP(EMPNO,ENAME)        VALUES(9003,'ȫ3');
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT  S1;=============================================>2��~~~~~~~~~

--UPDATE
UPDATE EMP    SET JOB='���33'     WHERE  ENAME='ȫ3';
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT S2;=============================================>3��

--DELETE
DELETE FROM  EMP                          WHERE  ENAME='ȫ2';
SELECT EMPNO, ENAME, JOB   FROM    EMP;
SAVEPOINT S3;=============================================>4��

ROLLBACK TO S1;
SELECT EMPNO, ENAME, JOB   FROM    EMP;
ROLLBACK TO S2;



*DML : ���������۾��

*INSERT����
INSERT INTO  ���̺��[(�÷���,...)]
VALUES(��,..);

*UPDATE����
UPDATE  ���̺��
SET          �÷���=����,.. �÷���=����
[WHERE  ����];


*DELETE����
DELETE  [FROM]   ���̺��
[WHERE  ����];



*ROWID�� INDEX(���� p336)
 : ROWID �� ����Ŭ ������ �ּ� ǥ�� ����̰� 
 ��� �����ʹ� ������ ROWID �� ������ �־ 
 �� �����͸� ã�� ������ ROWID �� �˾ƾ� �ϰ� 
 ROWID ������ ��Ƽ� ������ �ִ� ���� INDEX ��
 
 SELECT ROWNUM, ROWID, ENAME
 FROM  EMP;