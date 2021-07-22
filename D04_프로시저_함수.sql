*ORACLE SUBPROGRAM (교재 p622/  슬라이드 94)

DECLARE
   arg_jobid    VARCHAR2(40);
   arg_jobtitle  VARCHAR2(40);
BEGIN
    select_title(  100,    arg_jobid  ,   arg_jobtitle);
    DBMS_OUTPUT.PUT_LINE( arg_jobid || '의 JOB TITLE은 ' || arg_jobtitle  );
END;
/


특정사원의 id값을 받아
해당사원의 job_title을 출력하는
프로시저를 만드세요
select_title(조회사원입력id,    job_id 출력용변수  ,  job_title출력용변수)
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
-- 특정 사원번호를 입력받아
    해당사원의   급여를 출력하는 f_sal 함수를 만드세요
    급여 =  기존급여 + (기존급여*commission_pct)

CREATE     OR REPLACE    FUNCTION   f_sal( p_empid       employees.employee_id%TYPE )
  RETURN  NUMBER  -- 명시!!
IS
  v_sal2    employees.salary%TYPE;      --프로시저내에서 사용할 변수선언  
BEGIN
        SELECT    salary+ (salary *    NVL(commission_pct, 0.1) )
        INTO        v_sal2
        FROM      employees
        WHERE   employee_id = p_empid;
    return     v_sal2;  -- 명시!!
END;
/

SELECT   employee_id,   salary,  f_sal( 100 )
FROM     employees
WHERE   employee_id = 100;



------------------------------------------------------------------------
-- FUNCTION 생성(교재 p626/ 슬라이드 99) 
CREATE     OR REPLACE    FUNCTION    f_up_sal( 
                                                            p_empid       employees.employee_id%TYPE,
                                                            p_sal             number
                                                            )
  RETURN  NUMBER  -- 명시!!
IS
  v_sal2    employees.salary%TYPE;      --프로시저내에서 사용할 변수선언  
BEGIN
        SELECT    salary+ (salary * (p_sal/100))
        INTO        v_sal2
        FROM      employees
        WHERE   employee_id = p_empid;
    return     v_sal2;  -- 명시!!
END;
/


SELECT   employee_id,    
                salary   as "급여"  , 
                f_up_sal( employee_id  , 250 )   as "예상급여" ,
                TO_CHAR(   f_up_sal( employee_id  , 250 ) , '999,999,999'    )   as "형식변경" 
FROM    employees
WHERE        salary> (SELECT    AVG(salary)
                                   FROM    employees       )
ORDER  BY   salary  DESC;  




==============================================================
-- 사원번호와 급여인상률을 입력받아서
   변경된 사원의 급여를 출력하는 프로시저를 만드세요
   *급여계산식 :   급여+ (급여 * (?/100))
   
실행시     up_sal2(100,   250)

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

        DBMS_OUTPUT.PUT_LINE( v_empid || '사원의 변경후 예상급여=' ||  v_sal2 );
END;        
/

EXEC     up_sal2(100,250);

----------------------------------------------------------------------------------------
-- 사원테이블에서 사원ID값을 받아서
   해당 사원의 급여를 기존급여에 100을 추가하는 프로시저를 만드세요

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
        
        DBMS_OUTPUT.PUT_LINE( v_empid || '사원의 변경후 급여=' ||  v_sal );
END;
/

--프로시저 실행
EXECUTE  up_sal(  100 );

----------------------------------------------------------------------------------------
*PROCEDURE 생성 및 수정(교재 p623/ 슬라이드 95)
-- 
CREATE   [OR REPLACE]   PROCEDURE    프로시저명[(
            매개변수명     [IN | OUT | INOUT ]    데이터타입, 
            ...,
            매개변수명     [IN | OUT | INOUT ]    데이터타입
            )]
IS  |   AS
  --선언부(변수, 커서)
  [ 변수명     데이터타입;      --프로시저내에서 사용할 변수선언  
    변수명     데이터타입 := 초기값;
  ]
BEGIN
   ~~~
END;
/

-- 프로시저 조회
SELECT   * | text
FROM      user_source
WHERE   name='UP_SAL';         --WHERE   name='프로시저명';

SELECT    * | object_name, object_type, created
FROM       user_objects
WHERE     OBJECT_TYPE='PROCEDURE';  --데이터딕셔너리에는 대문자입력










SET SERVEROUTPUT ON;