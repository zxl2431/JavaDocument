--谁的工资比Abel高
select employee_id, last_name, salary from employees 
where salary > (
select salary from employees where last_name='Abel'
);

--返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id 和工资
select last_name, job_id, salary  from employees 
where job_id = (
select job_id from employees where employee_id='141'
) and salary > (
select salary from employees where employee_id=143
)

--返回公司工资最少的员工的last_name,job_id和salary
select last_name, job_id, salary 
from employees where salary = ( 
select min(salary) from employees
) 

--查询最低工资大于50号部门最低工资的部门id和其最低工资
select department_id, min(salary) from employees group by department_id
having min(salary) > ( 
select min(salary) from employees where department_id = 50
);

--返回其它部门中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
select employee_id, last_name, job_id, salary 
from employees 
where salary < ALL (
select salary from employees where job_id = 'IT_PROG'
) AND job_id <> 'IT_PROG';

--TOP-N
select rn,employee_id, last_name, salary from (
select rownum rn, employee_id, last_name, salary from (
select employee_id, last_name, salary from employees order by salary desc
)) where rn>=10 and rn<=20;
