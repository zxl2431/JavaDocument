--����departments�� �������
create table departments_copy as select * from departments;
select * from departments_copy;

--ɾ������
delete from departments_copy where department_name='Finance';
commit;
rollback;

--ɾ���� һ��Ҫ����where���������� �������������ʾ��ɾ�������������

--��emp1����ɾ��dept1���������к�Public�ַ��Ĳ���id
delete from employees_copy where department_id =(
select department_id from departments_copy where department_name like '%Public%'
)
