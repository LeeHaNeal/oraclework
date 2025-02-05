/*
    <함수 function>
    전달된 컬럼값을 읽어들여 함수를 실행한 결과를 반환
    
    -단일 행 함수 : n개의 값을 읽어들여 n개의 결과값 반환(매 행마다 함수 실행)
    - 그룹 함수 : n개의 값을 읽어들여 1개의 결과값 반환(그룹별로 함수 실행)

    >>select절에 단일행 함수와 그룹함수를 함꼐 사용할 수 없음
    
    >> 함수식을 기술할 수 있는 위치 : select절 , where절, oreder by 절
*/
----------------------------------단일행함수-----------------------------
--=========================================================================
--                  <문자 처리 함수>
--========================================================================
/*
    *LENGTH/LENGTHB = NUMBER로 반환
    
    LENGTH(컬럼)('문자열') : 해당 문자열의 글자수를 반환
    LENGTHB(컬럼)('문자열') : 해당 문자열의 byte를 반환
        - 한글 : XE버전일 때 => 1글자당 3byte(ㄱ,ㅏ, 등도 1글자의 해당)
                EE버전일 때 => 1글자당 2byte
        - 그외 : 1글자당 1byte
*/

select length('오라클'),lengthb('오라클') from dual; --dual : 오라클에서 제공하는 가상 테이블

select length('oracle'),lengthb('oracle') from dual;

select emp_name,length(emp_name),lengthb(emp_name),email,length(email),lengthb(email) from employee;

---------------------------------------------------
/*
    *INSTR : 문자열로부터 특정 문자의 시작위치(INDEX)를 찾아서 반환(반환형:NUMBER)
    -OREACLE은INDE번호는 1번부터 시작,찾는 문자가 없을 때 0 반환
    
    INSET(컬럼|'문자열','찾고자하는문자',[찾을위치의 시작값,[순번]])
    -찾을 위치값
    1. 앞에서부터 찾기(기본값)
    -1 : 뒤에서부터 찾기
*/

select instr('JAVASCRIPTJAVEORACLE','A') from dual;
select instr('JAVASCRIPTJAVEORACLE','A',-1) from dual;
select instr('JAVASCRIPTJAVEORACLE','A',3) from dual;

select instr('JAVASCRIPTJAVEORACLE','A',1,3) from dual;



select email , instr(email,'_')"_위치", instr(email,'@')"@위치" from employee;


/*
    *SUbSTR : 문자열에서 특정 문자열을 추출하여 반환(반환형 : CHARACHTER)
    
    SUBSTR('문자열',position,[LENGTH]
     - POSITION : 문자열을 추출할 시작 위치 INDEX
     - LENGTH : 추출한 문자의 갯수(생략시 맨 마지막까지 추출)
*/


select substr('ORACLEHTMLCSS',7) from dual;
select substr('ORACLEHTMLCSS',7,4) from dual;
select substr('ORACLEHTMLCSS',1,6) from dual;
select substr('ORACLEHTMLCSS',-3) from dual;


-- employee테이블에서 주민번호에서 성별만 추출하여 사원명,주민번호,성별을 조회

select emp_name,emp_no,substr(emp_no,8,1)성별 from employee;


select emp_name,emp_no,substr(emp_no,8,1)성별 
from employee 
where substr(emp_no,8,1) in ('2','4');

select emp_name,emp_no,substr(emp_no,8,1)성별 
from employee 
where substr(emp_no,8,1) in ('1','3');

-- emlpoyee테이블에서 email에서 아이디만 추출하여 사원명 , email,아이디를 조회
select * from employee;

select emp_name,email,SUBSTR(email, 1,INSTR(email, '@')-1)아이디 from employee;
    
-------------------------------------------------------------------

/*
    LPAD / RPAD : 문자열을 조회할 때 통일감 있게 자리수에 맞춰서 조회하고자 할 때 (반환형 : character)
    
    LPAD/ RPAD('문자열',최종적으로 반환할 문자의 길이(ex: 3 = 3글자), [덧붙이고자하는 문자])
    문자열의 덧붙이고자하는 문자를 오니쪽 또는 오른쪽에 덧붙여서 최종 n길이 만큼의 문자열 반환
*/


