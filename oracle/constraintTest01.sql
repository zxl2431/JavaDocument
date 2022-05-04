--定义约束
create table emp1(
       employee_id number(6), 
       first_name varchar2(20),
       email varchar2(25),
       salary number(10),
       job_id varchar2(10) not null, --列级约束 系统命名
       department_id number(4),
       constraint emp1_emp_id_pk primary key (employee_id), --表级约束 用户命名
       constraint emp1_dept_fk FOREIGN KEY(department_id) REFERENCES departments(department_id) on delete cascade, --外键约束
       constraint emp1_email_uk UNION(email),
       constraint emp1_salary_min CHECK (salary > 0 and sal <1000000)
);


select * from emp1;

--定义约束
create table dept1(
       department_id number(4),
       department_name varchar2(30) constraint dept1_name_nn NOT NULL,
       manager_id number(6),
       location_id number(4),
       constraint dept1_id_pk PRIMARY KEY(department_id)
);

--添加约束或删除约束
alter table employees ADD CONSTRAINT emp_manager_fk FOREIGN KEY(manager_id) REFERENCES employees(employee_id);
alter table employees drop constraint emp_manager_kf;

--无效化约束
alter table employees disable constraint emp_emp_id_pk;
--激活约束
alter table employees enable constraint emp_emp_id_pk;

--查询约束
select constraint_name, constraint_type, search_condition from user_constraints where table_name='EMPLOYEES';
SELECT constraint_name, column_name from user_cons_columns where table_name='EMPLOYEES';
