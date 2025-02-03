/*
    (')홀따옴표 : 문자열을 감싸주는 기호
    (")쌍따옴표 : 컬럼명을 감싸주는 기호
*/
/*
    <select>
    데이터를 조회할때 사용하는 구문
    
    >> result set : select문을 통해 조회된 결과물(조회된 행들의 집합)
    
    (표현법)
    select 조회하고자하는 컬럼명, 컬럼명,...(원하는 컬럼갯수 만큼)
    from 테이블명;
*/

-- employee테이블에서 모든 컬럼(*)조회
select * from employee;

-- employee테이블에서 사번,이름,급여만 조회

select emp_id,emp_name,salary from employee;

-- job테이블 모두 컬럼 조회
select * from job;


select job_name from job;

select * from department;

select dept_id,dept_title from department;

select emp_name,email,phone,hire_date,salary from employee;

/*
    <컬럼값을 통한 산술연산>
    select절 컬럼명 작성부부에 산술연산 기술할 수 있음(산술연산된 결과 조회)
*/
-- employee테이블에서 사원명 , 사원의 연봉(급여*12)조회

select emp_name,salary*12 from employee;

-- employee테이블에서 사원명 , 급여,보너스,연봉,보너스가포함된 연봉 조회

select emp_name,salary,bonus,salary*12,(salary*bonus+salary)*12 from employee;
--> 산술연산 과정중 NULL값이 존재할 경우 산술연산한 결과값도 무조건 NULL값으로 나옴


-- employee테이블에서 사원명,입사일,근무일수 조회
-- date형식도 연산 가능 : 결과값은 일 단위로 나온다.
-- "오늘날짜 : sysdate

select emp_name,hire_date,sysdate-hire_date"근무날짜" from employee;
--> 근무일수에 소수점이하는 시분초 단위로 계산하기 때문



---------------------------------------------------------------------------
/*
    <컬럼명에 별칭 지정하기>
    산술 연산시 컬럼명이 산술에 들어간 수식 그대로 컬럼명이 됨, 이때 별칭을 부여할 수 있다.
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    반드시 ("")가 들어가야하는 경우
    별칭에 띄어쓰기가 있거나 특수문자가 포함되어있는 경우
*/

select emp_name"이름",salary"급여",bonus"보너스",salary*12"연봉(원)",(salary*bonus+salary)*12"보너스포함 연봉" from employee;

/*
    <리터럴>
    임의로 지정한 문자열을 컬럼처럼 넣을 수 있음
    
    select절에 리터럴을 넣으면 마치 테이블사에 존재하는 데이터처럼 조회 가능
    조회된 result set의 모든 행에 반복적으로 같이 출력
*/
-- employee 테이블에서 사번 ,사원명 , 급여,원 조회

select emp_id,emp_name,salary,'원'as단위 from employee;

-- employee 테이블에서 사번 ,사원명 , 급여,원,보너스,% 조회
select emp_id,emp_name,salary,'원'as단위,bonus,'%' 단위 from employee;

/*
    <연결 연산자 :||>
    여러 컬럼값들을 마치 하나의 컬럼인것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
*/

-- employee테이블에서 사번,사원명,급여를 하나의 컬럼으로 조회

select emp_id || emp_name || salary"하나의 컬럼" from employee;

-- ???의 월급은 ???원 입니다 1 컬럼으로 조회
select emp_name ||'의 월급은'||salary || '원 입니다.' from employee;

-- employee테이블에서 사원명,급여(원),으로 조회
select emp_name,salary||'원'"급여" from employee;

/*
    <distinct>
    컬럼에 중복된 값들은 한번씩만 표시
*/

-- employee테이블에서 직급코드 조회

select distinct job_code from employee;

-- employee테이블에서 부서코드의 중복제거한 데이터 조회
select distinct dept_code from employee;

-- 유의사항 : discinct는 select절에서 딱 한번만 기술 가능
/*
    오류
    select distinct dept_code, distinct job_code from employee;
*/

select distinct job_code,dept_code from employee;

-- 조합으로 겹치지 않는것 조회(J1-D1,J1=D2)

----------------------------------------------------------------------




/*
    <where절>
    조회하고자하는 테이블에서 특정 조건에 맞는 데이터만 조회할 때
    where절에 조건식을 제시함
    조건식에는 다양한 연산자들 사용 가능
    
    [표현법]
    select 컬럼1,컬럼2,... from 테이블명 where 조건식;
    
    *비교 연산자
    대소비교 : >,<,>=,<=
    같은지 비교 : =
    같지않은지 비교 : !=,^=,<>
*/


