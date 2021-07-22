*SYNONYM(���Ǿ� ���� P490)
 hr.emp
 hr.employees
 USER��.��������
 hr.employees_department_view

*SEQUENCE(���� P482) 
=> ���� ������Ģ�� �ִ� �������� �Ϸù�ȣ

��������.NEXTVAL : ������
��������.CURRVAL:  ���簪

INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_1' );--1
INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_2' );--2
SELECT   EMPNO,ENAME  FROM EMP  ORDER BY EMPNO ASC;  -- 1, 2
INSERT INTO   EMP(EMPNO,   ENAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_4' ); --4
SELECT   EMPNO,ENAME  FROM EMP  ORDER BY EMPNO ASC;

INSERT INTO   DEPT(DEPTNO,  DNAME)  VALUES(  emp_seq.NEXTVAL  ,  'ins_3' );--3
SELECT * FROM DEPT;  

1) ����
CREATE SEQUENCE emp_seq
 INCREMENT BY 3
 --START WITH 100
 MAXVALUE 9999
 NOCYCLE;


CREATE  OR  REPLACE    SEQUENCE sequence_name 
 [INCREMENT BY n] <- ������ ��ȣ�� ���� ������ �⺻���� 1
 [START WITH n] <- ������ ���۹�ȣ�� �⺻���� 1
 [MAXVALUE n | NOMAXVALUE] <- ���� ������ ������ �ִ밪
 [MINVALUE n | NOMINVALUE] <-CYCLE�� ��� ���� ���۵Ǵ� ��
                               �����ϴ� Sequence �� ��� �ּҰ�
 [CYCLE | NOCYCLE] <- ������ ��ȣ�� ��ȯ ����� ������ ����
 [CACHE n | NOCACHE] <- ������ �����ӵ��� �����ϱ� ���� ĳ�̿��� ����



2) ����
ALTER  SEQUENCE emp_seq
 INCREMENT BY 30
 --START WITH 100  ����!!!
 MAXVALUE 9999
 NOCYCLE;

3) ����
DROP SEQUENCE emp_seq;


====================================================
*VIEW(���� P414)

*  VIEW ��ȸ
SELECT *
FROM    USER_VIEWS;

1) VIEW���� �� ����
CREATE   [ OR REPLACE  ]   VIEW ���
AS
SUBQUERY;

*�ζ��� ��(���� p421)
SELECT  D.DEPTNO,  D.DNAME,  SP.SNAME,  SP.PNAME
FROM    DEPARTMENT D,  
              ( SELECT S.studno, S.name AS SNAME,   P.name AS PNAME, P.email,    P.DEPTNO AS DNO
                FROM   STUDENT S   JOIN   PROFESSOR P   ON  S.profno = P.profno
                WHERE S.profno IS NOT NULL  ) SP
WHERE  D.DEPTNO=SP.DNO;              



*���� ��(���� p419)
 --v_student_prof   view�� �����ϼ���
    ��米���� �����ϴ� �л��鿡 ���Ͽ�   studno, sname, pname ������

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


*�ܼ� ��(���� P414)
�����߻�    insufficient privileges
�ذ���    �ʿ��� ������ �ο������� �ȴ�
����          �並 �����ϱ� ���ؼ��� ������ �ʿ��ϴ�
conn /as sysdba
grant  create view
to      scott;
    

-- �Ի�⵵�� 1981�� ����� ����     81/01/01~81/12/31
    emp���̺��� �����ȣ,�����,�޿�, �Ի�⵵ ������
    �޿� ���������� 
    view_emp_sal  VIEW�����Ͻÿ�.
    �� �� �޿���  ��Ȯ���̸� 0���� ��ü
    
����         must name this expression with a column alias

SELECT   *  FROM    emp;
SELECT   *  FROM    view_emp_sal;

-- emp����  ������ �Ի�����   '99/01/10'���� �������� ���� �� (��,���̺�)Ȯ��
UPDATE  emp
SET         hiredate =  '99/01/10'
WHERE   ename='����';

-- emp����  ������ �޿��� 9900���� �������� ���� �� (��,���̺�)Ȯ��
UPDATE  emp
SET         sal = 9900
WHERE   ename='����';

--  view_emp_sal�� ���� ������ �޿��� 4900���� ���� �� (��,���̺�)Ȯ��
UPDATE  view_emp_sal
SET         esal = 4900
WHERE   ename='����';


INSERT INTO    view_emp_sal( eno, ename, esal , ehire )
VALUES( 9110, '����' , 900, '1981/05/26');


INSERT INTO    view_emp_sal( eno, ename, esal , ehire )
VALUES( 9100, '��' , 900, '1981/05/26');
COMMIT;

CREATE    OR REPLACE       VIEW  view_emp_sal( eno, ename, esal , ehire )
AS
SELECT  empno, ename,  sal, hiredate
FROM     emp
WHERE  TO_CHAR(hiredate, 'YYYY')='1981'
ORDER BY sal asc;


------------------------------------------
2) VIEW����
DROP   VIEW  VIEW_EMP_SAL;

------------------------------------------
*DDL
1) ����
CREATE ��üŸ�� ��ü��
~~

2) ����
ALTER  ��üŸ�� ��ü��
~~

3) ����
DROP ��üŸ�� ��ü��
~













