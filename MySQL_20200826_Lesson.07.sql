USE girls;
USE myemployees;
SELECT @@session.sql_mode;
set SQL_MODE = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'

#进阶6: 连接查询

/*
 含义: 又称多表查询, 当查询的字段来自于多个表时, 就会用到连接查询

 笛卡尔乘积现象: 表1 有m行, 表2 有n行, 结果=m*n行
 发生原因: 没有有效的连接条件
 如何避免: 添加有效的连接条件

 分类:
     按年代分类:
          sql92标准: 仅仅支持内连接
     [推荐]sql99标准:支持内连接+外连接(左外和右外)+交叉连接

     按功能分类:
         内连接:
               等值连接
               非等值连接
               自连接
         外连接:
               左外连接
               右外连接
               全外连接
         交叉连接




 */

SELECT *
FROM
    beauty;

SELECT *
FROM
    boys;

SELECT
    name,
    boyname
FROM
    boys,
    beauty
WHERE
    beauty.boyfriend_id = boys.id;

#一, sql92标准
#1. 等值连接
/*
 ①多表等值连接的结果为多表的交集部分
 ②n表连接, 至少需要n-1个连接条件
 ③多表的顺序没有要求
 ④一般需要为表起别名
 ⑤可以搭配前面介绍的所有子句使用,比如排序,分组,筛选


 */


#案例1 查询女神名和对应的男神
SELECT name,boyname
FROM boys,beauty
WHERE beauty.boyfriend_id = boys.id;

#案例2: 查询员工名和对应的部门名
SELECT first_name,department_name
FROM employees,departments
WHERE employees.department_id=departments.department_id;

#2. 为表起别名
/*
  ①提高语句的简洁度
  ②区分多个重名的字段

  注意:如果为表起了别名,则查询的字段就不能使用原来的表名去限定.
 */
# 查询员工名,工种号,工种名
SELECT e.first_name,e.job_id,j.job_title
FROM employees e,jobs j
WHERE e.job_id=j.job_id;

#3. 两个表的顺序是否可以调换
SELECT e.first_name,e.job_id,j.job_title
FROM jobs j,employees e
WHERE e.job_id=j.job_id;

#4 可以加筛?

#案例: 查询有奖金的员工名.部门名
SELECT e.first_name,d.department_name,e.commission_pct
FROM employees e,departments d
where e.department_id=d.department_id
and commission_pct IS NOT NULL;

#案例2: 查询城市名中第二个字符为o的部门名和城市名
SELECT d.department_name,l.city
FROM departments d, locations l
where d.location_id=l.location_id
and l.city LIKE '_o%';

#5. 可以加分组?
#案例1: 查询每个城市的部门个数
SELECT l.city,count(*) 部门数
FROM locations l,departments d
WHERE l.location_id=d.location_id
GROUP BY l.city;

#案例2: 查询有奖金的每个部门的部门名和部门的领导编号和这个部门的最低工资
SELECT department_id,manager_id,salary,commission_pct FROM employees WHERE commission_pct IS NOT NULL;
SELECT department_id,manager_id,salary,commission_pct FROM employees WHERE department_id IS NOT NULL;

select d.department_name, d.department_id,e.manager_id, MIN(e.salary)
FROM departments d,employees e
WHERE d.department_id=e.department_id
AND e.commission_pct IS NOT NULL
GROUP BY d.department_id,d;

#6, 可以加排序
#案例: 查询每个工种的工种名和员工的个数,并且按员工个数降序
SELECT j.job_title,e.job_id,COUNT(*) 员工数
FROM jobs j,employees e
WHERE j.job_id=e.job_id
GROUP BY e.job_id
ORDER BY COUNT(*) DESC;

SELECT * FROM employees;

#7 可以实现三表连接?
#案例: 查询员工名, 部门名和所在的城市

SELECT e.first_name,d.department_name,l.city
FROM employees e, departments d, locations l
WHERE e.department_id=d.department_id
AND   d.location_id=l.location_id
AND   l.city like 's%'
ORDER BY d.department_name DESC;

#2. 非等值连接
CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  int,
 highest_sal int);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);

#案例1: 查询员工的工资和工资级别
SELECT e.employee_id,e.salary,g.grade_level
FROM employees e,job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;

#3, 自连接
#案例: 查询 员工名和上级的名称
SELECT e.employee_id,e.first_name 员工,e.manager_id,b.first_name 老板
FROM employees e, employees b
WHERE e.manager_id=b.employee_id
ORDER BY e.employee_id ASC;

########################################################################################################
#                     测试 -- 开始
########################################################################################################

#1. 显示所有员工的姓名，部门号和部门名称。
SELECT e.first_name,d.department_id,d.department_name
FROM employees e,departments d
WHERE e.department_id=d.department_id;

#2. 查询 90 号部门员工的 job_id 和 90 号部门的 location_id
SELECT e.first_name,e.job_id,d.location_id
FROM employees e,departments d
WHERE e.department_id = d.department_id
AND   e.department_id = 90;

#3. 选择所有有奖金的员工的 last_name , department_name , location_id , city
SELECT e.last_name,d.department_name,d.location_id,l.city
FROM employees e,departments d, locations l
WHERE e.department_id=d.department_id
AND   d.location_id=l.location_id
AND   e.commission_pct IS NOT NULL;

#4. 选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name
SELECT e.last_name,e.job_id,e.department_id,d.department_name
FROM employees e,departments d,locations l
WHERE e.department_id=d.department_id
AND   d.location_id=l.location_id
AND   l.city='Toronto';

#5. 查询每个工种、每个部门的部门名、工种名和最低工资
SELECT d.department_name,j.job_title,MIN(e.salary) 最低工资
FROM employees e,departments d,employees,jobs j
WHERE e.department_id = d.department_id
AND   e.job_id = j.job_id
GROUP BY d.department_name,J.job_title;

#6. 查询每个国家下的部门个数大于 2 的国家编号
SELECT l.country_id,COUNT(*) 部门个数
FROM departments d, locations l
where d.location_id=l.location_id
GROUP BY l.country_id
HAVING 部门个数>2;

#7、选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
#   employees Emp# manager  Mgr#
    kochhar   101  king    100
SELECT e.last_name "employee",e.employee_id "Emp#",m.last_name "manager",m.employee_id "Mgr"
FROM employees e, employees m
WHERE e.manager_id=m.employee_id
AND e.last_name='Kochhar';

*-------------------------------------------------------------------------------------*

#1 显示员工表的最大工资,工资平均值
SELECT MAX(salary),AVG(salary) FROM employees;

#2 查询员工表的employee_id, job_id, last_name, 按department_id降序, salary升序
SELECT employee_id,job_id,last_name FROM employees
ORDER BY department_id DESC, salary ASC;

#3 查询员工表的job_id中包含a和e的,并且a在e的前面
SELECT DISTINCT job_id FROM employees WHERE job_id like '%a%e%';

/*
4 已知表student, 里面有id(学号),name, gradeId(年级编号)
  已经表grade,里面有id(年级编号),name(年级名)
  已经表result,里面有id,score,studentNo(学号)
  要求查询姓名,年级名,成绩

  SELECT s.name,g.grade,r.score
  FROM student s,grade g,result r
  WHERE s.gradeId=g.id
  AND   S.id=r.id
 */

/*
 5 显示当前日期, 以及去前后空格, 截取子字符串的函数
 SELECT NOW();
 SELECT TRIM(字符 from'')
 SELECT SUBSTR(str,startIndex);
 SELECT SUBSTR(str,startIndex,length);


 */

########################################################################################################
#                     测试 -- 结束
########################################################################################################