select emp_name ,lpad(email,25) from employee;

select emp_name,lpad(email,25,'#') from employee;

select emp_name, rpad(email,25,'#') from employee;

-- employee테이블에서 주민번호를 123456-1******** 형식 사번,사원명,주민번호(형식에맞춰)조회

select emp_id,emp_name,rpad(substr(emp_no,1,8),14,'*')주민번호 from employee;


--------------------------------------------------------------------------------------------------------------------------

/*
    *LTRIM/RTRIM : 문자열에서 특정 문자를 제거한 나머지 반환(반환형 : CHARACHTER)
    *TRIM : 문자열의 앞/뒤 양쪽에 있는 특정 문자를 제거한 나머지 반환
    
    [표현법]
    LTRIM / RTRIM('문자열',[제거하고자하는문자])
    TRIM([LEADING|TRALIG|BOTH] 제거하고자하는문자들 FROM '문자열' ) = 제거하고자하는 문자는 1개만 가능

*/

select ltrim('     TJOEUN     ') ||'더조은'from dual; -- 제거할 문자를 안 넣으면 공백 제거
select rtrim('     TJOEUN     ') ||'더조은'from dual;
select trim(both,'     TJOEUN     ') ||'더조은'from dual;

select ltrim('javajavascriptjsp','java')from dual;
select ltrim('bababaaaabbcbabbaferdsfzxcs','abc') from dual;

select trim(leading 'A' from 'AAABKADA:SAAAA') from dual;
select trim(trailing 'A' from 'AAABKADA:SAAAA') from dual;
select trim(both 'A' from 'AAABKADA:SAAAA') from dual;
select trim( 'A' from 'AAABKADA:SAAAA') from dual; -- both 기본값 생략 가능

------------------------------------------------------------------------------------

/*

    *LOWER / UPPER / INITCAP : 문자열을 모두 대문자로 혹은 소문자로 , 첫글자만 대문자로 변환(반환형 : CHARACTER)
    
    [표현법]
    lower / upper / initcap('문자열')
*/

select lower('JAVA JAVASCRIPT Oracle') from dual;
select upper('JAVA JAVASCRIPT Oracle') from dual;
select initcap('JAVA JAVASCRIPT Oracle') from dual;

------------------------------------------------------------------------------------

/*
    CONCAT : 문자열 2개를 전달받아 하나로 합친 문자 반환
    
    [표현법]
    CONCAT('문자열','문자열')
*/

select  concat('Oracle','오라클')from dual;
select 'oracle'||'오라클' from dual;
-- select  concat('Oracle','오라클','재미있어요')from dual;  << 3개는 불가능함 최대 2개
select 'oracle'||'오라클'||'재미있어요' from dual;

------------------------------------------------------------------------------------

/*
    *REPLACE :  기존무낮열을 새로운 문자열로 바꿈
    
    [표현법]
    replace('문자열','기존문자열','바꿀문자열')

*/

select emp_name,email,replace(email,'tjoeun.or.kr','naver.com')바꾼이메일  from employee;


--==========================================================================================
--                                                                      <숫자 처리 함수>
--==========================================================================================
/*
    *ABS: 숫자의 절대값을 구해주는 함수
    [표현법]
    ABS(NUMBER)
  */
select abs(-10) from dual;
select abs(-34.123) from dual;
----------------------------------------------------------------------
/*
    *MOD : 두수를 나눈 나머지값을 반환해주는 함수
    [표현법]
    MOD(NUMBER,NUMBER)
*/

select mod(10,3) from dual;
----------------------------------------------------------------------
/*
    *ROUND : 반올림한 결과를 반환해주는 함수
    
    [표현법]
    round(number,[위치])
*/
select round(1234.567)from dual;
select round(12.345) from dual;
select round(1234.56789,2) from dual;
select round(12.34,4)from dual;
select round(1234.5678,-2) from dual;

----------------------------------------------------------------------
/*
    *CEIL : 무조건 올림
    
    [표현법]
    ceil(number)
*/

