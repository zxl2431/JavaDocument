--更新数据
select * from emp1;

-- 一定注意where条件不能掉, 掉了就全部修改了
update emp1 set department_id = 70 where employee_id = '113';

-- update语句中使用子查询
--更新 114号员工的工作和工资使其与205号员工相同
update employees
set
job_id = (select job_id from employees where employee_id =205),
salary = (select salary from employees where employee_id =205)
where employee_id = 114;

select job_id, salary from employees where employee_id ='114';
select job_id, salary from employees where employee_id ='205';

--调整与employee_id 为200的员工job_id相同的员工的department_id为employee_id为100的员工的department_id
update emp1 

