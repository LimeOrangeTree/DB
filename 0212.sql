
--30���� �ٹ��ϴ� ��� ���� ��ȸ
SELECT  
 first_name, salary,hire_date,department_id
FROM employees
WHERE  department_id=30;






select DISTINCT department_id as depid
from  employees
order by depid desc;

-- ������̺���
-- first_name, salary,hire_date��ȸ
SELECT first_name, salary,hire_date
FROM   employees;

-- ���� ������� �̸������� ����
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY   first_name asc;

--���� ������� �޿����̹޴� ������� ���
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY  salary  desc;


-- ���� ������� �ֱٿ� �Ի��� ������� ���
SELECT first_name, salary,hire_date
FROM   employees
ORDER BY  hire_date  desc;



-- �μ��������� ����
-- ���Ϻμ��������� �ֱ� �Ի��� ������� 
-- ���� �Ի絿���� �޿����� �޴� ������� ���
SELECT 
    first_name, salary,hire_date,department_id
FROM   employees
ORDER BY  4 asc,  hire_date desc, salary desc;



select job_id, job_title from jobs; 

select first_name, last_name
from employees; 

select first_name || ' - '  || last_name
from employees; 