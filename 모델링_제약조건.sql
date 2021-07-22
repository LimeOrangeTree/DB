*CONSTRAINT(��������)(����  p332)
- Primary Key : �⺻Ű . nn+uk=>���̺���
- Not Null : null�� ���x
- Unique   : ������ �� . �ߺ��� ���x
- Foreign Key : �ܷ�Ű. null���, �ߺ������
- Check : ����

*�������� ��ȸ
SELECT     constraint_name,  constraint_type, table_name
FROM        USER_CONSTRAINTS
WHERE     table_name='EMP2'; -- ����:���̺���� �빮��




conn hr/hr
--�÷��߰�
����>ALTER  TABLE ���̺��
ADD �÷��� ������Ÿ��(ũ��); 

--���������߰�(���� P338 ����)/ ���� / ����
����>ALTER  TABLE ���̺��
-ADD     [CONSTRAINT �������Ǹ�]    ��������(�÷���);
-DROP   CONSTRAINT �������Ǹ�
-MODIFY  [CONSTRAINT �������Ǹ�]    ��������(�÷���)


--emp2���̺��� ename�÷��� nn�������� �ֱ�(���� P339 ����)
ALTER TABLE EMP2
MODIFY    ename CONSTRAINT   EMP2_ENAME_NN  NOT NULL;

--DROP  CONSTRAINT EMP2_ENAME_NN;

--emp2���̺��� PK����
ALTER TABLE EMP2
DROP PRIMARY KEY;

--emp2���̺��� sal�÷��� check�������� ����
ALTER TABLE EMP2
DROP  CONSTRAINT EMP2_SAL_CK;

-- emp2���̺��� ssn�÷���  unique���������� �߰�
ALTER  TABLE emp2
ADD      CONSTRAINT emp2_ssn_uk     unique(ssn);

����> CREATE   TABLE  ���̺��(
    �÷���     ������Ÿ��(ũ��)  [CONSTRAINT �������Ǹ�] [��������]
);

--�������Է�
INSERT INTO  emp2    VALUES(  1, 'ȫ�浿' ,    100,  'û��',    '801123-1234567', '2015/06/20', '����');
INSERT INTO  emp2    VALUES(  2, '��������' , 100,  '������', '751123-2234567', '2019/02/26', '����');
INSERT INTO  emp2    VALUES(  3, '�ں���' ,    500,  '����',    '911101-1234567', SYSDATE, null);
COMMIT;

--���������� �ִ� ��� ���̺����

DROP TABLE DEPT;
CREATE TABLE   DEPT(
 dno            number(5)    CONSTRAINT  dept_dno_pk  Primary Key,
 dname      varchar2(20),
 loc            varchar2(50)
);

DROP       TABLE EMP2;
CREATE   TABLE  emp2(
    eno            number(5)        CONSTRAINT emp2_eno_pk         primary key,       /*�����ȣ*/
    ename       varchar2(50)     CONSTRAINT emp2_ename_nn   not null,               /*�����*/
    sal             number(10)       default(50)  CONSTRAINT emp2_sal_ck          check( sal>=0  )  ,    /*�޿�*/
    job             varchar2(50)     CONSTRAINT emp2_job_ck          check(  job  in('û��','������','����','����')  ),  /*����*/
    ssn             char(14)           CONSTRAINT emp2_ssn_nn         not null
                                               CONSTRAINT emp2_ssn_uk         unique,        /*�ֹι�ȣ*/
    hiredate     date                default SYSDATE   ,              /*�Ի���*/
    address     varchar2(100),  /*�ּ�*/
    dno            number(5)
);

-- DEPT���̺� �������Է�
INSERT INTO   DEPT  VALUES( 10, '���ߺ�', '����' );
INSERT INTO   DEPT  VALUES( 20, '�����κ�', '����' );
INSERT INTO   DEPT  VALUES( 30, '�ְ����ߺ�', '���' );

--  EMP2���̺� �������Է�
-- �������� ����X      SAL�� HIREDATE�÷��� ���� ������NULL
INSERT INTO   EMP2(eno, ename, job, ssn, address,dno )
VALUES(1, 'ȫ�浿',  '����', '801123-1234567', '����', 10 );

INSERT INTO   EMP2(eno, ename, job, ssn, address,dno )
VALUES(2, '�̱浿',  '����', '900525-2234567', '����', NULL );

- �μ����̺��� 10�� �μ�����
DELETE FROM  DEPT     WHERE   DNO=10;

- 10�� �μ��� 11���� �ٲ�
UPDATE DEPT
SET        dno=11
WHERE  dno=10;

--�μ���ȣ 30�� �ٹ��� ���
DELETE FROM EMP2   WHERE   DNO=30;

--�̱浿�� �μ���ȣ�� 50���� ����
UPDATE EMP2
SET        dno=50
WHERE  ename='�̱浿';

integrity constraint (HR.EMP2_DNO_FK) violated - parent key not found
                              

emp2�� dno�÷���   DEPT���̺��� dno�� �����ϴ�  fk
ALTER TABLE emp2
ADD   CONSTRAINT emp2_dno_fk    foreign key(dno)  references DEPT(dno);

* ON DELETE CASCADE �ɼ� ���ǻ���
  : �����ϴ� �θ�Ű���� �����ؾ� �Ѵ�.
ALTER TABLE emp2
ADD   CONSTRAINT emp2_dno_fk    foreign key(dno)  references DEPT(dno) ON DELETE CASCADE;

-- �μ����̺��� 10���μ� ����
DELETE FROM  DEPT    WHERE   DNO=10;

*���� ������ ���̺��� DML �۾��� ���ǻ���
            DEPT(�θ�)   /  EMP(�ڽ�)
�μ���ȣ       pk        -   fk     
�Է�             O        /   �θ�Ű�� ���翩��
����       �ڽķ��ڵ� ���翩�� /  �θ�Ű�� ���翩��
����       �ڽķ��ڵ� ���翩�� / O




-- ���������� ���� ���̺����
CREATE   TABLE  emp(
    eno            number(5),       /*�����ȣ*/
    ename       varchar2(50),    /*�����*/
    sal             number(10),     /*�޿�*/
    job             varchar2(50),   /*����*/
    ssn             char(14),        /*�ֹι�ȣ*/
    hiredate     date,              /*�Ի���*/
    address     varchar2(100)  /*�ּ�*/
);





*���̺����
DROP    TABLE  ���̺�� [CASCADE CONSTRAINT];

* unique/primary keys in table referenced by foreign keys�̸�  ���̺�����Ұ��ϴ�
  ������ ������ ��������(FK)�� �����ϸ� ������ �����ϴ�
  CASCADE CONSTRAINT��  �������踦 �����ϸ鼭   �θ����̺��� �����ϴ� �ɼ�.
DROP      TABLE DEPT   CASCADE CONSTRAINT;






