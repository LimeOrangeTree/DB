
*���� + ��������
SELECT go.gname, go.point, gi.gname
FROM   GOGAK go, GIFT gi
WHERE  gi.gname='��Ʈ��'
       and
       go.point >= (select g_start
                         from  GIFT
                         where gname='��Ʈ��'
                        )




*JOIN(���� P224~)
=> �ټ� ���� ���̺���  ������� �Ͽ� �ս��� ��ȸ
SELECT e1.ENAME,    e1.MGR "����� EMPNO",
             e2.EMPNO "�����ȣ",    e2.ENAME 
FROM    EMP e1, EMP e2
WHERE    e1.MGR  =  e2.EMPNO(+);

SELECT   EMPNO "�����ȣ",  ENAME  
FROM      EMP;



SELECT e.STUDNO,   s.NAME,  e.TOTAL,    
             h.GRADE, h.MIN_POINT||'~'||h.MAX_POINT
FROM   STUDENT s, EXAM_01 e,   HAKJUM h
WHERE   s.studno = e.studno
                AND
                e.TOTAL    BETWEEN   h.MIN_POINT   AND    h.MAX_POINT
ORDER  BY  TOTAL  ASC;


SELECT �÷���, �÷��� AS alias
FROM   ���̺�

select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s   FULL OUTER JOIN   DEPARTMENT D
                                                   ON S.DEPTNO1=D.DEPTNO;



select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s   LEFT JOIN DEPARTMENT D
                                    ON  S.DEPTNO1=D.DEPTNO;


select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s,  DEPARTMENT D
where  S.DEPTNO1=D.DEPTNO(+);



select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s  RIGHT JOIN   DEPARTMENT D
                              ON  S.DEPTNO1=D.DEPTNO;


select  s.name AS SNAME,  s.grade, S.DEPTNO1,
           D.DEPTNO, D.DNAME
from student s,  DEPARTMENT D
where  S.DEPTNO1(+)=D.DEPTNO;

-- scott������ ���̺� ��  �л�(student)��   ����(professor) �� �̿��Ͽ�
-- �л��̸�, �г�(grade),  ��米���̸� ���
-- equi join ���
select  D.DNAME,
            s.name AS SNAME,  s.grade, 
           p.profno ,p.name AS PNAME
from student s, professor p,  DEPARTMENT D
where s.profno = p.profno
            AND
           S.DEPTNO1(+)=D.DEPTNO;

-- JOIN  ON���   --�л� �Ҽ�(�а�,�к�)   DEPARTMENT ���̺��� DEPTNO
select   D.DNAME,
            s.name AS SNAME,  s.grade, 
           p.profno ,p.name AS PNAME
from student s   INNER JOIN   professor p           ON s.profno = p.profno
                           INNER JOIN  DEPARTMENT D    ON S.DEPTNO1=D.DEPTNO;






2. ANSI JOIN����
* [INNER] JOIN  ON - p239
SELECT  E.EMPNO, E.ENAME,  E.DEPTNO,   D.DNAME,  LOWER(D.LOC)
FROM   EMP   E  INNER  JOIN   DEPT D    
                                          ON   E.deptno = D.deptno   --JOIN����
WHERE   D.LOC=  UPPER('NEW york')                                       
ORDER BY E.DEPTNO ASC;

1. equi join(�����)- ���� P234
=> ����Ŭ���� ����ϴ� ���ι���
SELECT  E.EMPNO, E.ENAME,  E.DEPTNO,   D.DNAME
FROM   EMP   E,    DEPT D
WHERE     E.deptno = D.deptno   --JOIN����
ORDER BY E.DEPTNO ASC;








