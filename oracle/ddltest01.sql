--查看用户定义的表
select * from user_tables;

--查看用户定义的各种数据库对象
select distinct object_type from user_objects;

--查看用户定义的表 视图 同义词和序列
select * from user_catalog;

--创建表 正规的步骤
create table dept1(
       deptno number(2),
       dname varchar2(14),
       loc varchar2(20)
)

--复制现有的表 连里面的数据都一起复制过来
create table emp1 as select * from employees;
--复制表结构不要表数据
create table emp2 as select * from employees where 1=2;
--使用子查询创建表
create table dept2 
as
select employee_id, last_name, salary*12 ANNSAL, hire_date from employees where department_id=80;

--表修改语句 ALTER TABLE table ADD/MODIFY/DROP/RENAME...TO
--增加一个新列 ALTER TABLE ADD
alter table dept2 add (job_id varchar2(10));
--修改一个列 (数据类型,长度和默认值)
alter table dept2 modify (last_name varchar2(30));
--删除一个列
alter table dept2 drop column job_id;
--重命名一个列
alter table dept2 rename column job_id TO id;

--删除表 drop table
drop table dept2;
--清空表 VS 删除表数据
select * from emp1;
rollback;
truncate table emp1;

--改变对象的名称
select * from emp1;
rename emp1 to detail_dept;
select * from detail_dept;




