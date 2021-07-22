*실습3
추가 트리거=>
입고 테이블에 상품이 입력되면 
입고 수량을  상품 테이블의 재고수량에 추가는 트리거

INSERT   INTO  product    VALUES(1,  '세탁기',       '조은제조사', 50,   0);
INSERT   INTO  product    VALUES(2,  '공기청정기', '상쾌제조사', 100, 0);
INSERT   INTO  product    VALUES(3,  '에어컨',        '시원제조사', 160, 0);

--트리거 생성
CREATE     OR  REPLACE   TRIGGER       trg_ipgoINS
    AFTER   insert       ON    ipgo
    FOR      EACH    ROW
DECLARE
    v_cnt     NUMBER;    -- 상품테이블의 특정상품번호의 재고수량을 저장하기 위한 변수
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
select * from product;   //1번 세탁기의 재고수량이 0에서 5로 변경되는지 확인

 insert into  ipgo(ino, idate,    icount, icost, pno)
                values( 11, sysdate, 10,         40,      4);
select * from product;

*참고(교재 P638)
  :OLD.     => 트리거가 처리한 레코드의 원래 값을 저장
  :NEW.   => 새 값을   포함



*AFTER TRIGGER 실습
예) (사원)테이블에 새로운 데이터가 입력되면=> 신입사원의 사원번호,이름 내용 추가(INSERT)
     (사원)테이블에 새로운 데이터를 자동으로 생성하고 싶다 => 신입사원의 급여 내용 변경(UPDATE)

*TRIGGER 삭제
DROP    TRIGGER  trg_sal;

*사원테이블 생성
CREATE TABLE EMP3(
    no             number,
    name        varchar2(30),
    sal             number
);

*트리거 생성
CREATE     OR  REPLACE   TRIGGER       trg_sal
  AFTER     insert        ON   EMP3
BEGIN
  UPDATE  EMP3      SET   sal=300;
END;
/
SELECT * FROM EMP3;
*확인
 =>사원테이블에  새로운 데이터 입력(INSERT)
    INSERT INTO EMP3(no, name)   VALUES( 2, '홍길동2' );
     연계되는 테이블의 내용 조회하여 트리거가 실행되었는지 확인
    UPDATE  EMP3      SET   sal=300;

---------------------------------------------------------
교재 P643
DROP TABLE t_order purge;

CREATE                             TABLE        t_order(
    NO                  NUMBER,
    ord_code        varchar2(60),
    ord_date        date
);

INSERT  INTO  t_order
VALUES(  2, '트리거후'  ,   SYSDATE   );

SELECT    NO,  ord_code, TO_CHAR(  ord_date, 'MM/DD HH24:MI'   )    FROM t_order;

SELECT    SYSDATE,    TO_CHAR(  SYSDATE, 'HH24:MI'   )
FROM       DUAL;

CREATE    OR REPLACE     TRIGGER    trg_order
   BEFORE      INSERT         ON             t_order
BEGIN

    IF   (   TO_CHAR(  SYSDATE, 'HH24:MI'   )    NOT  BETWEEN '14:40'  AND   '15:50' )    THEN

          RAISE_APPLICATION_ERROR(  -20100,  '입력 허용시간이 아닙니다'   );
    END IF;      
  
END;
/

*참고(교재 P621)
 RAISE_APPLICATION_ERROR 프로시저
 => 사용자가 에러를 정의하고
     예외처리부 없이
     실행부에서  즉시 예외를 처리하는 방식
     -사용자가 지정 가능한 에러번호는 20000~20999이다



 UPDATE DEPT
 SET        LOC='서울'                   뉴욕->서울
 WHERE  DEPTNO=10;

*스키마에서 TRIGGER를 생성, 변경 및 삭제할 수 있는 권한:
CONN  /as sysdba
 GRANT CREATE TRIGGER TO HR;
 GRANT ALTER ANY TRIGGER TO HR;
 GRANT DROP ANY TRIGGER TO HR ;
?
* 데이터베이스에서 TRIGGER를 생성할 수 있는 권한:
 GRANT ADMINISTER DATABASE TRIGGER TO HR ;

SELECT * FROM USER_TRIGGERS;



*TRIGGER(트리거 - 교재 P636/ 슬라이드 112)
서브 프로그램 단위의 하나인 TRIGGER는 
테이블, 뷰, 스키마 또는 데이터베이스에 관련된 PL/SQL 블록(또는 프로시저)으로 
관련된 특정 사건(Event)이 발생될 때마다 
묵시적(자동)으로 해당 PL/SQL 블록이 실행됩니다

TRIGGER 를 생성하려면 CREATE TRIGGER, 
수정하려면 ALTER TRIGGER, 
삭제하려면 DROP TRIGGER 의 권한이 필요

 DATABASE 전체의 TRIGGER 조작은
 ADMINISTER DATABASE TRIGGER 시스템 권한이 필요
 
 TRIGGER조회
 : USER_OBJECTS, USER_TRIGGERS, USER_ERRORS 딕셔너리들을 조회
 
주의
 COMMIT, ROLLBACK, SAVEPOINT 명령이 포함될 수 없다는 점도 꼭 기억