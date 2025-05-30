/*
    * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
      오라클에서 제공하는 객체(OBJECT)를 만들고(CREATE), 구조를 변경하고(ALTER)하고, 구조를 삭제(DROP) 하는 언어
      즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
      주로 DB관리자, 설계자가 사용함
      
      오라클 객체(구조) : 테이블, 뷰, 시퀀스, 인덱스, 패키지, 트리거, 프로시저, 함수, 동의어, 사용자
*/

--==============================================================
--                                                   CREATE : 객체 생성
--==============================================================
/*
    1. 테이블 생성
      - 테이블이란 : 행과 열로 구성된 가장 기본적인 데이터베이스 객체
                         모든 데이터들은 테이블을 통해 저장됨
    
    [표현식]
    CREATE TABLE 테이블명 (
            컬럼명 자료형(크기),
            컬럼명 자료형(크기),
            컬럼명 자료형,
            ...
    );
    
     * 자료형
       - 문자 (CHAR(바이트크기) | VARCHAR2(바이트크기))  -> 반드시 크기지정 해야됨
         > CHAR : 최대 2000BYTE까지 지정 가능
                       고정 길이(지정한 크기보다 적은 값이 들와도 공백으로 채워서 지정한 크기만큼 고정)
                        고정된 길이의 데이터 사용시
         > VARCHAR2 : 최대 4000BYTE까지 지정 가능
                              가변길이(들어오는 값의 크기에 따라 공간이 맞춰짐)
                              데이터의 길이 일정하지 않을 때 사용
       - 숫자(NUMBER)
       - 날짜(DATE)
*/
-- 회원에 대한 테이블 (MEMBER 생성)
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

---------------------------------------------------------------------------------------------------------
/*
    2. 컬럼에 주석 달기(컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    
    >> 잘못 작성하였을 경우 수정 후 다시 실행하면 됨
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '회원성별';
COMMENT ON COLUMN MEMBER.PHONE IS '회원전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원일';

COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com', '25/02/07');
INSERT INTO MEMBER VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com', '25/02/06');

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, 'user03', 'pwd03', '이고잉', NULL, NULL, NULL, NULL);

---------------------------------------------------------------------------------------------------------
/*
    <제약 조건>
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
      : 데이터에 결합이 없는 상태, 즉 데이터가 정확하고 유효하게 유지된 상태
      1) 개체 무결성 제약조건 : NOT NULL, UNIQUE, PRIMARY KEY 조건 위배
      2) 참조 무결성 제약조건 : FOREIGN KEY(외래키) 조건 위배
      
    * 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY, FOREIGN KEY
    
    * 제약조건을 부여하는 방식 2가지
      1) 컬럼 레벨 방식 : 컬럼명 자료형 옆에 기술
      2) 테이블 레벨 방식 : 모든 컬럼을 정의한 후 마지막 기술
*/

---------------------------------------------------------------------------------------------------------
/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 존재해야 함(즉, NULL이 들어오면 안됨)
      삽입/수정시 NULL값을 허용하지 않는다
      
      **  주의사항 : 컬럼 레벨 방식밖에 안됨
*/
-- 컬럼 레벨 방식
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com');
INSERT INTO MEM_NOTNULL VALUES(3, 'user03', 'pwd03', '이고잉', NULL, NULL, NULL);


INSERT INTO MEM_NOTNULL VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- NOT NULL 제약조건 위배 오류

INSERT INTO MEM_NOTNULL VALUES(3, 'user03', 'pwd03', '박한빛', NULL, NULL, NULL);
-- NO, ID가 중복 되었음에도 잘 추가

---------------------------------------------------------------------------------------------------------
/*
    * UNIQUE 제약 조건
      해당 컬럼에 중복된 값이 들어가서는 안됨
      컬럼값에 중복값을 제한하는 제약조건
      삽입/수정시 기존의 데이터와 동일한 중복값이 있을 때 오류 발생
      
      >> 컬럼 레벨 방식
          CREATE TABLE 테이블명(
                컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건,
                컬럼명 자료형
                ...
            );
            
       >> 테이블 레벨 방식  
          CREATE TABLE 테이블명(
                컬럼명 자료형,
                컬럼명 자료형
                ...,
                [CONSTRAINT 제약조건명] 제약조건(컬럼명),
                [CONSTRAINT 제약조건명] 제약조건(컬럼명),
            );
*/

