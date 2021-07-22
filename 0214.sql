SELECT *
	FROM   DEPT
	WHERE  LOC IS NOT NULL;



SELECT *
	FROM   DEPT
	WHERE dname like '%#_%'  escape '#' 
				OR
	      dname like '%@%%'  escape '@'; 


INSERT INTO DEPT(deptno,dname)
VALUES(53,'����_��');
INSERT INTO DEPT(deptno,dname)
VALUES(54,'ȸ%���');

commit;

INSERT INTO ���̺��[(�÷���,�÷���,...)]
	VALUES(��,��,..);

	INSERT INTO DEPT(deptno)
	VALUES(52);



INSERT INTO DEPT(deptno)
	VALUES(NULL);
cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

INSERT INTO DEPT(deptno, dname, loc)
	VALUES(52,NULL,'');


INSERT INTO DEPT(deptno, dname)
VALUES(51,'�����κ�');


-- �μ�(DEPT)���̺�
INSERT INTO DEPT(deptno, dname, loc)
	VALUES(51,'���ۿ�Ʈ��ĸ���ְ����ߺ�','����');



-- �̸� 2��°���ڷ� M�� ���Ե� ���
SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename  LIKE '_M%';

-- �̸��� M�� ���Ե� ���
SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename  LIKE '%M%';



SELECT empno,ename,hiredate,sal,deptno
FROM   emp
WHERE  ename='SMITH';



-- �Ʒ������� �ƴ� ��� ��ȸ
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE   sal not in(800, 1100, 1200, 1500);

-- �޿��� 800, 1100, 1200,1500�� �����ȸ
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE   sal in(800, 1100, 1200, 1500);

SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE 	deptno>=20
	OR
	sal   >=3000
ORDER BY sal ASC;


-- �μ���ȣ�� 20�̻��̸鼭 �޿��� 3000�̻�
-- �޿� ���� �޴� ������� ���
-- �����ȣ,�����,�Ի���,�޿� ��ȸ
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE 	deptno>=20
	AND
	sal   >=3000
ORDER BY sal ASC;


-- �޿� 1250�̻�~ 3000����  �޿���
-- �޿� ���� �޴� ������� ���
-- �����ȣ,�����,�Ի���,�޿� ��ȸ
SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE sal between 1250 and 3000
ORDER BY sal ASC;

SELECT empno,ename,hiredate,sal,deptno
FROM emp
WHERE sal not between 1250 and 3000
ORDER BY sal ASC;

--�Ի�����  80/12/17
-- �����ȣ,�����,�Ի���,�޿� ��ȸ
SELECT empno,ename,hiredate,sal
FROM emp
WHERE hiredate > '80/12/17' ;


--SELECT * | �÷���
--FROM    ���̺��
--WHERE ����
--ORDER BY ���ı��� ���