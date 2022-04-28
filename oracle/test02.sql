--连接多个表
select e.employee_id, e.last_name, d.department_id, d.department_name, l.city
from employees e, departments d, locations l 
where e.department_id=d.department_id and d.location_id = l.location_id;

--非等值连接
select e.last_name, e.salary, g.grade_level 
from employees e, job_grades g 
where e.salary between g.lowest_sal and g.highest_sal;

select count(*) from employees;
select count(*) from departments;
--内连接 结果集中不包含不匹配的行
select * from employees e, departments d 
where e.department_id=d.department_id; --106条数据

--外连接 结果集中除了满足条件的以外还返回左/右表中不返回条件的
select * from employees e, departments d 
where e.department_id=d.department_id(+); --左外连接 107条数据

select * from employees e, departments d 
where e.department_id(+)=d.department_id; --右外连接 122条数据