-- employee테이블에서 부서코드가 'D9'인 사람들의 모든 컬럼 조회

select * from employee where dept_code = 'D9';


-- employee 테이블에서 부서코드가 'D1'인 사원들의 사번 사원명 부서코드 조회

select emp_id,emp_name,dept_code from employee where dept_code = 'D1';

-- employee 테이블에서 부서코드가 'D1'이 아닌 사원들의 사번 사원명 부서코드 조회
select emp_id,emp_name,dept_code from employee where dept_code != 'D1';

-- employee 테이블에서 급여가 400만원 이상인 사원들의 사원명 부서코드 급여 조회

select emp_name,dept_code,salary from employee where salary>=4000000;

-- employee 테이블에서 재직중인 사원들의 사번 사원명 입사일 조회

select emp_id,emp_name,hire_date,ent_yn from employee where ent_yn='N'; 


-- EMPLOYEE테이블에서
--1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
select emp_name,salary,hire_date,salary*12 from employee where salary>=3000000;
--2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
select emp_name,salary,salary*12,dept_code from employee where salary*12>=50000000;
--3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
select emp_id,emp_name,job_code,ent_yn from employee where job_code !='J3';

--------------------------------------------------------------------------------------
/*
    <논리 연산자>
    여러개의 조건을 묶어서 제시하고자 할 때
    
    and(~이면서 ,그리고)
    or(~이거나,또는)
*/

-- employee 테이블에서 부서코드가 d9 이면서 급여가 500만원 이상인 사원들의 사원명 부서코드 급여 조회

select emp_name,dept_code,salary from employee where dept_code ='D9' and salary >= 5000000;

-- employee 테이블에서 부서코드가 d6 이거나 급여가 300만원 이상인 사원들의 사원명 부서코드 급여 조회

select emp_name,dept_code,salary from employee where dept_code ='D6' or salary >= 3000000;

-- employee 테이블에서 급여가 350만원 이상 600만원 이하인 사원들의 사번,사원명,급여 조회

select emp_id,emp_name,salary from employee where salary >= 3500000 and salary<=6000000;


-------------------------------------------------------------------------------------------

/*
    <between and>
    조건식에서 사용되는 구문
    ~이상 ~이하 인 범위에 대한 조건 제시에 사용되는 연산자
    
    
    [표현볍]
    비교대상 컬럼 between 하한값 and 상한값 
    -> 해당 컬럼값이 하한값 이상이고 상한값 이하인 데이터
*/


-- employee 테이블에서 급여가 350만원 이상 600만원 이하인 사원들의 사번,사원명,급여 조회

select emp_id,emp_name,salary from employee where salary between 3500000 and 6000000;


-- employee 테이블에서 급여가 350만원 이상 600만원 이하인 사원들의 사번,사원명,급여 조회
select emp_id,emp_name,salary from employee where not salary between 3500000 and 6000000;
-- not : 논리부정 연산자
-- 컬럼명 앞 또는 between앞에 기입

-- 입사일이 90/01/01/ ~ 01/01/01 인 사원들의 사번 사원명 입사일 조회

select emp_id,emp_name,hire_date from employee where hire_date >= '90/01/01' and hire_date <='99/12/31';
-----------------------------------------------------------------------
/*
    <Like>
    비교하고자하는 컬럼값이 내가 제시한 특정패턴에 만족하는 경우 조회
    
    [표현볍]
    비교대상컬럼 like '특정패턴'
    -> 특정패턴 : '%','_' 와일드카드로 사용 할 수 있다.
    
    >> '%': 0 글자 이상
    ex)비교대상 컬럼 like '문자%' => 비교대상 컬럼값이 '문자'로 시작하는 데이터 조회
       비교대상 컬럼 like '%문자' => 비교대상 컬럼값이 '문자'로 끝나는 데이터 조회
       비교대상 컬럼 like '%문자%' => 비교대상 컬럼값이 '문자'가 포함되어있는 데이터 조회
       
    >> '_' : 1글자 이상
    ex) 비교대상 컬럼like '_문자' => 비교대상 컬럼값이 '문자'앞에 무조건 한글자가 있는 데이터 조회
        비교대상 컬럼like '__문자' => 비교대상 컬럼값이 '문자'앞에 무조건 한글자가 있는 데이터 조회
        비교대상 컬럼like '_문자_' => 비교대상 컬럼값이 '문자'앞에 무조건 한글자, 뒤에도 무조건 한글자가 있는 데이터 조회
*/

