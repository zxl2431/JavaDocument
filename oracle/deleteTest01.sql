--复制departments表 方便操作
create table departments_copy as select * from departments;
select * from departments_copy;

--删除数据
delete from departments_copy where department_name='Finance';
commit;
rollback;

--删除表 一定要加上where条件的限制 如果不加条件显示会删除整个表的数据

--从emp1表中删除dept1部门名称中含Public字符的部门id
delete from employees_copy where department_id =(
select department_id from departments_copy where department_name like '%Public%'
)
