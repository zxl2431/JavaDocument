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


select * from emp1;