-- employee 테이블에서 사원들 성이 전씨인 사원들의 사원명 급여 입사일 조회

select emp_name , salary , hire_date from employee where emp_name like'전%';

-- employee 테이블에서 사원들 이름에 '하' 가 포함되있는 사원들의 사원명 주민번호 전화번호 조회

select emp_name,emp_no,phone from employee where emp_name like '%하%';

-- employee 테이블에서 사원들 이름에 '하' 가 중간에 포함되있는 사원들의 사원명  전화번호 조회

select emp_name,phone from employee where emp_name like'_하_';

-- employee 테이블에서 전화번호의 3번째 자리가 1인 사원의 사번 사원명 전화번호 조회

select emp_id,emp_name,phone from employee where phone like '__1%';

-- employee 테이블에서 이메일에 _앞에 글자가 3글자인 사원의 사원명 이메일 조회

select emp_name,email from employee where email like '___%'; -- 언더바4개로 인식되서 글자가 4글자 이상을 가져옴

/*
-- '_' 가 와일드카드인지 데이터값인지 구분지어야함
    -> 데이터값으로 취급하고자하는 값 앞에 나만의 와일드카드(아무거나 가능)을 제시하고 escape에 등록한다.
    * 특수 기호중 '&'를 쓰면 오라클에서는 사용자로부터 입력받는 키워드이므로 안 쓰는 것이 좋다.
*/
select emp_name,email from employee where email like '___@_%' escape'@';

-- 위에 예제의 사원들을 제외한 다른 사원들 조회
select emp_name,email from employee where not email like '___@_' escape'@';


----------------------------------------------------------------------------------------

-- employee에서 이름이 연 으로 끝나는 사원들의 사원명 입사일 조회
select emp_name,hire_date from employee where emp_name like '%연';
-- employee에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명 전화번호 조회
select emp_name,phone from employee where not phone like '010%';
-- employee에서 이름에 하 가 포함되어있고 급여가 240만원 이상인 사원들의 사원명 급여 조회
select emp_name,salary from employee where emp_name like '%하%' and salary >=2400000;
-- department에서 해외영업부인 부서들의 부서코드 부서명 조회
SELECT dept_id, dept_title FROM department WHERE dept_title LIKE '해외영업%';

----------------------------------------------------------------------------------------
/*
    <is null / is not null>
    컬럼값이 null인 경우 null값 비교에 사용되는 연산자

*/

-- employee테이블에서 보너스를 받지않는 사원들의 사번 사원명 급여 보너스 조회
select emp_id,emp_name,salary,bonus from employee where bonus is null;

-- employee테이블에서 보너스를 받는 사원들의 사번 사원명 급여 보너스 조회
select emp_id,emp_name,salary,bonus from employee where bonus is not null;

--employee테이블에서 사수가 없는 사원들의 사원명 부서코드 사수번호 조회

select emp_id,emp_name,dept_code,manager_id from employee where manager_id is null;

--employee테이블에서 부서배치를받지 못했지만 보너스를 받는 사원들의 사번 사원명 부서코드 사수번호 조회

select emp_id,emp_name,dept_code,manager_id from employee where dept_code is null and bonus is not null;



/*
    <IN/ NOT IN>
    in : 컬럼값이 내가 제시한 목록중에 일치하는 값이 있는 데이터만 조회
    not in : 컬럼값이 내가 제시한 목록중에 일치하는 값을 제외한 나머지 데이터만 조회
    
    [표현볍]
    비교대상 컬럼 In('값1','값2'...)
*/
-- employee테이블에서 부서코드가 d6이거나 d8이거나 d9인 사원의 사원명 부서코드 급여조회
select emp_name,dept_code,salary from employee --where dept_code ='d6' or dept_code ='d8' or dept_code ='d9' 
where dept_code in('D6','D8','D9');

-----------------------------------------------------------------------------------

/*
    <연산자 우선순위>
    1. ()
    2. 산술 연산자
    3. 연결 연산자
    4. 비교 연산자
    5. IS NULL / Like '특정패턴'/IN
    6. betweeb and
    7. not(논리 연산자)
    8. and(논리 연산자)
    9. or(논리 연산자)
    
    **or보다 and가 먼저 연산됨
*/