-- 컬럼 레벨 방식
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL UNIQUE,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com');
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pwd03', '이고잉', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pwd03', '박한빛', NULL, NULL, NULL);
-- UNIQUE 제약 조건 위배


-- 테이블 레벨 방식
CREATE TABLE MEM_UNIQUE2 (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_NO),
    UNIQUE (MEM_ID)
);

-- 테이블 레벨 방식
CREATE TABLE MEM_UNIQUE3 (
    MEM_NO NUMBER CONSTRAINT NO_NULL NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT ID_NULL NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT PWD_NULL NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT NAME_NULL NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    CONSTRAINT NO_UNIQUE UNIQUE (MEM_NO),
    CONSTRAINT ID_UNIQUE UNIQUE (MEM_ID)
);

INSERT INTO MEM_UNIQUE3 VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com');
INSERT INTO MEM_UNIQUE3 VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com');
INSERT INTO MEM_UNIQUE3 VALUES(3, 'user03', 'pwd03', '이고잉', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE3 VALUES(3, 'user03', 'pwd03', '박한빛', NULL, NULL, NULL);
-- UNIQUE 제약 조건 위배





----------------------------------------------
/*
    CHECK(조건식) 제약조건
    해당 컬럼값에 들어올 수 있는 값에 대한 조건을 제시
    해당 조건에 맞는 데이터값만 입력하도록 함
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3), -- CHECK(GENDER IN('남','여')) <--  컬럼 레벨 방식
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_NO),
    CHECK(GENDER IN('남','여'))
    );
    
INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com');
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pwd02', '나순이', '영', '010-1982-2929', 'na@google.com');    
    -- CHECK 제약 조건 위배
----------------------------------------------------------------------------
 /*
    * PRIMARY KEY(기본키) 제약 조건
    테이블에서 각 행들을 식별하기 위해ㅔ 상요될 컬럼에 부여하는 제약조건(식별자 역할)
    그 컬럼에 NOT NULL + UNIQUE 제약 조건 - 검색,삭제,수정 등의 기본키의 컬럼을 이용한
    EX) 회원번호 , 학번, 사원번호, 운송장번호  , 예약번호 , 주문번호... 
    
    ** 유의 사항 : 한테이블당 오로지 한개만 설정 가능
*/   

CREATE TABLE MEM_PRIMARY(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
    );

 CREATE TABLE MEM_PRIMARY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO),
    UNIQUE(MEM_ID),
    CHECK(GENDER IN('남','여'))
    );   
    
CREATE TABLE MEM_PRIMARY3 (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR(20) PRIMARY KEY -- 오류 : PRIMARY KEY는 한개만 가능
    
);

INSERT INTO MEM_PRIMARY VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com');
INSERT INTO MEM_PRIMARY VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com');   
INSERT INTO MEM_PRIMARY VALUES(NULL, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com');   
INSERT INTO MEM_PRIMARY VALUES(2, 'user03', 'pwd03', '나순이', '여', '010-1982-2929', 'na@google.com');   
    
 
 
 
 
 /*
    * 복합키 : 기본키를 2개 이상의 컬럼을 묶어서 사용
    - 복합키 사용 예) 찜하기
    회원번호 | 상품
        1    |  A -> 1A
        1    |  A    부적합
        1    |  B -> 1B
        1    |  C -> 1C
        2    |  A -> 2A
        2    |  C -> 2C
    
 */
CREATE TABLE TB_MULTI(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO,PRODUCT_NAME)
);
 
 INSERT INTO TB_MULTI VALUES(1,'A',SYSDATE);
  INSERT INTO TB_MULTI VALUES(1,'B',SYSDATE);
  INSERT INTO TB_MULTI VALUES(2,'B',SYSDATE);
  INSERT INTO TB_MULTI VALUES(1,'B',SYSDATE); --> 오류
 
 -------------------------------------------------------
 -- 회원등급에 대한 테이블 생성
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL);
    
-- 10 : 일반회원, 20 : 우수회원, 30 : 특별회원
INSERT INTO MEM_GRADE VALUES(10,'일반회원');
INSERT INTO MEM_GRADE VALUES(20,'우수회원');
INSERT INTO MEM_GRADE VALUES(30,'특별회원');
   

