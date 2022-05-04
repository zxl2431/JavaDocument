--����Լ��
create table emp1(
       employee_id number(6), 
       first_name varchar2(20),
       email varchar2(25),
       salary number(10),
       job_id varchar2(10) not null, --�м�Լ�� ϵͳ����
       department_id number(4),
       constraint emp1_emp_id_pk primary key (employee_id), --��Լ�� �û�����
       constraint emp1_dept_fk FOREIGN KEY(department_id) REFERENCES departments(department_id) on delete cascade, --���Լ��
       constraint emp1_email_uk UNION(email),
       constraint emp1_salary_min CHECK (salary > 0 and sal <1000000)
);


select * from emp1;

--����Լ��
create table dept1(
       department_id number(4),
       department_name varchar2(30) constraint dept1_name_nn NOT NULL,
       manager_id number(6),
       location_id number(4),
       constraint dept1_id_pk PRIMARY KEY(department_id)
);

--���Լ����ɾ��Լ��
alter table employees ADD CONSTRAINT emp_manager_fk FOREIGN KEY(manager_id) REFERENCES employees(employee_id);
alter table employees drop constraint emp_manager_kf;

--��Ч��Լ��
alter table employees disable constraint emp_emp_id_pk;
--����Լ��
alter table employees enable constraint emp_emp_id_pk;

--��ѯԼ��
select constraint_name, constraint_type, search_condition from user_constraints where table_name='EMPLOYEES';
SELECT constraint_name, column_name from user_cons_columns where table_name='EMPLOYEES';
