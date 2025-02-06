/*
    <GROUP BY절>EMPLOYEE
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

-- 각 부서별 총 급여액
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;DEPARTMENT

SELECT DEPT_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직급별 사원수와 급여의 총합
SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 직급별 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최고급여를 직급별 오름차순으로 정렬
SELECT JOB_CODE, COUNT(*), COUNT(BONUS), SUM(SALARY), ROUND(AVG(SALARY),-1), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 남,여별 사원수
-- DECODE는 오라클에서만 사용하는 함수
SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여', '3', '남', '4', '여') "성별 사원수", COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여', '3', '남', '4', '여');

-- 모든 DB 다 사용
SELECT CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남'
                    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
                    WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '남'
                    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여'
            END "성별 사원수"
            , COUNT(*)
FROM EMPLOYEE
GROUP BY CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남'
                         WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
                         WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '남'
                         WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여'
                 END;

-- GROUP BY절에 여러 컬럼 기술 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE;

---------------------------------------------------------------------------------------------------------
/*
    <HAVING 절>
    그룹에 대한 조건을 제시할 때 사용되는 구문
*/
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, CEIL(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

---------------------------- 실습문제------------------------------
select * from employee;
--1. 직급별 총 급여합(단, 직급별 급여합이 1000만원 이상인 직급만 조회) 직급코드, 급여합 조회
select job_code as직급코드, sum(salary)as급여합
from employee
group by job_code
having sum(salary) >= 10000000;


--2. 부서별 보너스를 받는 사원이 없는 부서만 부서코드를 조회
select dept_code
from employee
group by dept_code
having max(bonus) is null;
-----------------------------------------------------------
/*
    <SELECT문 순서>
    FROM
    ON : JOIN 조건 확인
    JOIN : 테이블간의 JOIN
    WHERE
    GROUP BY
    HAVING
    SELECT
    DISTINCT
    ORDER BY    
*/
-----------------------------------------------------------
/*
    <집계함수>
    그룹별로 산출된 결과 값에 중간 집계를 계산해주는 함수
    
    ROLLUP,CUBE
    => GROUP BY 절에 기술하는 함수
    
    -ROLLUP(컬럼1,컬럼2) : 컬럼1을 가지고 다시 중간집계를 내는 함수
    -CUBE(컬럼1,컬럼2) : 컬럼1을 가지고 중간집계를 내고 컬럼2도 중간 집계를 냄
*/

-- 각 직급별 급여의 합
select job_code, sum(salary) from employee group by job_code order by job_code;

select job_code, sum(salary) from employee group by rollup(job_code) order by job_code; -- 컬럼이 1개일때는 CUBE,ROLLUP,안쓴것 모두 동일 

-- 컬럼이 2개 일때 사용
select job_code,dept_code,sum(salary)
from employee
group by job_code,dept_code
order by job_code,dept_code;

-- rollup 사용
select job_code,dept_code,sum(salary)
from employee
group by rollup(job_code,dept_code)
order by job_code,dept_code;
--cube사용
select job_code,dept_code,sum(salary)
from employee
group by cube (job_code,dept_code)
order by job_code,dept_code;
-----------------------------------------------------------
/*
    <집합 연산자>
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION : OR | 합집합
    - INTERSECT : AND | 교집합
    - UNION ALL : 합집합 + 교집합 
    - MINUS : 차집합
*/
-----------------------1. UNION------------------------------------
-- 부서코드가 D5인 사원 또는 급여 300만원 초과인 사우너들 조회
select emp_name,dept_code,salary
from employee
where dept_code = 'D5'
union
select emp_name,dept_code,salary
from employee
where salary > 3000000;

-- or
select emp_name,dept_code,salary
from employee
where dept_code = 'D5' or salary > 3000000;


-----------------------2. INTERSECT------------------------------------
-- 부서코드가 d5이면서 급여가 300만원 초과인 사원의 사번 사원명 부서코드 급여 조회

select emp_id,emp_name,dept_code,salary
from employee
where dept_code ='D5'
intersect
select emp_id,emp_name,dept_code,salary
from employee
where salary >3000000;
-- 집합연산자 사용시 주의사항
-- 각 쿼리문의 select절에는 작성되는 동일한 컬럼이어야 함 ex)158절과162절이 똑같아야한다는 말

-----------------------3. UNION ALL------------------------------------

select emp_id,emp_name,dept_code,salary
from employee
where dept_code ='D5'
union all
select emp_id,emp_name,dept_code,salary
from employee
where salary >3000000;

-----------------------4. MINUS------------------------------------
select emp_id,emp_name,dept_code,salary
from employee
where dept_code ='D5'
MINUS
select emp_id,emp_name,dept_code,salary
from employee
where salary >3000000;

-- and
select emp_id,emp_name,dept_code,salary
from employee
where dept_code ='D5' and salary <=3000000; -- D5인 사원들중에서 300만원 이하인 사원


