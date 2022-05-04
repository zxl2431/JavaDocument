## Oracle笔记

### 一、DML练习-SELECT语句

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
select last_name, salary from employees where salary <= 3000;
select last_name, salary from employees where salary between 2500 and 3000;
select employee_id, last_name, salary, manager_id from employees where manager_id in (100, 101, 201);
--%代表零个或多个字符 _代表一个字符
select first_name from employees where first_name like '%s%';
select last_name, manager_id from employees where manager_id is null;
select employee_id, last_name, job_id, salary from employees where salary >= 5000 and job_id like '%MAN%';
select last_name, job_id from employees where job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

--转义字符 \或# escape
--select job_id from jobs where job_id like 'ST\_%' escape '\';

--排序 order by 别名排序 多个列名排序
SELECT last_name, job_id, department_id, hire_date from employees order by hire_date;
SELECT last_name, job_id, department_id, hire_date from employees order by hire_date desc;
select employee_id, last_name, salary*12 annsal from employees order by annsal;
select last_name, department_id, salary from employees order by department_id, salary desc;

```



#### 3、单行函数

```sql
--一行数据对应一个结果就是单行函数
--字符函数
select employee_id, last_name, department_id from employees where LOWER(last_name)='higgins';
select concat('Hello', 'World') from dual;
select concat(first_name, last_name) from employees;
select SUBSTR('HelloWorld', 1, 5) from dual;
select SUBSTR(first_name, 1, 3) FROM employees;
select INSTR('hELLOWORLD', 'R') from dual;
select salary, LPAD(salary, 10, '*') from employees;
--只能去首尾
select TRIM('h' FROM 'helloworld') from dual;
select REPLACE('abcda', 'a', 'x') from dual;

select employee_id, concat(first_name, last_name) name, job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?" 
from employees
where substr(job_id, 4) = 'REP';

--数字函数
select round(45.926, 2) from dual; --四舍五入
select trunc(45.926, 2) from dual; --截断
select mod(1600, 300) from dual;   --求余
select round(45.923, 2), round(45.923, 0), round(45.923, -1) from dual;
select trunc(45.923, 2), trunc(45.923, 0), trunc(45.923, -2) from dual; 

--日期函数
select hire_date from employees where hire_date = '17-JUNE-1987';
select last_name, (SYSDATE-hire_date)/7 AS WEEKS from employees where department_id=90;
select months_between('01-sep-95', '01-jan-94') from dual;
select months_between('01-jan-94', '01-sep-95') from dual;
select add_months('11-jan-94', 1) from dual;
select next_day('27-april-2022', 'FRIDAY') from dual;
select last_day('01-FEB-2022') from dual;
select ROUND(SYSDATE, 'MONTH') from dual;
select ROUND(SYSDATE, 'YEAR') from dual;
select TRUNC(SYSDATE, 'MONTH') fROM DUAL;
select TRUNC(SYSDATE, 'YEAR') fROM DUAL;

--转换函数
select sysdate from dual;
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') from dual;
select hire_date from employees;
select last_name, to_char(hire_date, 'DD Month YYYY') AS HIREDATE FROM employees;
select employee_id, last_name, hire_date from employees where to_char(hire_date, 'yyyy-mm-dd')='1987-09-17';
select TO_DATE('2022年4月23日 08:10:21', 'yyyy"年"mm"月"dd"日" hh:mi:ss') from dual;
select TO_DATE('2022-4-23', 'yyyy-mm-dd') from dual;

select to_char(salary, '$99,999.00') salary from employees where last_name='Ernst';
select TO_NUMBER('$1,234,567,890.00','L999,999,999,999.99') from dual;

--通用函数
select commission_pct from employees;
select count(commission_pct) from employees;
--为null去后面的值
select salary*12*nvl(commission_pct,0) from employees;
select last_name, salary, nvl(commission_pct, 0), (salary*12) + (salary*12*nvl(commission_pct, 0)) an_sal from employees;
--不为空返回expr2, 为空返回expr3
select nvl2(commission_pct, 'SAL+COMM', 'SAL') income from employees;
--相等返回null, 不相等返回expr1
select first_name, LENGTH(first_name) "expr1", last_name, LENGTH(last_name) "expr2",
nullif(LENGTH(first_name), LENGTH(last_name)) "expr3"
from employees; 

--coalesce函数 哪个不为空返回哪个
select last_name, commission_pct from employees order by commission_pct;
select last_name, COALESCE(commission_pct, salary, 10) comm from employees order by commission_pct;

--case表达式
select last_name, job_id, salary from employees;
select last_name, job_id, salary, 
       case job_id when 'IT_PROG'  THEN 1.1*salary
                   when 'ST_CLERK' THEN 1.2*salary
                   when 'SA_REP'   THEN 1.3*salary
       ELSE salary end "REVISED_SALARY" 
from employees;

