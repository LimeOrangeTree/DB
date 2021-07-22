--슬라이드 45
DECLARE
   --선언부
   TYPE  emp_record_type   IS RECORD
   (emp_id        employees.employee_id%TYPE,
    f_name       employees.first_name%TYPE,
    e_sal           employees.salary %TYPE);
   v_rec1  emp_record_type;    
BEGIN
   --실행부
    select    employee_id, first_name , salary  
    INTO      v_rec1
    
    from     employees
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE( v_rec1.emp_id||'의 사원명과 급여='|| v_rec1.f_name||' '||v_rec1.e_sal);
END;
/

--슬라이드 42
DECLARE
   --선언부
   v_row     pl_employees3%ROWTYPE;
BEGIN
   --실행부
    select    employee_id, first_name , salary  
    INTO      v_row
    
    from      pl_employees3
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE( v_row.employee_id||'의 사원명과 급여='|| v_row.first_name||' '||v_row.salary);

END;
/


DECLARE
   --선언부
   vno          pl_employees3.employee_id%TYPE;
   vname    pl_employees3.first_name%TYPE;
   vsal         pl_employees3.salary%TYPE;
BEGIN
   --실행부
    select    employee_id, first_name , salary  
    INTO     vno,                vname,        vsal
    
    from      pl_employees3
    where   employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE('사원ID=' || vno);
    DBMS_OUTPUT.PUT_LINE('사원명=' || vname);
    DBMS_OUTPUT.PUT_LINE('사원급여=' || vsal);
END;
/

SET  SERVEROUTPUT  ON ;

*PPT 슬라이드40 참고
drop table pl_employees3;

CREATE TABLE pl_employees3
AS
SELECT employee_id, first_name , salary
FROM employees;










