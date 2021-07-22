*�ǽ�3
�߰� Ʈ����=>
�԰� ���̺� ��ǰ�� �ԷµǸ� 
�԰� ������  ��ǰ ���̺��� �������� �߰��� Ʈ����

INSERT   INTO  product    VALUES(1,  '��Ź��',       '����������', 50,   0);
INSERT   INTO  product    VALUES(2,  '����û����', '����������', 100, 0);
INSERT   INTO  product    VALUES(3,  '������',        '�ÿ�������', 160, 0);

--Ʈ���� ����
CREATE     OR  REPLACE   TRIGGER       trg_ipgoINS
    AFTER   insert       ON    ipgo
    FOR      EACH    ROW
DECLARE
    v_cnt     NUMBER;    -- ��ǰ���̺��� Ư����ǰ��ȣ�� �������� �����ϱ� ���� ����
BEGIN    
    SELECT  COUNT(*)
    INTO       v_cnt
    FROM     product
    WHERE  pno = :NEW.pno;

    IF   (v_cnt=0)   THEN
         INSERT   INTO  product(pno,            pcount)  
                                 VALUES(:NEW.pno, :NEW.icount);
    ELSE
         UPDATE  product
         SET         pcount = pcount + :NEW.icount
         WHERE   pno     = :NEW.pno;
    END IF; 
END;
/

 select * from product;
 insert into  ipgo(ino, idate,    icount, icost, pno)
                values( 10, sysdate, 5,         40,     1 );
select * from product;   //1�� ��Ź���� �������� 0���� 5�� ����Ǵ��� Ȯ��

 insert into  ipgo(ino, idate,    icount, icost, pno)
                values( 11, sysdate, 10,         40,      4);
select * from product;

*����(���� P638)
  :OLD.     => Ʈ���Ű� ó���� ���ڵ��� ���� ���� ����
  :NEW.   => �� ����   ����



*AFTER TRIGGER �ǽ�
��) (���)���̺� ���ο� �����Ͱ� �ԷµǸ�=> ���Ի���� �����ȣ,�̸� ���� �߰�(INSERT)
     (���)���̺� ���ο� �����͸� �ڵ����� �����ϰ� �ʹ� => ���Ի���� �޿� ���� ����(UPDATE)

*TRIGGER ����
DROP    TRIGGER  trg_sal;

*������̺� ����
CREATE TABLE EMP3(
    no             number,
    name        varchar2(30),
    sal             number
);

*Ʈ���� ����
CREATE     OR  REPLACE   TRIGGER       trg_sal
  AFTER     insert        ON   EMP3
BEGIN
  UPDATE  EMP3      SET   sal=300;
END;
/
SELECT * FROM EMP3;
*Ȯ��
 =>������̺�  ���ο� ������ �Է�(INSERT)
    INSERT INTO EMP3(no, name)   VALUES( 2, 'ȫ�浿2' );
     ����Ǵ� ���̺��� ���� ��ȸ�Ͽ� Ʈ���Ű� ����Ǿ����� Ȯ��
    UPDATE  EMP3      SET   sal=300;

---------------------------------------------------------
���� P643
DROP TABLE t_order purge;

CREATE                             TABLE        t_order(
    NO                  NUMBER,
    ord_code        varchar2(60),
    ord_date        date
);

INSERT  INTO  t_order
VALUES(  2, 'Ʈ������'  ,   SYSDATE   );

SELECT    NO,  ord_code, TO_CHAR(  ord_date, 'MM/DD HH24:MI'   )    FROM t_order;

SELECT    SYSDATE,    TO_CHAR(  SYSDATE, 'HH24:MI'   )
FROM       DUAL;

CREATE    OR REPLACE     TRIGGER    trg_order
   BEFORE      INSERT         ON             t_order
BEGIN

    IF   (   TO_CHAR(  SYSDATE, 'HH24:MI'   )    NOT  BETWEEN '14:40'  AND   '15:50' )    THEN

          RAISE_APPLICATION_ERROR(  -20100,  '�Է� ���ð��� �ƴմϴ�'   );
    END IF;      
  
END;
/

*����(���� P621)
 RAISE_APPLICATION_ERROR ���ν���
 => ����ڰ� ������ �����ϰ�
     ����ó���� ����
     ����ο���  ��� ���ܸ� ó���ϴ� ���
     -����ڰ� ���� ������ ������ȣ�� 20000~20999�̴�



 UPDATE DEPT
 SET        LOC='����'                   ����->����
 WHERE  DEPTNO=10;

*��Ű������ TRIGGER�� ����, ���� �� ������ �� �ִ� ����:
CONN  /as sysdba
 GRANT CREATE TRIGGER TO HR;
 GRANT ALTER ANY TRIGGER TO HR;
 GRANT DROP ANY TRIGGER TO HR ;
?
* �����ͺ��̽����� TRIGGER�� ������ �� �ִ� ����:
 GRANT ADMINISTER DATABASE TRIGGER TO HR ;

SELECT * FROM USER_TRIGGERS;



*TRIGGER(Ʈ���� - ���� P636/ �����̵� 112)
���� ���α׷� ������ �ϳ��� TRIGGER�� 
���̺�, ��, ��Ű�� �Ǵ� �����ͺ��̽��� ���õ� PL/SQL ���(�Ǵ� ���ν���)���� 
���õ� Ư�� ���(Event)�� �߻��� ������ 
������(�ڵ�)���� �ش� PL/SQL ����� ����˴ϴ�

TRIGGER �� �����Ϸ��� CREATE TRIGGER, 
�����Ϸ��� ALTER TRIGGER, 
�����Ϸ��� DROP TRIGGER �� ������ �ʿ�

 DATABASE ��ü�� TRIGGER ������
 ADMINISTER DATABASE TRIGGER �ý��� ������ �ʿ�
 
 TRIGGER��ȸ
 : USER_OBJECTS, USER_TRIGGERS, USER_ERRORS ��ųʸ����� ��ȸ
 
����
 COMMIT, ROLLBACK, SAVEPOINT ����� ���Ե� �� ���ٴ� ���� �� ���