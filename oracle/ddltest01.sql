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
create table dept2 
as
select employee_id, last_name, salary*12 ANNSAL, hire_date from employees where department_id=80;

--���޸���� ALTER TABLE table ADD/MODIFY/DROP/RENAME...TO
--����һ������ ALTER TABLE ADD
alter table dept2 add (job_id varchar2(10));
--�޸�һ���� (��������,���Ⱥ�Ĭ��ֵ)
alter table dept2 modify (last_name varchar2(30));
--ɾ��һ����
alter table dept2 drop column job_id;
--������һ����
alter table dept2 rename column job_id TO id;

--ɾ���� drop table
drop table dept2;
--��ձ� VS ɾ��������
select * from emp1;
rollback;
truncate table emp1;

--�ı���������
select * from emp1;
rename emp1 to detail_dept;
select * from detail_dept;




