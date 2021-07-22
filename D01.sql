
-- PL/SQL   연습용 테이블생성(PPT7. 15슬라이드 )
CREATE TABLE PL_TEST(
 NO         NUMBER,
 NAME    VARCHAR2(50)
);

-- PL/SQL   연습용 시퀀스생성(PPT7. 15슬라이드 )
CREATE     SEQUENCE  PL_SEQ
START WITH   1
INCREMENT   BY  1;

-- 참고    시퀀스의 다음값 사용
--           시퀀스명.NEXTVAL

INSERT    INTO  PL_TEST
VALUES(  PL_SEQ.NEXTVAL    ,   'SQL입력'    );


BEGIN
    INSERT    INTO  PL_TEST
    VALUES(  PL_SEQ.NEXTVAL    ,   'PLSQL입력'    );
END;
/

SELECT * FROM  PL_TEST;

