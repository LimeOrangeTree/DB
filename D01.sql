
-- PL/SQL   ������ ���̺����(PPT7. 15�����̵� )
CREATE TABLE PL_TEST(
 NO         NUMBER,
 NAME    VARCHAR2(50)
);

-- PL/SQL   ������ ����������(PPT7. 15�����̵� )
CREATE     SEQUENCE  PL_SEQ
START WITH   1
INCREMENT   BY  1;

-- ����    �������� ������ ���
--           ��������.NEXTVAL

INSERT    INTO  PL_TEST
VALUES(  PL_SEQ.NEXTVAL    ,   'SQL�Է�'    );


BEGIN
    INSERT    INTO  PL_TEST
    VALUES(  PL_SEQ.NEXTVAL    ,   'PLSQL�Է�'    );
END;
/

SELECT * FROM  PL_TEST;

