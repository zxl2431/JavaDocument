## Oracle笔记

### 一、DML练习

#### 1、SELECT基本操作

```sql
--导入表
@f:/del_data.sql
@f:/hr_cre.sql
@f:/hr_popul.sql
```

表关系图:

![](Oracle练习.assets/表关系图示.png)

```sql
--表的描述
desc employees;

--查所有的列
select * from employees;
select * from departments;

--查指定的列
select EMPLOYEE_ID, FIRST_NAME||LAST_NAME from employees;

--distinct
select distinct DEPARTMENT_ID from employees;

--算术运算符
select 8*4 from dual;
select sysdate, sysdate+1, sysdate-1 from dual;
select last_name, salary, salary+300 from employees;
select last_name, salary, salary+300,10*salary+300, 10*(salary+100) from employees; 
select (sysdate-hire_date) work_date from employees;

--编辑sql
edit
ed
/

--null值
--null不同于0, 凡是空值参与的运算都为空
select last_name, job_id, salary, commission_pct from employees;
select last_name, salary, salary*commission_pct from employees;

--别名
--别名默认都是大写,可以用双引号确定别名是大写还是小写, Oracle中用双引号的就两个地方
select last_name as name, commission_pct comm from employees;
select last_name "Name", salary*12 "Annual Salary",commission_pct comm from employees;

--连接符||
--别列与列,列与字符连接在一起
select (first_name||' '||last_name) "Name", (first_name||'`s jobid is:'||job_id) job from employees;

--distinct去重
select department_id from employees;
select count(department_id) from employees;
select count(distinct department_id) from employees;

```



#### 2、过滤和排序

```sql
--过滤where ()
--这样会造成笛卡尔集
select * from employees, departments; --2887
select * from employees e, departments d where e.department_id = d.department_id;--106
select * from employees e where e.last_name='King';
select * from employees e where e.hire_date='17-6月-1987';
--ORA-01843: not a valid month

--比较运算


--转义字符 \或# escape

--排序 order by 

```



#### 3、单行函数

```sql
--一行数据对应一个结果就是单行函数
```



#### 4、多表查询

```sql
--
```



### 二、