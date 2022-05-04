--事务:一组逻辑操作单元,是数据从一个状态变换到另外一个状态
select * from departments_copy;
delete from departments_copy where department_id='50';

insert into departments_copy 
values(290, 'Corporate Tax', null, 1700);

commit
rollback;
