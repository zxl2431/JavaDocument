--��������
select * from emp1;

-- һ��ע��where�������ܵ�, ���˾�ȫ���޸���
update emp1 set department_id = 70 where employee_id = '113';

-- update�����ʹ���Ӳ�ѯ
--���� 114��Ա���Ĺ����͹���ʹ����205��Ա����ͬ
update employees
set
job_id = (select job_id from employees where employee_id =205),
salary = (select salary from employees where employee_id =205)
where employee_id = 114;

select job_id, salary from employees where employee_id ='114';
select job_id, salary from employees where employee_id ='205';

--������employee_id Ϊ200��Ա��job_id��ͬ��Ա����department_idΪemployee_idΪ100��Ա����department_id
create table employees_copy as select * from employees;
select count(*) from employees_copy;

update employees_copy set department_id = (
select department_id from employees_copy  where employee_id = 100
) where job_id = (
select job_id from employees where employee_id = 200
)

select distinct department_id from employees_copy;
 


