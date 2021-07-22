exact fetch returns more than requested number of rows
-- Ŀ��  ���� P601(�����̵� )
DECLARE
    v_eid           employees.employee_id%TYPE;
    v_fname      employees.first_name%TYPE;
    --Ŀ������
    CURSOR   c1   IS
                    SELECT      employee_id, first_name
                    FROM         employees
                    WHERE       department_id=30;
BEGIN
    --open Ŀ��
    OPEN  c1;
    
    LOOP   
    --FETCH Ŀ��
        FETCH c1      INTO     v_eid,  v_fname;
        EXIT    WHEN    c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_eid || '�� ������� ' ||  v_fname);
     END LOOP; 
     
     DBMS_OUTPUT.PUT_LINE('30�� �ٹ�������� ' ||  c1%ROWCOUNT );
     --close Ŀ��
    CLOSE  c1;
END;
/


---------------------------------------------------------
-- ���� P600(�����̵� 65)
FOR counter IN [REVERSE] start . . end LOOP
  Statement1 ;
  Statement2 ;
��
END LOOP ;

BEGIN
    -- end���� start���� 1�� ���ҵǴ� ���� counter������ ����
   FOR counter IN  REVERSE  0..5 LOOP
      dbms_output.put_line(  'counter������='  ||  counter ) ;
    END LOOP ;   
END;
/



BEGIN
    -- start���� end���� 1�� �����Ǵ� ���� counter������ ����
   FOR counter IN  0..5 LOOP
      dbms_output.put_line(  'counter������='  ||  counter ) ;
    END LOOP ;   
END;
/




-------------------------------------------------------
-- ���� (�����̵� 64)
WHILE ���� ���ۺ��� ������ ���� �˻��� �� PL/SQL ������ �����ϰ� �˴ϴ�. 

DECLARE 
    no1     NUMBER:=0;
BEGIN
    --WHILE   ����      LOOP
    WHILE   no1<5      LOOP               --����
        dbms_output.put_line(  no1  );  --����
        no1 := no1 + 1;                         -- 1�� ����       --�ڹٿ����� ++������
        /*�ڹٿ����� ���� ����
            no1 = no1 + 1;
            no1 +=  1;
        */
    END LOOP;    
END;
/



-- ���� (�����̵� 62)
BASIC LOOP ���� ���߿� ������ �˻�
�� BASIC LOOP ���� ������ Ʋ���� PL/SQL ������ 1ȸ�� ������ ������ =>  JAVA�� DO while�� ����
DECLARE 
    no1     NUMBER:=0;
BEGIN
    LOOP
        dbms_output.put_line(  no1  );  --����
        no1 := no1 + 1;                    
        EXIT    WHEN    no1>5;             --����
    END LOOP;    
END;
/



-- ���� (�����̵� 54�� ������ ������ ����)
DECLARE
   --�����
   v_locid          NUMBER(6);
   v_city            Locations.city%TYPE;
  v_counid      locations.country_id%TYPE;
   v_counName   VARCHAR2(100);
BEGIN
   --�����
    SELECT      location_id, city,     country_ID
    INTO           v_locid,       v_city,  v_counid
    FROM         Locations
    WHERE      location_id=1000;
 
  IF  (v_counid='IT') THEN
        v_counName := '��Ż����';
    ELSIF (v_counid='US') THEN
        v_counName := '����';
    ELSIF (v_counid='CA') THEN
        v_counName := 'ĳ����';
    ELSIF (v_counid='CN') THEN    
        v_counName := '�߱�';
    ELSE
        v_counName := '��Ÿ����';
  END IF;
       
    dbms_output.put_line( v_locid || ' - ' ||  v_city || ' - ' || v_counid ||'==>'||v_counName);
END;
/

 Locations���̺���
 location_id�� 1000�� ����
 location_id, city, country_name���
 country_id�� IT�̸�  ��Ż����
              US�̸�  ����
              CA      ĳ����
              CN      �߱�    ���   
       

SET SERVEROUTPUT ON;