--decode函数
select last_name, job_id, salary from employees;
select last_name, job_id, salary, 
       DECODE(job_id, 'IT_PROG',  1.1*salary,
                      'ST_CLERK', 1.2*salary,
                      'SA_REP',   1.3*salary,
                                  salary) "REVISED_SALARY" 
from employees;

--嵌套函数
select last_name, nvl(to_char(manager_id), 'No Manager') from employees where manager_id is null;
```



#### 4、多表查询

```sql
--笛卡尔集
select count(employee_id) from departements;
select count(department_id) from departments;
select 107*27 from dual;

--消除笛卡尔集 加条件
select * from employees e, departments d where e.department_id = d.department_id;

--连接多个表
select e.employee_id, e.last_name, d.department_id, d.department_name, l.city
from employees e, departments d, locations l 
where e.department_id=d.department_id and d.location_id = l.location_id;

--非等值连接
select e.last_name, e.salary, g.grade_level 
from employees e, job_grades g 
where e.salary between g.lowest_sal and g.highest_sal;

--内连接 结果集中不包含不匹配的行
select * from employees e, departments d 
where e.department_id=d.department_id; --106条数据

--外连接 结果集中除了满足条件的以外还返回左/右表中不返回条件的
select * from employees e, departments d 
where e.department_id=d.department_id(+); --左外连接 107条数据

select * from employees e, departments d 
where e.department_id(+)=d.department_id; --右外连接 122条数据

--自连接
select * from employees where employee_id = 
(select manager_id from employees where last_name='Chen');

select worker.last_name || ' works for ' || manager.last_name from employees worker, employees manager 
where worker.manager_id = manager.employee_id;

--叉集就是笛卡尔集
select last_name, department_name from employees cross join departments;

--自然连接 NATURAL JOIN,会以两个表中具有相同名字的列为条件创建等值连接
select department_id, department_name, location_id, city from departments natural join locations;

 select * from employees natural join departments;
 =
 select * from employees e, departments dep where e.manager_id=dep.manager_id and e.department_id = dep.department_id;
 
 select * from employees join departments using(department_id);
 
 --使用ON子句创建连接
 select * from employees e JOIN departments d ON (e.department_id = d.department_id);
select * from employees e 
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id; 

-- 内连接(同上)
-- 外连接(同上)
select * from employees e left outer join departments d on e.department_id = d.department_id; --107条
select * from employees e rigth outer join departments d on e.department_id = d.department_id; --122条
--满连接
select * from employees e full outer join departments d on e.department_id = d.department_id; --123条
```

#### 5、分组函数

```sql
--分组函数 avg count max min stddev, sum 
select avg(salary), max(salary), min(salary), sum(salary) from employees where job_id like '%REP%';
select min(hire_date), max(hire_date) from employees;
select count(*) from employees where department_id = 50;
--不为空的记录
select count(commission_pct) from employees;
--avg()忽略空值
select avg(commission_pct), sum(commission_pct)/107, sum(commission_pct)/count(commission_pct) from employees;
--NVL函数使分组函数无法忽略空值
select avg(nvl(commission_pct, 0)) from employees;
--非空不重复
select count(distinct department_id) from employees;
-- 分组数据 GROUP BY 子句将表中的数据分成若干组
-- [重要]在select列表中所有未包含在组函数的列都应该包含在GROUP BY子句中.
select department_id, avg(salary) from employees group by department_id;
-- 包含在GROUP BY 子句中的列不必包含在select列表中
select avg(salary) from employees group by department_id;

--非法使用组函数(select列表中未出现在组函数中的列都应该在 GROUP BY 子句中)
select department_id, count(last_name) from employees;
-- 非法[where子句中不能使用函数]
select deparment_id, avg(salary) form employees where AVG(salary) > 8000;
--非法 不能在WHERE字句中使用组函数, 可以在HAVING子句中
select department_id, avg(salary) from employees having AVG(salary) > 8000 group by department_id;

-- HAVRING子句
select department_id, avg(salary) from employees group by department_id having max(salary);
 
--嵌套函数
select max(avg(salary)) from employees group by department_id ;
```

#### 6、子查询

```sql
--谁的工资比Abel高
select employee_id, last_name, salary from employees 
where salary > (
select salary from employees where last_name='Abel'
);

--返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id 和工资
select last_name, job_id, salary  from employees 
where job_id = (
select job_id from employees where employee_id='141'
) and salary > (
select salary from employees where employee_id=143
)

--返回公司工资最少的员工的last_name,job_id和salary
select last_name, job_id, salary 
from employees where salary = ( 
select min(salary) from employees
) 

--查询最低工资大于50号部门最低工资的部门id和其最低工资
select department_id, min(salary) from employees group by department_id
having min(salary) > ( 
select min(salary) from employees where department_id = 50
);