-- 회원정보 테이블 생성
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --회원 등급 보관 컬럼
    );

INSERT INTO MEM VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com', NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com', 10);
INSERT INTO MEM VALUES(3, 'user03', 'pwd03', '김순이', '여', '010-1982-2929', 'na@google.com', 50);
-- 유효한 회원 등급이 아님에도 입력됨

-------------------------------------------------------
/*
    * FOREIGN KEY(외래키) 제약 조건
    다른 테이블에 존재하는 값만 들어와야 되는 컬럼에 부여되는 제약조건
    --> 다른 테이블을 참조한다라고 표현
    --> 주로 FOREIGN KEY 제약조건에 의해 테이블간의 관계가 형성됨
    
    >> 컬럼 레벨 방식
       -  컬럼명 자료형 REFERENCES 참조할 테이블명(참조할 컬럼명)
       -  컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할 테이블명(참조할 컬럼명)
        
    >> 테이블 레벨 방식
       - FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
       - [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
*/

CREATE TABLE MEM2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    );

INSERT INTO MEM2 VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com', NULL);
INSERT INTO MEM2 VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com', 10);
INSERT INTO MEM2 VALUES(3, 'user03', 'pwd03', '김순이', '여', '010-1982-2929', 'na@google.com', 50);

-- MEM_GRADE(부모테이블), MEM2(자식테이블)
---> 이때 부모테이블에서 데이터값을 삭제할 경우 문제 발생
-- 테이블 삭제시 : DELETE FROM 테이블명 WHERE 조건;

--> MEM_GRADE 테이블에서 10번 등급을 삭제 
DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;
-- 자식 테이블에 10이라는 값을 사용 하고 있기 때문에 삭제 안됨

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
-- 자식 테이블에 30 이라는 값을 사용하고 있지 않기 때문에 삭제됨

--> 자식 테이블이 값을 사용할 경우 부모테이블로 부터 무조건 삭제가 안되는 삭제제한 옵션이 걸려있음

INSERT INTO MEM_GRADE VALUES(30,'특별회원');

--------------* 삭제 옵션------------------
/*
    자식 테이블 생성시 외래키 제약조건 기술시 삭제옵션 지정가능
    - ON DELETE RESTRICTED(기본값) : 자식이 값을 사용하면 부모테이블의 값 삭제 불가
    - ON DELETE SET NULL : 부모 데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE : 부모 데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제(행 전체 삭제)
*/
DROP TABLE MEM;
DROP TABLE MEM2;
DROP TABLE MEM3;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
    -- 부모테이블의 PRIMARY KEY와 외래키 제약조건을 걸때는 컬럼명은 생략 가능(자동으로 PRIMARY KEY와 외래키를 맺음)
    );

INSERT INTO MEM VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com', NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com', 10);
INSERT INTO MEM VALUES(3, 'user03', 'pwd03', '김순이', '여', '010-1982-2929', 'na@google.com', 20);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;
-- 삭제됨. 자식테이블의 값은 NULL이 됨

INSERT INTO MEM_GRADE VALUES(10,'일반회원');

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(30) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE CASCADE);

INSERT INTO MEM VALUES(1, 'user01', 'pwd01', '홍길동', '남', '010-1234-5678', 'hong@naver.com', NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pwd02', '나순이', '여', '010-1982-2929', 'na@google.com', 10);
INSERT INTO MEM VALUES(3, 'user03', 'pwd03', '김순이', '여', '010-1982-2929', 'na@google.com', 20);
INSERT INTO MEM VALUES(4, 'user04', 'pwd04', '박순이', '여', '010-1982-2929', 'na@google.com', 10);


DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;
-- 삭제됨. 자식도 같이 삭제(행전체 삭제)
-------------------------------------------------------------------------------------------------------------
/*
    <DEFAULT 기본값>
    : 제약 조건은 아님
    컬럼에 값을 넣지 않았을 때 기본값이 들어가도록 해줄수 있음
    
    컬럼명 자료형 DEFALUT 기본값 [제약조건]
*/
CREATE TABLE MEMBER2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR(20) NOT NULL UNIQUE,
    MEM_NAME VARCHAR(30) NOT NULL,
    HOBBY VARCHAR(50) DEFAULT '없음',
    MEM_DATE DATE DEFAULT SYSDATE,
    AGE NUMBER
);