select ceil(123.45)from dual;
select ceil(-123.45) from dual;
----------------------------------------------------------------------
/*
    *FLOOR : 무조건 내림
    
    [표현법]
    FLOOR(number)
*/
select floor(123.45)from dual;
select floor(-123.45) from dual;
----------------------------------------------------------------------
/*
    *TRUNC : 위치 지정 가능한 버림처리 함수
    
    [표현법]
    TRUNC(number,[위치])
*/

select trunc(123.789) from dual;
select trunc(123.789,1) from dual;
----------------------------------------------------------------------

--==========================================================================================
--                            <날짜 처리 함수>
--==========================================================================================
/*
    *SYSDATE : 시스템 날짜 및 시간 반환
*/
select sysdate from dual;
----------------------------------------------------------------------
/*
    *MONTHS_BETWEEN(date1,date2) : 두 날짜 사이의 개월 수 반환
*/
--employee에서 오늘날짜까지 근무 일수
select emp_name,hire_date,sysdate-hire_date 근무일수 from employee;

select emp_name,hire_date,ceil(sysdate-hire_date)근무일수 from employee;

select emp_name,hire_date,months_between(sysdate,hire_date)근무개월수 from employee;

----------------------------------------------------------------------
/*
    *ADD_MONTHS(DATE,NUMBER):특정 날짜에 해당 숫자만큼의 개월 수를 더해 그 날짜를 반환
*/

select add_months(sysdate,1) from dual;

-- employee테이블에서 사원명 입사일 정직원이 된 날짜 (입사일에서 6개월 후) 조회

select * from employee;

select emp_name,hire_date,add_months(hire_date,6) from employee;
----------------------------------------------------------------------
/*  
    *NEXT_DAY(DATE,요일(문자|숫자)) : 특정 날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
*/
select sysdate,next_day(sysdate,'월요일') from dual;
select sysdate,next_day(sysdate,'금요일') from dual;
select sysdate,next_day(sysdate,'금') from dual;

-- 1:일요일
select sysdate,next_day(sysdate,2) from dual;

select sysdate,next_day(sysdate,'friday') from dual; -- 오류 현쟁 언어가 korea이기 때문

--언어변경
alter session set nls_language = american; -- 영어
alter session set nls_language = korean; -- 한국어
----------------------------------------------------------------------
/*
    *LAST_DAY(DATE): 해당 월의 마지막 날짜를 반환해주는 함수
*/
    select last_day(sysdate) from dual;

-- employee에서 사원명 입사일 입사한 달의 마지막 날짜 조회
select emp_name,hire_date,last_day(hire_date) from employee;
----------------------------------------------------------------------
/*
    *EXTRACT : 특정 날짜로부터 년|월|일 값을 추출하여 반환해주는 함수 (반환형 : NUMBER)
    
    EXTRACT(YEAR FROM DATE) : 년도만 추출
    EXTRACT(MONTH FROM DATE) : 월만 추출
    EXTRACT(DAY FROM DATE) : 일만 추출
*/

SELECT emp_name, extract(year from hire_date)입사년,extract(month from hire_date)입사월,extract(day from hire_date)입사일 from employee order by 2,3,4;

--==========================================================================================
--                            <형변환 함수>
--==========================================================================================
/*
    *TO_CHAR : 숫자나 날짜를 문자타입으로 변환시켜주는 함수
    
    [표현법]
    TO_CHAR(숫자|날짜,[포맷])
*/
-------------------------숫자타입 => 문자타입
/*
    9 : 해당 자리의 숫자를 의미한다.
        - 값이 없을 경우 소수점 이상은 공백, 소수점 이하는 0으로 표시함
    0 : 해당 자리의 숫자를 의미한다.
        - 값이 없을 경우 0으로 표시하며, 숫자의 길이를 고정적으로 표시할 때 주로 사용
    FM : 해당자리에 값이 없을경우 자리차지하지 않음.
*/
select to_char(1234) from dual;
select to_char(1234,'999999') from dual; -- 6칸 공간 확보, 왼쪽 정렬 빈칸은 공백
select to_char(1234,'000000') from dual; -- 6칸 공간 확보, 왼쪽 정렬 빈칸은 0으로 채움
select to_char(1234,'L99999') from dual; -- 현재 설정된 나라(LOCAL)의 화폐단위(빈칸 공백) : 오른쪽 정렬

