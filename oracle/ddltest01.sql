--�鿴�û�����ı�
select * from user_tables;

--�鿴�û�����ĸ������ݿ����
select distinct object_type from user_objects;

--�鿴�û�����ı� ��ͼ ͬ��ʺ�����
select * from user_catalog;

--������ ����Ĳ���
create table dept1(
       deptno number(2),
       dname varchar2(14),
       loc varchar2(20)
)

--�������еı� ����������ݶ�һ���ƹ���
create table emp1 as select * from employees;
--���Ʊ�ṹ��Ҫ������
create table emp2 as select * from employees where 1=2;
--ʹ���Ӳ�ѯ������


select * from emp1;


