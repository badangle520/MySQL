USE myemployees;

SELECT @@global.sql_mode;

SELECT @@session.sql_mode;

SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


# 进阶5: 分组查询

/*
 语法:
      select 分组函数, 列(要求出现在group by的后面)
      from   表
      [where 筛选条件]
      group by 分组的列表
      [order by 子句]
 注意:
      查询列表必须特殊,要求是分组函数和group by 后出现的字段
 特点:
     1. 分组查询中的筛选条件分为两类,
                 数据源          位置                关键字
     分组前筛选    原始表          GROUP BY 子句的前面  WHERE
     分组后筛选    分组后的结果集   GROUP BY 子句的后面   HAVING

     ①分组函数做条件肯定是放在HAVING子句中
     ②能用分组前筛选的, 就优先考虑使用分组前筛选

     2. GROUP BY子句支持单个字段分组, 多个字段分组(多个字段之间用逗号隔开没有顺序要求)表达式或函数(用的较少)
     3. 也可以添加排序(排序放在整个分组查询的最后)
 */

# 引入: 查询每个部门的平均工资
SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id;

# 案例1 : 查询每个工种的最高工资
SELECT
    job_id,
    max(salary)
FROM
    employees
GROUP BY
    job_id;

# 案例2 : 查询每个位置上的部门个数
SELECT
    location_id,
    COUNT(*)
FROM
    departments
GROUP BY
    location_id;

#添加分组前的筛选条件
#案例1: 查询邮箱中包含a字符的, 每个部门的平均工资
SELECT
    department_id,
    AVG(salary)
FROM
    employees
WHERE
    email LIKE '%a%'
GROUP BY
    department_id;

#案例2: 查询有奖金的每个领导手下员工的最高工资
SELECT
    manager_id,
    MAX(salary)
FROM
    employees
WHERE
    NOT commission_pct IS NULL
GROUP BY
    manager_id;

#添加分组后的筛选条件
#案例1: 查询哪个部门的员工个数>2
#①查询每个部门的员工工资
#②根据①的查询筛选
SELECT
    department_id,
    COUNT(*) 人数
FROM
    employees a
GROUP BY
    department_id
HAVING
    COUNT(*) > 2;


#案例2: 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#①查询每个工种有奖金的员工的最高工资(分组前筛选)
SELECT
    job_id,
    MAX(salary)
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY
    job_id;
#②根据①的结果继续筛选, 最高工资>12000(分组后筛选)
SELECT
    job_id,
    MAX(salary)
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY
    job_id
HAVING
    MAX(salary) > 12000;

#案例3: 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个,以及其最低工资
#① 查询每个领导手下的员工固定最低工资
SELECT
    manager_id,
    MIN(salary)
FROM
    employees
GROUP BY
    manager_id;
#② 添加筛选条件, 编号>102
SELECT
    manager_id,
    MIN(salary)
FROM
    employees
WHERE
    manager_id > 102
GROUP BY
    manager_id;
#③ 添加筛选条件, 最低工资>5000
SELECT
    manager_id,
    MIN(salary)
FROM
    employees
WHERE
    manager_id > 102
GROUP BY
    manager_id
HAVING
    MIN(salary) > 5000;

#按表达式或函数分组
#案例: 按员工姓名的长度分组, 查询每一组的员工个数, 筛选员工个数>5的有哪些
#①查询每个长度的员工个数
SELECT
    LENGTH(first_name),
    COUNT(*)
FROM
    employees
GROUP BY
    LENGTH(first_name);
#②添加筛选条件
SELECT
    LENGTH(first_name) l,
    COUNT(*)           c
FROM
    employees
GROUP BY
    l
HAVING
    c > 5;

#按多个字段分组
#案例: 查询每个部门每个工种的员工的平均工资
SELECT
    department_id 部门,
    job_id        工种,
    AVG(salary)   平均工资
FROM
    employees
GROUP BY
    部门, 工种;

#添加排序
#案例: 查询每个部门每个工种的员工的平均工资并且按平均工资的高低显示出来
SELECT
    department_id         部门,
    job_id                工种,
    ROUND(AVG(salary), 0) 平均工资
FROM
    employees
WHERE department_id IS NOT NULL
GROUP BY
    部门, 工种
HAVING AVG(salary)>10000
ORDER BY
    平均工资 DESC;

########################################################################################################
#                     测试 -- 开始
########################################################################################################

# 1. 查询各 job_id 的员工工资的最大值，最小值，平均值，总和，并按 job_id 升序
SELECT job_id,MAX(salary),MIN(salary),AVG(salary),SUM(salary) FROM employees GROUP BY job_id ORDER BY job_id ASC;

# 2. 查询员工最高工资和最低工资的差距(DIFFERENCE)
SELECT MAX(salary)-MIN(salary) AS DIFFERENCE FROM employees;

# 3. 查询各个管理者手下员工的最低工资，其中最低工资不能低于 6000，没有管理者的员工不计算在内
SELECT manager_id,MIN(salary) AS 最低工资 FROM employees WHERE manager_id IS NOT NULL GROUP BY manager_id HAVING 最低工资>=6000;

# 4. 查询所有部门的编号，员工数量和工资平均值,并按平均工资降序
SELECT department_id, COUNT(*),ROUND(AVG(salary),0)FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC;

# 5. 选择具有各个 job_id 的员工人数
SELECT job_id,COUNT(*) FROM employees GROUP BY job_id;


########################################################################################################
#                     测试 -- 结束
########################################################################################################