select to_char(1234,'L99,999') from dual; -- 3자리마다 ,(컴마)

--employee 테이블에서 사원명 급여(\11,111,111) 연봉(\111,111,111) 조회
select emp_name,
to_char(salary,'L99,999,999')급여,
to_char(salary*12,'L99,999,999')연봉
from employee;

select to_char(123.456,'FM999990.999') , to_char(1234.56,'FM9990.99'),to_char(0.1000,'FM9999.999'), to_char(0.1000,'FM9990.999') from dual;

------------------------------------------날짜 타입 => 문자 타입
-- 시간
select to_char(sysdate,'AM HH:MM:SS')  from dual; -- 12시간제 형식
select to_char(sysdate,'AM HH24:MM:SS')  from dual; -- 24시간제 형식

-- 날짜
select to_char(sysdate,'YYYY-MM-DD DAY DY')  from dual; 
select to_char(sysdate,'MOn,YYYY')  from dual; 

select to_char(sysdate,'YYYY"년" MM"월" DD"일" DAY')오늘 from dual;
select to_char(sysdate,'DL') from dual;

-- employee테이블에서 입사일(25-03-20) 

select to_char(hire_date,'YY-MM-DD') from employee;

select to_char(hire_date,'YYYY"년" MM"월" DD"일') from employee;

select to_char(hire_date,'YY"년"MM"월"DD"일"') from employee;

-- 년도
/*
    yy는 무조건 앞에 '20'이 붙는다
    rr는 50년을 기준으로 50보다 작으면 앞에 '20'을 붙이고,50보다크면 '19'를 붙인다
*/
select to_char(sysdate,'YYYY'), to_char(sysdate,'YY'), to_char(sysdate,'RRRR') from dual;

-- 월
select to_char(sysdate,'MM'), to_char(sysdate,'MON'), to_char(sysdate,'MONTH'),to_char(sysdate,'RM') from dual;

-- 일
select to_char(sysdate,'DDD'), to_char(sysdate,'DD'), to_char(sysdate,'D') from dual;

----------------------------------------------------------------------
/*
    *TO_DATE : 숫자 또는 문자 타입을 날짜 타입으로 변환
    
    To_DATE(숫자|문자,[포멧])
*/

select to_date(20241230) from dual;
select to_date(241230) from dual;

-- select to_date(050101) from dual; -- 앞이 0일때 오류
select to_date('050101') from dual; -- 앞이 0일때는 문자형태로 넣어줘야한다

select to_date('070204 142530','YYMMDD HHMMDD') from dual; -- 오류 12시간제로 출력 14시는 없음
select to_date('070204 142530','YYMMDD HH24MMDD') from dual; -- 변환후 사용

select to_char(to_date('070204 022530','YYMMDD HHMISS'),'YY-MM-DD HH:MM:SS') from dual;

select to_date('040325','YYMMDD') from dual;
select to_date('980630','YYMMDD') from dual; -- 현재 세기로 반영

select to_date('040325','RRMMDD') from dual;
select to_date('980630','RRMMDD') from dual; -- 50미만일 경우 현재세기, 50이상일경우 이전 세기 반영
--------------------------------------------------------------
/*
    * To_NUMbER : 문자타입을 숫자타입으로 변환
    
    TO_NUMBER(문자,[포멧])
*/
select to_number('012341234') from dual;
select '10000000'+'5000000' from dual; -- 오라클은 자동 형변환 됨
select to_number('1,000,000','9,999,999')+ to_number('5,000,000','9,999,999') from dual;
--==========================================================================================
--                            <NULL 처리 함수>
--==========================================================================================
/*
    NVL(컬럼,해당컬럼이 NULL일경우 반환 할 값)
*/
select emp_name,bonus,NVL(bonus,0) from employee;

-- 전사원의 이름 보너스포함 연봉 조회
select emp_name,NVL(salary*(1+bonus)*12,0) from employee;

select emp_name,salary*(1+NVL(bonus,0))*12 from employee;

-- 사원명 , 부서코드(부서가 없으면 '부서없음') 
select * from employee;

