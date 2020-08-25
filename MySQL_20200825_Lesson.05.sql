USE myemployees;

# ONLY_FULL_GROUP_BY 待解决
show variables like '%sql_mode';

SELECT @@GLOBAL.sql_mode;

SELECT @@SESSION.sql_mode;

set sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

#二, 分组函数
/*
 功能: 用作统计使用, 又称为聚合函数 或 统计函数 或 组函数
 分类:
 SUM 求和, AVG 求平均值, MAX 最大值, MIN 最小值, COUNT 计算个数
 特点:
 1. SUN, AVG 一般用于处理数值型
    MAX, MIN, COUNT可以处理任何类型
 2. 以上分组函数都忽略NULL值
 3. 可以和DISTINCT搭配实现去重的运算
 4. COUNT函数的单独介绍
 一般使用COUNT(*)用作统计行数
 5. 和分组函数一同查询的字段要求是group by后的字段

 */

#1. 简单的使用
SELECT SUM(salary) 工资和  FROM employees;
SELECT AVG(salary) 平均工资 FROM employees;
SELECT MAX(salary) 最大工资 FROM employees;
SELECT MIN(salary) 最小工资 FROM employees;
SELECT COUNT(salary) 工资数 FROM employees;

SELECT
    SUM(salary)   和,
    AVG(salary)   平均,
    MAX(salary)   最高,
    MIN(salary)   最低,
    COUNT(salary) 个数
FROM
    employees;

SELECT
    SUM(salary)        和,
    ROUND(AVG(salary)) 平均,
    MAX(salary)        最高,
    MIN(salary)        最低,
    COUNT(salary)      个数
FROM
    employees;

#2. 参数支持哪些类型

SELECT SUM(last_name),AVG(first_name) FROM employees;
SELECT SUM(hiredate),AVG(hiredate) FROM employees;

SELECT MAX(last_name),MIN(last_name) FROM employees;
SELECT MAX(hiredate),MIN(hiredate) FROM employees;

SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(last_name) FROM employees;

#3. 忽略NULL
SELECT SUM(commission_pct), AVG(commission_pct) FROM employees;
SELECT SUM(commission_pct)/AVG(commission_pct) out_put FROM employees;

SELECT MAX(commission_pct), MIN(commission_pct) FROM employees;
SELECT COUNT(commission_pct) FROM employees;

#4. 和DISTINCT搭配
SELECT SUM(DISTINCT salary), SUM(salary) FROM employees;
SELECT DISTINCT commission_pct FROM employees;
SELECT COUNT(DISTINCT commission_pct) FROM employees;

#5. COUNT函数的详细介绍
SELECT COUNT(salary) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(*) FROM employees;
SELECT COUNT(1) FROM employees;
SELECT COUNT(2) FROM employees;
SELECT COUNT('郭靖') FROM employees;

/*
 效率:
 MYISAM 存储引擎下, COUNT(*)的效率高
 INNODB 存储引擎下, COUNT(*)和COUNT(1)效率差不多, 比COUNT(字段)要高一些
 */

 #6. 和分组函数一同查询的字段有限制
SELECT employee_id , AVG(salary) FROM employees;


########################################################################################################
#                     测试 -- 开始
########################################################################################################


# 1. 查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary) 最高工资,MIN(salary) 最低工资,ROUND(AVG(salary),0) 平均工资,SUM(salary) 工资和 FROM employees;

# 2. 查询员工表中的最大入职时间和最小入职时间的相差天数 (DIFFRENCE)
SELECT MAX(hiredate),MIN(hiredate),DATEDIFF(MAX(hiredate),MIN(hiredate)) FROM employees;

# 3. 查询部门编号为 90 的员工个数
SELECT COUNT(*) 个数 FROM employees WHERE department_id=90;

########################################################################################################
#                     测试 -- 结束
########################################################################################################
