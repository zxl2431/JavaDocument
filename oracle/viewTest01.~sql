--视图是一种虚表, 建立在已有表(基表)的基础上
--创建视图
create view empvu01 as 
select employee_id, last_name, salary from employees where department_id = 90;

select * from empvu01;

--创建视图时在子查询中给列定义别名
create view empvu02 as 
select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY from employees where department_id=50;

select * from empvu02;

--如果我在employees表中插入一条数据 在视图中能查到
select * from employees;
insert into employees values(901, 'James','Lebu', 'aaa', 1221212, sysdate, 'AC_MGR', 12000, NULL, 100, 50);
commit;

