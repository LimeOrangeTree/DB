/* 사원 */
DROP TABLE NEWEMP 
	CASCADE CONSTRAINTS;

/* 부서 */
DROP TABLE NEWDEPT 
	CASCADE CONSTRAINTS;

/* 신체정보 */
DROP TABLE HEALTH 
	CASCADE CONSTRAINTS;

/* 사원 */
CREATE TABLE NEWEMP (
	EMPNO NUMBER(5) NOT NULL, /* 사원번호 */
	ENAME VARCHAR2(50) NOT NULL, /* 사원명 */
	SAL NUMBER(10,2) DEFAULT 0, /* 급여 */
	HIREDATE DATE DEFAULT SYSDATE, /* 입사일 */
	JOB VARCHAR2(30), /* 업무 */
	DEPTNO NUMBER(5) /* 부서번호 */
);

COMMENT ON TABLE NEWEMP IS '사원';

COMMENT ON COLUMN NEWEMP.EMPNO IS '사원번호';

COMMENT ON COLUMN NEWEMP.ENAME IS '사원명';

COMMENT ON COLUMN NEWEMP.SAL IS '급여';

COMMENT ON COLUMN NEWEMP.HIREDATE IS '입사일';

COMMENT ON COLUMN NEWEMP.JOB IS '업무';

COMMENT ON COLUMN NEWEMP.DEPTNO IS '부서번호';

CREATE UNIQUE INDEX EMP_EMPNO_PK
	ON NEWEMP (
		EMPNO ASC
	);

ALTER TABLE NEWEMP
	ADD
		CONSTRAINT EMP_EMPNO_PK
		PRIMARY KEY (
			EMPNO
		);

/* 부서 */
CREATE TABLE NEWDEPT (
	DEPTNO NUMBER(5) NOT NULL, /* 부서번호 */
	DNAME VARCHAR2(50), /* 부서명 */
	LOC VARCHAR2(50) /* 소재지 */
);

COMMENT ON TABLE NEWDEPT IS '부서';

COMMENT ON COLUMN NEWDEPT.DEPTNO IS '부서번호';

COMMENT ON COLUMN NEWDEPT.DNAME IS '부서명';

COMMENT ON COLUMN NEWDEPT.LOC IS '소재지';

CREATE UNIQUE INDEX PK_NEWDEPT
	ON NEWDEPT (
		DEPTNO ASC
	);

ALTER TABLE NEWDEPT
	ADD
		CONSTRAINT PK_NEWDEPT
		PRIMARY KEY (
			DEPTNO
		);

/* 신체정보 */
CREATE TABLE HEALTH (
	EMPNO NUMBER(5) NOT NULL, /* 사원번호 */
	WEIGHT NUMBER(5,2), /* 몸무게 */
	HEIGHT NUMBER(5,2), /* 키 */
	BMI NUMBER(5,2) /* BMI */
);

COMMENT ON TABLE HEALTH IS '신체정보';

COMMENT ON COLUMN HEALTH.EMPNO IS '사원번호';

COMMENT ON COLUMN HEALTH.WEIGHT IS '몸무게';

COMMENT ON COLUMN HEALTH.HEIGHT IS '키';

COMMENT ON COLUMN HEALTH.BMI IS 'BMI';

CREATE UNIQUE INDEX PK_HEALTH
	ON HEALTH (
		EMPNO ASC
	);

ALTER TABLE HEALTH
	ADD
		CONSTRAINT PK_HEALTH
		PRIMARY KEY (
			EMPNO
		);

ALTER TABLE HEALTH
	ADD
		CONSTRAINT HEALTH_WEIGHT_CK
		CHECK (WEIGHT>0);

ALTER TABLE HEALTH
	ADD
		CONSTRAINT HEALTH_HEIGHT_CK
		CHECK (HEIGHT>0);

ALTER TABLE NEWEMP
	ADD
		CONSTRAINT FK_NEWDEPT_TO_NEWEMP
		FOREIGN KEY (
			DEPTNO
		)
		REFERENCES NEWDEPT (
			DEPTNO
		);

ALTER TABLE HEALTH
	ADD
		CONSTRAINT FK_NEWEMP_TO_HEALTH
		FOREIGN KEY (
			EMPNO
		)
		REFERENCES NEWEMP (
			EMPNO
		);