INSERT INTO MEMBER2 VALUES(1,'user01','홍길동','운동','25/02/09',25);
INSERT INTO MEMBER2 VALUES(2,'user02','김한글',NULL,NULL,NULL);
INSERT INTO MEMBER2 VALUES(3,'user03','이고잉',DEFAULT,DEFAULT,NULL);

INSERT INTO MEMBER2 (MEM_NO,MEM_ID,MEM_NAME) VALUES(4,'USER04','김빛나');


--=============================================================
--              <thoeun 계정으로 실행>  : 오른쪽 위에 계정을 변경하면 됨
--=============================================================
/*
    <SUBQUERY를 이용한 테이블 생성>
    : 테이블을 복사하는 개념
    - 테이블의 구조만 복사
    - 테이블의 구조 및 데이터 모두 복사
    
    [표현식]
    CREATE TABLE 테이블명 AS 서브쿼리;
*/
-- EMPLOYEE테이블들을 모두 복사
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
    FROM EMPLOYEE;
        --  컬럼,데이터복사
        -- 제약조건의 경우 NOT NULL만 복사됨

-- EMPLOYEE테이블들의 구조만 복사
CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE
    WHERE 1=0;

-- EMPLOYEE테이블들의 몇개의 컬럼과 연봉의 컬럼이 있는 테이블 생성
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_NO,EMP_ID,EMP_NAME,SALARY,SALARY*12
    FROM EMPLOYEE; -- 오류 : 산술, 함수식이 들어간 컬럼은 반드시 별칭 부여

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_NO,EMP_ID,EMP_NAME,SALARY,SALARY*12 연봉
    FROM EMPLOYEE;


----------------------------------------------------------------------------------
/*
    * 테이블을 다 생성한 후에 제약조건 추가
    ALTER TABLE 에티블명 변경할 내용;
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명);
    - UNIQUE : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명)
    - CHECK : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식)
    - NOT NULL : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL
*/

-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 추가
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE_COPY테이블에 DEPARTMENT 외래키 추가
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;

-- COMMENT 넣기
COMMENT ON COLUMN EMPLOYEE_COPY.EMP_ID IS '회원번호';
COMMENT ON COLUMN EMPLOYEE_COPY.EMP_NAME IS '회원이름';


-- DEFEULT MODIFY
ALTER TABLE EMPLOYEE_COPY MODIFY ENT_YN DEFAULT 'N';


--------------------------------------------------------------
/*
07.DDL 실습문제
도서관리 프로그램을 만들기 위한 테이블들 만들기
이때, 제약조건에 이름을 부여할 것.
       각 컬럼에 주석달기

1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
   컬럼  :  PUB_NO(출판사번호) NUMBER -- 기본키(PUBLISHER_PK) 
	PUB_NAME(출판사명) VARCHAR2(50) -- NOT NULL(PUBLISHER_NN)
	PHONE(출판사전화번호) VARCHAR2(13) - 제약조건 없음

   - 3개 정도의 샘플 데이터 추가하기
*/
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER PRIMARY KEY,
    PUB_NAME VARCHAR2(50) NOT NULL,
    PHONE VARCHAR2(13) 
);

