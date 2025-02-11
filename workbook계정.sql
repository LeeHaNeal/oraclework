select * from tb_department;

select department_name"학과 명",category"계열" from tb_department;

select department_name || '의 정원은'|| capacity || '명 입니다.' from tb_department;

select * from tb_student;

select student_name from tb_student where student_no in('A513079','A513090','A513091','A513110','A513119') order by student_name desc;

select department_name, category from tb_department where capacity >=20 and capacity <=30; 

select * from tb_professor;

select professor_name from tb_professor WHERE department_no IS NULL;

select student_name from tb_student where coach_professor_no is null;

select * from tb_class;

select preattending_class_no from tb_class where preattending_class_no is not null order by preattending_class_no desc;

select distinct category from tb_department; 


select student_no , student_name, student_ssn from tb_student where student_no like 'A2%' and student_address like '전주%' and absence_yn ='N' order by student_name ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select* from tb_student;
--1
select student_no,student_name,entrance_date from tb_student where department_no ='002' order by entrance_date;

select * from tb_professor;
--2
select professor_name, professor_ssn from tb_professor where length(professor_name) != 3;
--3
select professor_name,
floor(months_between(sysdate, 
to_date( case  when substr(professor_ssn, 8, 1) = '1' then '19' || substr(professor_ssn, 1, 6)
        when substr(professor_ssn, 8, 1) = '3' then '20' || substr(professor_ssn, 1, 6) end, 'YYYYMMDD')) / 12) as "나이"