--返回其它部门中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
select employee_id, last_name, job_id, salary from employees where salary < ANY (
select salary from employees where job_id='IT_PROG') AND job_id <> 'IT_PROG';
```



### 二、创建和管理表

#### 1、创建-修改-删除表

```sql
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
create table dept2 
as
select employee_id, last_name, salary*12 ANNSAL, hire_date from employees where department_id=80;

--表修改语句 ALTER TABLE table ADD/MODIFY/DROP/RENAME...TO
--增加一个新列 ALTER TABLE ADD
alter table dept2 add (job_id varchar2(10));
--修改一个列 (数据类型,长度和默认值)
alter table dept2 modify (last_name varchar2(30));
--删除一个列
alter table dept2 drop column job_id;
--重命名一个列
alter table dept2 rename column job_id TO id;

--删除表 drop table
drop table dept2;
--清空表 VS 删除表数据
select * from emp1;
rollback;
truncate table emp1;

--改变对象的名称
select * from emp1;
rename emp1 to detail_dept;
select * from detail_dept;

```



### 三、DML-更新,删除,插入

#### 1、插入数据

```sql
--插入数据 复制department
--插入全部列数
insert into dept1(department_id, department_name, manager_id, location_id)
values(20, 'testdept', 100, 1900);
--隐式插入空值
insert into dept1(department_id, department_name)
values(30, 'testdept02'); 
--显示插入空值
insert into dept1 values (40,'Finance', null, null);

--插入数据 复制employees表
create table emp1 as 
select * from employees where 1=2;

INSERT INTO emp1 (employee_id, 
                 first_name, last_name, 
                 email, phone_number,
                 hire_date, job_id, salary, 
                 commission_pct, manager_id,
                 department_id)
VALUES (
       113,
       'Louis', 'Popp',
       '123@qq.com', '13112345678',
       SYSDATE, '001', 6900,
       NULL, 201, 100
);

insert into emp1 
values (
       114, 
       'Den', 'Raphealy',
       'DRAPHEAL@qq.com', '13111111111',
       to_date('FEB 3, 1999', 'MON DD, YYYY'), '001', 7100, NULL, 202, 100
)


select * from emp1;

--创建脚本插入值
select * from dept1;
insert into dept1(department_id, department_name, location_id) 
values (&department_id, '&department_name', &location);

--从其他表中拷贝数据
insert into emp1 
select * from employees where department_id=90;

```



#### 2、更新数据

```sql
--更新数据
select * from emp1;

-- 一定注意where条件不能掉, 掉了就全部修改了
update emp1 set department_id = 70 where employee_id = '113';

-- update语句中使用子查询
--更新 114号员工的工作和工资使其与205号员工相同
update employees
set
job_id = (select job_id from employees where employee_id =205),
salary = (select salary from employees where employee_id =205)
where employee_id = 114;

select job_id, salary from employees where employee_id ='114';
select job_id, salary from employees where employee_id ='205';

--调整与employee_id 为200的员工job_id相同的员工的department_id为employee_id为100的员工的department_id
create table employees_copy as select * from employees;
select count(*) from employees_copy;

update employees_copy set department_id = (
select department_id from employees_copy  where employee_id = 100
) where job_id = (
select job_id from employees where employee_id = 200
)

select distinct department_id from employees_copy;
```

#### 3、删除数据

```sql
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
```



#### 4、数据库事务

```sql
--事务:一组逻辑操作单元,是数据从一个状态变换到另外一个状态
select * from departments_copy;
delete from departments_copy where department_id='50';

insert into departments_copy 
values(290, 'Corporate Tax', null, 1700);

commit
rollback;
```



### 四、约束

#### 1、constraint 

```sql
--定义约束
create table emp1(
       employee_id number(6), 
       first_name varchar2(20),
       email varchar2(25),
       salary number(10),
       job_id varchar2(10) not null, --列级约束 系统命名
       department_id number(4),
       constraint emp1_emp_id_pk primary key (employee_id), --表级约束 用户命名
       constraint emp1_dept_fk FOREIGN KEY(department_id) REFERENCES departments(department_id) on delete cascade, --外键约束
       constraint emp1_email_uk UNION(email),
       constraint emp1_salary_min CHECK (salary > 0 and sal <1000000)
);


select * from emp1;

--定义约束
create table dept1(
       department_id number(4),
       department_name varchar2(30) constraint dept1_name_nn NOT NULL,
       manager_id number(6),
       location_id number(4),
       constraint dept1_id_pk PRIMARY KEY(department_id)
);

--添加约束或删除约束
alter table employees ADD CONSTRAINT emp_manager_fk FOREIGN KEY(manager_id) REFERENCES employees(employee_id);
alter table employees drop constraint emp_manager_kf;

--无效化约束
alter table employees disable constraint emp_emp_id_pk;
--激活约束
alter table employees enable constraint emp_emp_id_pk;

--查询约束
select constraint_name, constraint_type, search_condition from user_constraints where table_name='EMPLOYEES';
SELECT constraint_name, column_name from user_cons_columns where table_name='EMPLOYEES';
```

