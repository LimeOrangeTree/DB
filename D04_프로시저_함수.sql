*ORACLE SUBPROGRAM (���� p622/  �����̵� 94)

DECLARE
   arg_jobid    VARCHAR2(40);
   arg_jobtitle  VARCHAR2(40);
BEGIN
    select_title(  100,    arg_jobid  ,   arg_jobtitle);
    DBMS_OUTPUT.PUT_LINE( arg_jobid || '�� JOB TITLE�� ' || arg_jobtitle  );
END;
/


Ư������� id���� �޾�
�ش����� job_title�� ����ϴ�
���ν����� ���弼��
select_title(��ȸ����Է�id,    job_id ��¿뺯��  ,  job_title��¿뺯��)
CREATE     OR   REPLACE     PROCEDURE    select_title(
                          p_empid        IN     NUMBER,  
                          arg_jobid      OUT   VARCHAR2 , 
                          arg_jobtitle   OUT   VARCHAR2
                        )
IS
BEGIN
    SELECT       job_id
    INTO          arg_jobid
    FROM        employees
    WHERE     employee_id = p_empid;


     SELECT       job_title
     INTO           arg_jobtitle
     FROM         jobs
     WHERE      job_id=arg_jobid;
END;
/

----------------------------------------------------------------------------------------
-- Ư�� �����ȣ�� �Է¹޾�
    �ش�����   �޿��� ����ϴ� f_sal �Լ��� ���弼��
    �޿� =  �����޿� + (�����޿�*commission_pct)

CREATE     OR REPLACE    FUNCTION   f_sal( p_empid       employees.employee_id%TYPE )
  RETURN  NUMBER  -- ���!!
IS
  v_sal2    employees.salary%TYPE;      --���ν��������� ����� ��������  
BEGIN
        SELECT    salary+ (salary *    NVL(commission_pct, 0.1) )
        INTO        v_sal2
        FROM      employees
        WHERE   employee_id = p_empid;
    return     v_sal2;  -- ���!!
END;
/

SELECT   employee_id,   salary,  f_sal( 100 )
FROM     employees
WHERE   employee_id = 100;



------------------------------------------------------------------------
-- FUNCTION ����(���� p626/ �����̵� 99) 
CREATE     OR REPLACE    FUNCTION    f_up_sal( 
                                                            p_empid       employees.employee_id%TYPE,
                                                            p_sal             number
                                                            )
  RETURN  NUMBER  -- ���!!
IS
  v_sal2    employees.salary%TYPE;      --���ν��������� ����� ��������  
BEGIN
        SELECT    salary+ (salary * (p_sal/100))
        INTO        v_sal2
        FROM      employees
        WHERE   employee_id = p_empid;
    return     v_sal2;  -- ���!!
END;
/


SELECT   employee_id,    
                salary   as "�޿�"  , 
                f_up_sal( employee_id  , 250 )   as "����޿�" ,
                TO_CHAR(   f_up_sal( employee_id  , 250 ) , '999,999,999'    )   as "���ĺ���" 
FROM    employees
WHERE        salary> (SELECT    AVG(salary)
                                   FROM    employees       )
ORDER  BY   salary  DESC;  




==============================================================
-- �����ȣ�� �޿��λ���� �Է¹޾Ƽ�
   ����� ����� �޿��� ����ϴ� ���ν����� ���弼��
   *�޿����� :   �޿�+ (�޿� * (?/100))
   
�����     up_sal2(100,   250)

CREATE   OR REPLACE      PROCEDURE    up_sal2(
            p_empid     IN   employees.employee_id%TYPE,
            p_sal                 NUMBER
            )
IS 
    v_empid     employees.employee_id%TYPE;
    v_sal           employees.salary%TYPE;
    v_sal2          VARCHAR2(16);
BEGIN
        SELECT    employee_id,   TO_CHAR( salary+ (salary * (p_sal/100)), '999,999,999')        
        INTO        v_empid,        v_sal2
        FROM      employees
        WHERE   employee_id = p_empid;

        DBMS_OUTPUT.PUT_LINE( v_empid || '����� ������ ����޿�=' ||  v_sal2 );
END;        
/

EXEC     up_sal2(100,250);

----------------------------------------------------------------------------------------
-- ������̺��� ���ID���� �޾Ƽ�
   �ش� ����� �޿��� �����޿��� 100�� �߰��ϴ� ���ν����� ���弼��

CREATE   OR REPLACE      PROCEDURE    up_sal(
            p_empid     IN   employees.employee_id%TYPE
            )
IS 
    v_empid     employees.employee_id%TYPE;
    v_sal           employees.salary%TYPE;
BEGIN
        UPDATE  employees
        SET         salary = salary+100
        WHERE   employee_id = p_empid;
        
        SELECT    employee_id, salary
        INTO        v_empid,        v_sal
        FROM      employees
        WHERE   employee_id = p_empid;
        
        DBMS_OUTPUT.PUT_LINE( v_empid || '����� ������ �޿�=' ||  v_sal );
END;
/

--���ν��� ����
EXECUTE  up_sal(  100 );

----------------------------------------------------------------------------------------
*PROCEDURE ���� �� ����(���� p623/ �����̵� 95)
-- 
CREATE   [OR REPLACE]   PROCEDURE    ���ν�����[(
            �Ű�������     [IN | OUT | INOUT ]    ������Ÿ��, 
            ...,
            �Ű�������     [IN | OUT | INOUT ]    ������Ÿ��
            )]
IS  |   AS
  --�����(����, Ŀ��)
  [ ������     ������Ÿ��;      --���ν��������� ����� ��������  
    ������     ������Ÿ�� := �ʱⰪ;
  ]
BEGIN
   ~~~
END;
/

-- ���ν��� ��ȸ
SELECT   * | text
FROM      user_source
WHERE   name='UP_SAL';         --WHERE   name='���ν�����';

SELECT    * | object_name, object_type, created
FROM       user_objects
WHERE     OBJECT_TYPE='PROCEDURE';  --�����͵�ųʸ����� �빮���Է�










SET SERVEROUTPUT ON;