from tb_professor
where  SUBSTR(professor_ssn, 8, 1) = '1'
order by 나이 asc ; 
--4
select substr(professor_name,2,2)
from tb_professor   
where length(substr(professor_name,2,2)) != 3;
--5




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 도서관리 프로그램을 만들기 위한 테이블들 만들기
-- 이때, 제약조건에 이름을 부여할 것, 각 컬럼에 주석달기
-- 1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
--   컬럼  :  
--  PUB_NO(출판사번호) NUMBER -- 기본키(PUBLISHER_PK) 
--   PUB_NAME(출판사명) VARCHAR2(50) -- NOT NULL(PUBLISHER_NN)
--   PHONE(출판사전화번호) VARCHAR2(13) - 제약조건 없음
--  3개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_PUBLISHER (
    PUB_NO NUMBER,
    PUB_NAME VARCHAR (50) NOT NULL,
    PHONE VARCHAR (20),
    
    PRIMARY KEY (PUB_NO)
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사';

INSERT INTO TB_PUBLISHER VALUES (1, '강아지', NULL);
INSERT INTO TB_PUBLISHER VALUES (2, '고양이', '010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES (3, '호랑이', NULL);

-- 2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
--  컬럼  :  
--  BK_NO (도서번호) NUMBER -- 기본키(BOOK_PK)
--   BK_TITLE (도서명) VARCHAR2(50) -- NOT NULL(BOOK_NN_TITLE)
--   BK_AUTHOR(저자명) VARCHAR2(20) -- NOT NULL(BOOK_NN_AUTHOR)
--   BK_PRICE(가격) NUMBER
--   BK_PUB_NO(출판사번호) NUMBER -- 외래키(BOOK_FK) (TB_PUBLISHER 테이블을 참조하도록)
--   이때 참조하고 있는 부모데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
--  5개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_BOOK (
    BK_NO NUMBER,
    BK_TITLE VARCHAR (50) NOT NULL,
    BK_AUTHOR VARCHAR (20) NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    FOREIGN KEY (BK_PUB_NO) REFERENCES TB_PUBLISHER (PUB_NO)
        ON DELETE CASCADE,    
    PRIMARY KEY (BK_NO)
);
COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서 번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '작가';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';

INSERT INTO TB_BOOK VALUES (1, '하늘', '강아지', 10000, 1);
INSERT INTO TB_BOOK VALUES (2, '땅', '고양이', 20000, 2);
INSERT INTO TB_BOOK VALUES (3, '바다', '호랑아', 40000, 1);
INSERT INTO TB_BOOK VALUES (4, '산', '개구리', 15000, 3);
INSERT INTO TB_BOOK VALUES (5, '해변', '참새', 25000, 2);

--3. 회원에 대한 데이터를 담기위한 회원 테이블 (TB_MEMBER)
--   컬럼명 : 
--   MEMBER_NO(회원번호) NUMBER -- 기본키(MEMBER_PK)
--   MEMBER_ID(아이디) VARCHAR2(30) -- 중복금지(MEMBER_UQ)
--   MEMBER_PWD(비밀번호)  VARCHAR2(30) -- NOT NULL(MEMBER_NN_PWD)
--   MEMBER_NAME(회원명) VARCHAR2(20) -- NOT NULL(MEMBER_NN_NAME)
--   GENDER(성별)  CHAR(1)-- 'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)
--   ADDRESS(주소) VARCHAR2(70)
--   PHONE(연락처) VARCHAR2(13)
--   STATUS(탈퇴여부) CHAR(1) - 기본값으로 'N' 으로 지정, 그리고 'Y' 혹은 'N'으로만 입력되도록 제약조건(MEMBER_CK_STA)
--   ENROLL_DATE(가입일) DATE -- 기본값으로 SYSDATE, NOT NULL 제약조건(MEMBER_NN_EN)
---- 5개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_MEMBER (
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR (30) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR (30) NOT NULL,
    MEMBER_NAME VARCHAR (20) NOT NULL,
    GENDER CHAR (1) CHECK (GENDER IN ('M', 'F')),
    ADDRESS VARCHAR (70),
    PHONE VARCHAR (20),
    STATUS CHAR (1) DEFAULT 'N' CHECK (STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL
);
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

INSERT INTO TB_MEMBER VALUES (1, 'user01', 'pass01', '강아지', 'M', '서울시', '010-1111-1111', 'N', '20/11/23');
INSERT INTO TB_MEMBER VALUES (2, 'user02', 'pass02', '고양이', 'F', '강원도', NULL, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES (3, 'user03', 'pass03', '호랑이', 'F', '경기도', '010-2222-2222', 'N', '22/1/13');
INSERT INTO TB_MEMBER VALUES (4, 'user04', 'pass04', '개구리', 'M', '경상남도', NULL, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES (5, 'user05', 'pass05', '참새', 'M', '서울시', '010-3333-3333', 'Y', '21/10/3');

--4. 어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
--  컬럼  :  
--  RENT_NO(대여번호) NUMBER -- 기본키(RENT_PK)
--   RENT_MEM_NO(대여회원번호) NUMBER -- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
--         이때 부모 데이터 삭제시 자식 데이터 값이 NULL이 되도록 옵션 설정
--   RENT_BOOK_NO(대여도서번호) NUMBER -- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
--         이때 부모 데이터 삭제시 자식 데이터 값이 NULL값이 되도록 옵션 설정
--   RENT_DATE(대여일) DATE -- 기본값 SYSDATE
--   - 3개 정도 샘플데이터 추가하기
CREATE TABLE TB_RENT (
    RENT_NO NUMBER PRIMARY KEY,
    RENT_MEM_NO NUMBER REFERENCES TB_MEMBER (MEMBER_NO) ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER REFERENCES TB_BOOK (BK_NO) ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';
INSERT INTO TB_RENT VALUES (1, 2, 1, '20/11/21');
INSERT INTO TB_RENT VALUES (2, 3, 5, '21/2/11');
INSERT INTO TB_RENT VALUES (3, 2, 2, '20/4/5');

-- 8.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
ORDER BY CLASS_NAME;

-- 10.
SELECT G.STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT), 1) "전체평점"
FROM TB_GRADE G
JOIN TB_STUDENT S ON(G.STUDENT_NO = S.STUDENT_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY G.STUDENT_NO, S.STUDENT_NAME
ORDER BY 1;

-- 12.
SELECT STUDENT_NAME, TERM_NO AS TERM_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE TERM_NO LIKE '2007%'
  AND CLASS_NAME = '인간관계론';
  
-- 13.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN tb_class_professor USING(CLASS_NO)
LEFT JOIN tb_department USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
   AND PROFESSOR_NO IS NULL;

-- 14.
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정')
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;

-- 15.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME 학과이름, AVG(POINT) 평점
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- 16.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
    AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY CLASS_NO;

-- 18.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                                    FROM TB_GRADE
                                    JOIN TB_STUDENT USING(STUDENT_NO)
                                    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                                    WHERE DEPARTMENT_NAME = '국어국문학과'
                                    GROUP BY STUDENT_NO);

-- 19.
SELECT DEPARTMENT_NAME "계열 학과명",  ROUND(AVG(POINT), 1)
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE CATEGORY = (SELECT CATEGORY
                                FROM TB_DEPARTMENT
                                WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

----------------------------------------------------------------------------------
--== ==============================[DML]==============================
-- 1번
CREATE TABLE TB_CLASS_TYPE(
    TB_NO NUMBER,
    TB_TYPE VARCHAR2(20)
);

INSERT INTO TB_CLASS_TYPE VALUES(01,'전공필수');
INSERT INTO TB_CLASS_TYPE VALUES(02,'전공선택');
INSERT INTO TB_CLASS_TYPE VALUES(03,'교양필수');
INSERT INTO TB_CLASS_TYPE VALUES(04,'교양선택');
INSERT INTO TB_CLASS_TYPE VALUES(05,'논문지도');
-- 2번
CREATE TABLE TB_학생일반정보( 
    TB_NO NUMBER,
    TB_NAME VARCHAR2(50),
    TB_ADD VARCHAR2(200)
);
-- 3번
CREATE TABLE TB_국어국문학과(
      TB_ID NUMBER,
     TB_NAME VARCHAR2(50),
     TB_NO CHAR(20),
     TB_PROFESSOR VARCHAR2(50) );
-- 4번    
UPDATE TB_DEPARTMENT
SET CAPACITY= CAPACITY*1.1;
-- 5번    
     
     
