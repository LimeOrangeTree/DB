
--30번에 근무하는 사원 정보 조회
SELECT  
 first_name, salary,hire_date,department_id
FROM employees
WHERE  department_id=30;






select DISTINCT department_id as depid
from  employees
order by depid desc;

-- 사원테이블에서
-- first_name, salary,hire_date조회
SELECT first_name, salary,hire_date
FROM   employees;

-- 위의 결과에서 이름순으로 정렬
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY   first_name asc;

--위의 결과에서 급여많이받는 사원부터 출력
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY  salary  desc;


-- 위의 결과에서 최근에 입사한 사원부터 출력
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY  hire_date  desc;



-- 부서내림차순 정렬
-- 동일부서내에서는 최근 입사한 사원부터 
-- 만약 입사동기라면 급여많이 받는 사원부터 출력
SELECT 
    first_name, salary,hire_date,department_id
FROM   employees
ORDER BY  4 asc,  hire_date desc, salary desc;



select job_id, job_title from jobs; 

select first_name, last_name
from employees; 

select first_name || ' - '  || last_name
from employees; 