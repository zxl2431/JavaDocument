--��ͼ��һ�����, ���������б�(����)�Ļ�����
--������ͼ
create view empvu01 as 
select employee_id, last_name, salary from employees where department_id = 90;


select * from empvu01;