INSERT INTO TB_PUBLISHER VALUES (1,'김치우','010-1234-1234');
INSERT INTO TB_PUBLISHER VALUES (2,'우동우','010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES (3,'김우치','010-3333-3333');

/*
2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
   컬럼  :  BK_NO (도서번호) NUMBER -- 기본키(BOOK_PK)
	BK_TITLE (도서명) VARCHAR2(50) -- NOT NULL(BOOK_NN_TITLE)
	BK_AUTHOR(저자명) VARCHAR2(20) -- NOT NULL(BOOK_NN_AUTHOR)
	BK_PRICE(가격) NUMBER
	BK_PUB_NO(출판사번호) NUMBER -- 외래키(BOOK_FK) (TB_PUBLISHER 테이블을 참조하도록)
			         이때 참조하고 있는 부모데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
   - 5개 정도의 샘플 데이터 추가하기
*/
CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,
    BK_TITLE VARCHAR2(50) NOT NULL,
	BK_AUTHOR VARCHAR2(20) NOT NULL,
	BK_PRICE NUMBER,
	BK_PUB_NO NUMBER,
    CONSTRAINT BOOK_FK FOREIGN KEY (BK_PUB_NO) REFERENCES TB_PUBLISHER (PUB_NO) ON DELETE CASCADE
);
INSERT INTO TB_BOOK VALUES (1,'한국 속담책','김한국',25000,1);
INSERT INTO TB_BOOK VALUES (2,'영어 속담책','김영어',25000,1);
INSERT INTO TB_BOOK VALUES (3,'일본 속담책','김일본',25000,1);
INSERT INTO TB_BOOK VALUES (4,'중국 속담책','김중국',25000,1);
INSERT INTO TB_BOOK VALUES (5,'태국 속담책','김태국',25000,1);


/*
3. 회원에 대한 데이터를 담기위한 회원 테이블 (TB_MEMBER)
   컬럼명 : MEMBER_NO(회원번호) NUMBER -- 기본키(MEMBER_PK)
   MEMBER_ID(아이디) VARCHAR2(30) -- 중복금지(MEMBER_UQ)
   MEMBER_PWD(비밀번호)  VARCHAR2(30) -- NOT NULL(MEMBER_NN_PWD)
   MEMBER_NAME(회원명) VARCHAR2(20) -- NOT NULL(MEMBER_NN_NAME)
   GENDER(성별)  CHAR(1)-- 'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)
   ADDRESS(주소) VARCHAR2(70)
   PHONE(연락처) VARCHAR2(13)
   STATUS(탈퇴여부) CHAR(1) - 기본값으로 'N' 으로 지정, 그리고 'Y' 혹은 'N'으로만 입력되도록 제약조건(MEMBER_CK_STA)
   ENROLL_DATE(가입일) DATE -- 기본값으로 SYSDATE, NOT NULL 제약조건(MEMBER_NN_EN)

   - 5개 정도의 샘플 데이터 추가하기
*/
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(30) UNIQUE,
    MEMBER_PWD VARCHAR2(30) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN('M','F')),
    ADDRESS VARCHAR2(70) , 
    PHONE VARCHAR2(13) 
    STATUS  CHAR(1) DEFAULT 'N' CHECK(STATUS IN('Y','N')),
    ENROLL_DATE DEFAULT SYSDATE NOT NULL
);


/*
4. 어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
   컬럼  :  RENT_NO(대여번호) NUMBER -- 기본키(RENT_PK)
	RENT_MEM_NO(대여회원번호) NUMBER -- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
			이때 부모 데이터 삭제시 자식 데이터 값이 NULL이 되도록 옵션 설정
	RENT_BOOK_NO(대여도서번호) NUMBER -- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
			이때 부모 데이터 삭제시 자식 데이터 값이 NULL값이 되도록 옵션 설정
	RENT_DATE(대여일) DATE -- 기본값 SYSDATE

   - 3개 정도 샘플데이터 추가하기
*/
CREATE TABLE TB_RENT(
    RENT_NO NUMBER PRIMARY KEY,
    RENT_MEM_NO NUMBER ,
    CONSTRAINT RENT_FK_MEM FOREIGN KEY (RENT_MEM_NO) REFERENCES TB_MEMBER (MEMBER_NO) ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER,
    CONSTRAINT RENT_FK_BOOK FOREIGN KEY (RENT_BOOK_NO) REFERENCES TB_BOOK (BK_NO) ON DELETE SET NULL,
    RENT_DATE DATE SYSDATE
);


-------------------------------------------------------------
CREATE TABLE TB_CATEGORY(
    TB_NAME VARCHAR2(10)
    USE_YN CHAR(1) DEFAULT 'Y' 
);

-----------
CREATE TABLE TB_CLASS_TYPE(
    TB_NO VARCHAR2(5) PRIMARY KEY,
    TB_NAME VARCHAR2(10) 
);

--------
CREATE TABLE TB_CATAGORY(
    TB_NAME VARCHAR2(10) PRIMARY  KEY
);

--------
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(10) NOT NULL;
------