select emp_name,NVL(dept_code,'부서없음')from employee;
-------------------------------------------------------------------
/*
    *NVL2(컬럼,반환값1,반환값2)
    -컬럼에 값이 존재하면 반환값1
    -컬럼에 값이 존재하지 않으면 반환값2
*/
select emp_name,NVL2(dept_code,'부서있음','부서없음')from employee;

-- employee 테이블에서 사원명 급여 보너스 성과급(보너스를 받는사람은 30%를 주고 보너스를 못받는사람은 10%)
select emp_name,salary,bonus,nvl2(bonus,salary*0.3,salary*0.1) as 성과급 from employee;

---------------------------------------------------------------------------------------------------------
/*
    * NULLIF(비교대상1, 비교대상2)
      - 두개의 값이 일치하면 NULL반환
      - 두개의 값이 일치하지 않으면 비교대상1의 값 반환
*/
SELECT NULLIF('123','123') FROM DUAL;
SELECT NULLIF('123','345') FROM DUAL;
--==========================================================================================
--                            <선택함수>
--==========================================================================================
/*
    DECODE(비교하고자하는 대상(컬럼|산순연산|함수식|),비교값1,결과값1,비교값2,결과값2...) << 표현식
    
    switch(비교대상){
    case 비교값1:
        결과값1
        break;
        case 비교값2:
        결과값2
    }
*/

-- 사번 사원명 주민번호 성별(남,여)
select emp_id,emp_name,emp_no,decode(substr(emp_no,8,1),'1','남자','2','여자','3','남자',',4','여자')as 성별 from employee; 
select* from employee;
-- 사원명 직급코드 기존급여 인상된급여
/*
    J7 : 10%인상
    J6 : 15%인상
    J5 : 20%인상
    그외 : 5%
*/
select emp_name, job_code,salary,decode(job_code,'J7',salary*1.1,'67',salary*1.15,'J5',salary*1.2,salary*1.05)as인상된급여 from employee;

