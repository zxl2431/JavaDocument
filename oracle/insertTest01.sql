--�������� ����department
--����ȫ������
insert into dept1(department_id, department_name, manager_id, location_id)
values(20, 'testdept', 100, 1900);
--��ʽ�����ֵ
insert into dept1(department_id, department_name)
values(30, 'testdept02'); 
--��ʾ�����ֵ
insert into dept1 values (40,'Finance', null, null);

--�������� ����employees��
create table emp1 as 
select * from employees where 1=2;

INSERT INTO emp1 (employee_id, 
                 first_name, last_name, 
                 email, phone_number,
                 hire_date, job_id, salary, 
                 commission_pct, manager_id,
                 department_id)
VALUES (
       113,
       'Louis', 'Popp',
       '123@qq.com', '13112345678',
       SYSDATE, '001', 6900,
       NULL, 201, 100
);

insert into emp1 
values (
       114, 
       'Den', 'Raphealy',
       'DRAPHEAL@qq.com', '13111111111',
       to_date('FEB 3, 1999', 'MON DD, YYYY'), '001', 7100, NULL, 202, 100
)


select * from emp1;

--�����ű�


