--���Ӷ����
select e.employee_id, e.last_name, d.department_id, d.department_name, l.city
from employees e, departments d, locations l 
where e.department_id=d.department_id and d.location_id = l.location_id;

--�ǵ�ֵ����
select e.last_name, e.salary, g.grade_level 
from employees e, job_grades g 
where e.salary between g.lowest_sal and g.highest_sal;

select count(*) from employees;
select count(*) from departments;
--������ ������в�������ƥ�����
select * from employees e, departments d 
where e.department_id=d.department_id; --106������

--������ ������г����������������⻹������/�ұ��в�����������
select * from employees e, departments d 
where e.department_id=d.department_id(+); --�������� 107������

select * from employees e, departments d 
where e.department_id(+)=d.department_id; --�������� 122������

