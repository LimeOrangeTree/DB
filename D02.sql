--�����̵� 45
DECLARE
   --�����
   TYPE  emp_record_type   IS RECORD
   (emp_id        employees.employee_id%TYPE,
    f_name       employees.first_name%TYPE,
    e_sal           employees.salary %TYPE);
   v_rec1  emp_record_type;    
BEGIN
   --�����
    select    employee_id, first_name , salary  
    INTO      v_rec1
    
    from     employees
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE( v_rec1.emp_id||'�� ������ �޿�='|| v_rec1.f_name||' '||v_rec1.e_sal);
END;
/

--�����̵� 42
DECLARE
   --�����
   v_row     pl_employees3%ROWTYPE;
BEGIN
   --�����
    select    employee_id, first_name , salary  
    INTO      v_row
    
    from      pl_employees3
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE( v_row.employee_id||'�� ������ �޿�='|| v_row.first_name||' '||v_row.salary);

END;
/


DECLARE
   --�����
   vno          pl_employees3.employee_id%TYPE;
   vname    pl_employees3.first_name%TYPE;
   vsal         pl_employees3.salary%TYPE;
BEGIN
   --�����
    select    employee_id, first_name , salary  
    INTO     vno,                vname,        vsal
    
    from      pl_employees3
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE('���ID=' || vno);
    DBMS_OUTPUT.PUT_LINE('�����=' || vname);
    DBMS_OUTPUT.PUT_LINE('����޿�=' || vsal);
END;
/

SET  SERVEROUTPUT  ON ;

*PPT �����̵�40 ����
drop table pl_employees3;

CREATE TABLE pl_employees3
AS
SELECT employee_id, first_name , salary
FROM employees;










