--����:һ���߼�������Ԫ,�����ݴ�һ��״̬�任������һ��״̬
select * from departments_copy;
delete from departments_copy where department_id='50';

insert into departments_copy 
values(290, 'Corporate Tax', null, 1700);

commit
rollback;
