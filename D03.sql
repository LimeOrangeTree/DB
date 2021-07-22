exact fetch returns more than requested number of rows
-- 커서  교재 P601(슬라이드 )
DECLARE
    v_eid           employees.employee_id%TYPE;
    v_fname      employees.first_name%TYPE;
    --커서선언
    CURSOR   c1   IS
                    SELECT      employee_id, first_name
                    FROM         employees
                    WHERE       department_id=30;
BEGIN
    --open 커서
    OPEN  c1;
    
    LOOP   
    --FETCH 커서
        FETCH c1      INTO     v_eid,  v_fname;
        EXIT    WHEN    c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_eid || '인 사원명은 ' ||  v_fname);
     END LOOP; 
     
     DBMS_OUTPUT.PUT_LINE('30번 근무사원수는 ' ||  c1%ROWCOUNT );
     --close 커서
    CLOSE  c1;
END;
/


---------------------------------------------------------
-- 교재 P600(슬라이드 65)
FOR counter IN [REVERSE] start . . end LOOP
  Statement1 ;
  Statement2 ;
…
END LOOP ;

BEGIN
    -- end부터 start까지 1씩 감소되는 값이 counter변수에 저장
   FOR counter IN  REVERSE  0..5 LOOP
      dbms_output.put_line(  'counter변수값='  ||  counter ) ;
    END LOOP ;   
END;
/



BEGIN
    -- start부터 end까지 1씩 증가되는 값이 counter변수에 저장
   FOR counter IN  0..5 LOOP
      dbms_output.put_line(  'counter변수값='  ||  counter ) ;
    END LOOP ;   
END;
/




-------------------------------------------------------
-- 교재 (슬라이드 64)
WHILE 문은 시작부터 조건을 먼저 검사한 후 PL/SQL 문장을 수행하게 됩니다. 

DECLARE 
    no1     NUMBER:=0;
BEGIN
    --WHILE   조건      LOOP
    WHILE   no1<5      LOOP               --조건
        dbms_output.put_line(  no1  );  --실행
        no1 := no1 + 1;                         -- 1씩 증가       --자바에서는 ++연산자
        /*자바에서는 위의 식을
            no1 = no1 + 1;
            no1 +=  1;
        */
    END LOOP;    
END;
/



-- 교재 (슬라이드 62)
BASIC LOOP 문은 나중에 조건을 검색
즉 BASIC LOOP 문은 조건이 틀려도 PL/SQL 문장이 1회는 실행이 되지만 =>  JAVA의 DO while과 유사
DECLARE 
    no1     NUMBER:=0;
BEGIN
    LOOP
        dbms_output.put_line(  no1  );  --실행
        no1 := no1 + 1;                    
        EXIT    WHEN    no1>5;             --조건
    END LOOP;    
END;
/



-- 교재 (슬라이드 54와 유사한 문제로 변형)
DECLARE
   --선언부
   v_locid          NUMBER(6);
   v_city            Locations.city%TYPE;
  v_counid      locations.country_id%TYPE;
   v_counName   VARCHAR2(100);
BEGIN
   --실행부
    SELECT      location_id, city,     country_ID
    INTO           v_locid,       v_city,  v_counid
    FROM         Locations
    WHERE      location_id=1000;
 
  IF  (v_counid='IT') THEN
        v_counName := '이탈리아';
    ELSIF (v_counid='US') THEN
        v_counName := '미쿡';
    ELSIF (v_counid='CA') THEN
        v_counName := '캐나다';
    ELSIF (v_counid='CN') THEN    
        v_counName := '중국';
    ELSE
        v_counName := '기타국가';
  END IF;
       
    dbms_output.put_line( v_locid || ' - ' ||  v_city || ' - ' || v_counid ||'==>'||v_counName);
END;
/

 Locations테이블에서
 location_id가 1000인 곳의
 location_id, city, country_name출력
 country_id가 IT이면  이탈리아
              US이면  미쿡
              CA      캐나다
              CN      중국    출력   
       

SET SERVEROUTPUT ON;