-- employee테이블에서 직급코드가 'J7'이거나 'J2'인 직원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회

select * from employee where (job_code = 'J7' or job_code = 'J2') and salary>=2000000;

--------------------------------------------------------------------------------------------------
/*
    <order by 절>
    select 문 가장 마지막 줄에작성 실행순서 또한 마지막에 실행
    
    [표현법]
    select 
    from 테이블명
    where
    order by 정렬기준의 컬럼명| 별칭 | 컬럼순번| [ASC]|[DESC] [NULL FRIST | NULL LAST];
    
    - ASC : 오름차순 정렬(생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULL FIRST : 생략시 DESC일때의 기본값 . 정렬하고자하는 컬럼값에 NULL이 있는 경우 데이터를 맨 앞에 배치한다.
    - NULL LAST : 생락시 ASC일때의 기본값. 정렬하고자하는 컬럼값에 NULL이 있는 경우 데이터를 맨 뒤에 배치한다.
*/





-----------------------------------------------------------------------------
select * from employee;
--1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사수사번, 부서코드 조회
select emp_name,manager_id,dept_code from employee WHERE manager_id IS NULL AND dept_code IS NULL;
--2. 연봉(보너스포함X)이 3000만원 이상이고 보너스를 받지 않은 사원들의 사번, 사원명, 연봉, 보너스 조회
select emp_id,emp_name,salary*12,bonus from employee where salary*12 >=30000000 and bonus is null; 
--3. 입사일이 95/01/01이상이고 부서배치를 받은 사원들의 사번, 사원명, 입사일, 부서코드 조회
select emp_id,emp_name,hire_date,dept_code from employee where  hire_date >= '95/01/01' and dept_code is not null;
--4. 급여가 200만원 이상 500만원 이하고 입사일이 01/01/01이상이고 보너스를 받지 않는 사원들의 
--   사번, 사원명, 급여, 입사일, 보너스 조회
select emp_id,emp_name,salary,hire_date,bonus from employee where salary >=2000000 and salary<=5000000 and hire_date >='01/01/01' and bonus is null;

--5. 보너스포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 
--   사번, 사원명, 급여, 보너스포함연봉 조회 (별칭부여)
select emp_id,emp_name,salary,(salary*bonus+salary)*12 as "보너스포함연봉" 
from employee 
where (salary*bonus+salary)*12 is not null and emp_name like '%하%'
order by "보너스포함연봉" desc;


----------------------------------------------------------------------
-- 1. JOB 테이블에서 모든 정보 조회
select * from job;
-- 2. JOB 테이블에서 직급 이름 조회
select job_name from job;
-- 3. DEPARTMENT 테이블에서 모든 정보 조회
select * from department;
-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
select emp_name,email,phone,hire_date from employee;
-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
select hire_date,emp_name,salary from employee;
-- 6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT 
 emp_name, 
 salary * 12 AS 연봉, 
 (salary * bonus + salary) * 12 AS "총수령액(보너스포함)", 
 ((salary * bonus + salary) * 12) - (salary * 12 * 0.03) AS 실수령액
FROM employee;
-- 7. EMPLOYEE테이블에서 JOB_CODE가 J1인 사원의 이름, 월급, 고용일, 연락처 조회
select emp_name,salary,hire_date,phone from employee where job_code = 'J1';
-- 8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
select emp_name,salary,((salary * bonus + salary) * 12) - (salary * 12 * 0.03),hire_date from employee 
where ((salary * bonus + salary) * 12) - (salary * 12 * 0.03)>=50000000;
-- 9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
select * from employee where salary >=4000000 and job_code = 'J2';
-- 10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
--     고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
select emp_name,dept_code,hire_date from employee where dept_code in('D9','D5') and hire_date < '02/01/01';
-- 11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
select * from employee where hire_date >='90/01/01' and hire_date <='01/01/01';
-- 12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
select emp_name from employee where emp_name like '%연';
-- 13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
select emp_name,phone from employee where not phone like '010%';
-- 14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고 
--     고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
select * from employee
where email like '____@_%' escape '@' and dept_code in('D9','D6') and hire_date >='90/01/01' and hire_date<= '00/12/01' and salary >= 2700000;
