----------------------------------------------------------------------------------------------
/*
    *CASE WHEN THEN
        END
        
    CASE WHEN 조건식1 THEN 결과값1   << 표현식
         WHEN 조건식2 THEN 결과값2
         ....
         ELSE 결과값 
    END
    -----------------------------------     
    IF(조건식){ 조건식이 참일때 실행}
    ELSE IF(조건식){조건이 참일 때 실행}
    ELSE IF(조건식){조건이 참일 때 실행}
    ....
    ELSE(실행문)
    ----------------------------------------
*/
-- 사원명 급여 등급(급여에 따라 등급을 매긴다(5백만원 이상이면 '고급', 5백~3백 '중급', 나머지 '초급')
select emp_name, salary, case when salary>=5000000 then'고급' when salary>=3000000 then '중급' else '초급' end as 등급 from employee;


--==========================================================================================
--                            <그룹함수>
--==========================================================================================
/*
    *SUM(숫자타입의 컬럼) : 해당 컬럼 값들의 총 합계를 반환해주는 함수
*/
--전사원의 총 급여의 합
select sum(salary) from employee;
-- 남자사원의 총 급여의 합
select sum(salary)"남자사원 급여의합" from employee 
 -- where substr(emp_no,8,1) = '1' or substr(emp_no,8,1) = '3';
where substr(emp_no,8,1) in ('1','3');

-- 부서코드가 D5인 사원의 연봉의 총합
select sum(salary*12) from employee where dept_code = 'D5';
-- 부서코드가 D5인 사원의 보너스를 포함한 연봉의 총합
select sum(salary*nvl(1+bonus,1)*12)"D5인 사원의 보너스포함 연봉의 총합" from employee where dept_code = 'D5';

-- 전사원의 총 급여의 합 형식 \000,000,000
select to_char(sum(salary),'L999,999,999')"총급여의 합" from employee;
------------------------------------------------------------------

/*
    AVG(숫자타입의 컬럼) : 해당 컬럼값의 평균을 반환해주는 함수
*/
select avg(salary) from employee;

select round(avg(salary)) from employee;
select round(avg(salary),2) from employee;

-------------------------------------------------------------------
/*
    MIN(모든타입의 컬럼) : 해당 컬럼값들 중 가장 작은값을 반환해주는 함수
    MAX(모든타입의 컬럼) : 해당 컬럼값들 중 가장 큰값을 반환해주는 함수
*/
select min(emp_name) ,min(salary),min(hire_date) from employee;

select max(emp_name) ,max(salary),max(hire_date) from employee;

-------------------------------------------------------------------
/*
    *COUNT(*|컬럼|DISTINCT 컬럼) : 행 갯수 반환
    
    COUNT(*) : 조회된 결과의 모든 행의 갯수 반환
    COUNT(컬럼) : 컬럼의 NULL값을 제외한 행의 갯수 반환
    COUNT(DISTINCT 컬럼) : 컬럼값에서 중복을 제거한 행의 갯수 반환
*/
-- 전체 사원의 수

select count(*) from employee;

-- 여자 사원의 수
select count(*) from employee where substr(emp_no,8,1)in('2','4');

-- 보너스 받는 사원의 수
select count(bonus) from employee;

-- 현재 사원들이 총 몇개의 부서에 분포되어있는지
select count(distinct(dept_code))as 부서의수 from employee;



--==========================================================================================
--                            <연습문제>
--==========================================================================================

------------------------------- 종합 문제 ----------------------------------
select * from employee;

-- 1. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
select emp_name, 
       substr(emp_no, 1, 2) as 생년, 
       substr(emp_no, 3, 2) as 생월, 
       substr(emp_no, 5, 2) as 생일
from employee;
-- 2. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
select emp_name,RPAD(SUBSTR(EMP_NO, 1, 7), 13, '*')as 주민번호 from employee;
-- 3. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--   (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
select emp_name,abs(floor(hire_date-sysdate))as근무일수1,floor(sysdate-hire_date)as근무일수2 from employee;
-- 4. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
select * from employee where mod(emp_id,2) = 1;
-- 5. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
select * from employee where MONTHS_BETWEEN(SYSDATE, hire_date) / 12 >= 20;
-- 6. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
select emp_name,TO_CHAR(SALARY, 'L99,999,999') from employee;
-- 7. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이 조회
--   (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며 
--   나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
select emp_name,dept_code,  SUBSTR(emp_no, 1, 2) || '년 ' || SUBSTR(emp_no, 3, 2) || '월 ' || SUBSTR(emp_no, 5, 2) || '일' AS 생년월일 ,
abs(floor(months_between(sysdate, to_date(substr(emp_no, 1, 6), 'YYMMDD')) / 12)) AS 나이
from employee;
-- 8. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부
--   , D6면 기획부, D9면 영업부로 처리(EMP_ID, EMP_NAME, DEPT_CODE, 총무부)
--    (단, 부서코드 오름차순으로 정렬)
select emp_id, emp_name ,dept_code,
case when dept_code='D5'then'총무부' 
     when dept_code='D6'then'기획부'
     when dept_code='D9'then'영업부' end "부서명" 
from employee where  dept_code in ('D5', 'D6','D9');

-- 9. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
--    주민번호 앞자리와 뒷자리의 합 조회
select emp_name,substr(emp_no,1,6) as 주민번호앞자리, substr(emp_no,8,14)as주민번호뒷자리,substr(emp_no,1,6)+substr(emp_no,8,14)as 앞자리와뒷자리의합 from employee;
-- 10. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
select emp_name,salary*12as연봉,bonus,(salary*bonus+salary)*12 as 보너스포함연봉 from employee where dept_code = 'D5';
-- 11. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--      전체 직원 수, 2001년, 2002년, 2003년, 2004년
select 
    count(*) as "전체 직원",
    count(case when to_char(hire_date, 'yyyy') = '2001' then 1 end) as "2001년 입사 인원",
    count(case when to_char(hire_date, 'yyyy') = '2002' then 1 end) as "2002년 입사 인원",
    count(case when to_char(hire_date, 'yyyy') = '2003' then 1 end) as "2003년 입사 인원",
    count(case when to_char(hire_date, 'yyyy') = '2004' then 1 end) as "2004년 입사 인원"
from employee;





