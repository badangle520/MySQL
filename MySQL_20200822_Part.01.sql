USE myemployees;

#1 查询表中的单个字段
SELECT
    last_name
FROM
    employees;

#2 查询表中的多个字段
SELECT
    first_name,
    last_name
FROM
    employees;

#3 查询表中的所有字段
#方式一:
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    hiredate
FROM
    employees;
#方式二:
SELECT *
FROM
    employees;

#4 关键字可以使用`标识
SELECT
    `select`
FROM
    table.a

#5 查询常量值
SELECT 100;
SELECT 'john';

#6 查询表达式
SELECT 100 * 98;

#7 查询函数
SELECT version();

#8 起别名
/*
 1 便于理解
 2 如果要查询的字段有重名的情况, 使用别名可以区分开来
 */
#方式一: 使用as
SELECT 100 * 98 AS 结果;
SELECT
    last_name  AS 姓,
    first_name AS 名
FROM
    employees;

#方式二: 使用空格
SELECT 100 * 98 结果;
SELECT
    last_name  姓,
    first_name 名
FROM
    employees;

#案例:查询salary, 显示结果为 out put
SELECT
    salary "out put"
FROM
    employees;

#9 去重
#案例: 查询员工表中涉及到的所有部门编号
SELECT
    department_id
FROM
    employees;
SELECT DISTINCT
    department_id
FROM
    employees;

#10 +号的作用
/*
 java中的+号
 1 运算符. 两个操作数都为数值型
 2 连接符, 只要有一个操作数为字符串

 mysql中
 仅仅只有一个功能, 运算符
 select 100+90;    两个操偶作书都为数值型,则做加法运算
 select '123'+90;  其中一方为字符型,试图将字符型数值转换成数值型,
                   如果转换成功, 则继续做加法运算
 select 'john'+90: 如果转换失败, 则将字符型数值转换成0;
 select null+90;   只要其中一方为null, 则转换结果为null
 */

#案例: 查询员工名和姓连接到一个字段, 并显示为姓名

SELECT
    last_name + first_name 姓名
FROM
    employees;
SELECT
    concat(last_name, first_name) 姓名
FROM
    employees;

########################################################################################################
#                     测试 -- 开始
########################################################################################################
# 1 下面的语句是否可以执行成功
SELECT
    last_name,
    job_id,
    salary AS sal
FROM
    employees;
# use myemployees;

# 2 下面的语句是否可以执行成功
SELECT *
FROM
    employees;

# 3 找出下面语句中的错误
SELECT
    employee_id,
    last_name,
    salary * 12 "annual salary"
FROM
    employees;

# 4 显示表departments的结构,并查询其中的全部数据
DESC departments;
SELECT *
FROM
    departments;

# 5 显示出表employees中的全部job_id(不能重复)
SELECT DISTINCT
    job_id
FROM
    employees;

# 6 显示出表employees的全部列, 每个列之间用逗号连接, 列头显示成out_put
select * from employees;

SELECT
    ifnull(commission_pct, 0),
    commission_pct
FROM
    employees;

SELECT
    concat(employee_id, ",", first_name, ",", last_name, ",", email, ",", phone_number, ",", job_id, ",", salary, ",",
           ifnull(commission_pct,0), ",", ifnull(manager_id,0), ",", ifnull(department_id,0), ",", hiredate) out_put
FROM
    employees;

########################################################################################################
#                     测试 -- 结束
########################################################################################################
