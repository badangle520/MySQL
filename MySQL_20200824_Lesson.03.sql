USE myemployees;

# 进阶3 : 排序查询
/*
引入:
     SELECT * FROM employee;
语法:
     SELECT 查询字段
     FROM   表
     WHERE  筛选条件
     ORDER BY 排序列表 ASC, DESC
特点:
    1. ASC代表升序, DESC代表降序, 如果不写, 默认ASC升序
    2. ORDER BY子句中科院支持单个字段, 多个字段, 表达式, 函数, 别名
    3. ORDER BY子句一般是放在查询语句的最后面, limit子句除外
*/

#案例1: 查询员工信息, 要求工资从高到底排序
SELECT * FROM employees ORDER BY salary;
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary DESC;

#案例2: 查询部门编号>=90的员工信息, 按入职时间的先后排序 [添加筛选条件]
SELECT * FROM employees WHERE department_id >=90 ORDER BY hiredate;
SELECT * FROM employees WHERE department_id >=90 ORDER BY hiredate ASC;

#案例3: 按年薪的高低显示员工的信息和年薪[按表达式排序]
SELECT
    salary*12*(1+IFNULL(commission_pct,0)) AS 年薪,
    *
FROM employees ORDER BY 年薪 DESC;

#案例4: 按年薪的高低显示员工的信息和年薪[按别名排序]
SELECT
    *,
    salary*12*(1+IFNULL(commission_pct,0)) AS 年薪
FROM employees ORDER BY 年薪 DESC;

#案例5: 按姓名的长度显示员工的姓名和工资[按函数排序]
SELECT
    CONCAT(last_name, ' ', first_name)         AS 姓名,
    salary,
    LENGTH(CONCAT(last_name, ' ', first_name)) AS 字节长度
FROM
    employees
ORDER BY
    字节长度 DESC;

#案例6: 查询员工信息, 要求先按工资排序, 再按员工编号排序
SELECT * FROM employees ORDER BY salary ASC, employee_id DESC;

########################################################################################################
#                     测试 -- 开始
########################################################################################################

# 1. 查询员工的姓名和部门号和年薪，按年薪降序 按姓名升序
SELECT first_name,department_id,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY 年薪 DESC, first_name ASC;

# 2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序
SELECT first_name,salary FROM employees WHERE NOT salary BETWEEN 8000 and 17000 ORDER BY salary DESC;

# 3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT * FROM employees WHERE email LIKE '%e%' ORDER BY LENGTH(email)DESC, department_id ASC;

########################################################################################################
#                     测试 -- 结束
########################################################################################################

