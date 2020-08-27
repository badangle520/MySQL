# 二, sql99语法
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】

分类：
内连接（★）：inner
外连接
	左外(★):left 【outer】
	右外(★)：right 【outer】
	全外：full【outer】
交叉连接：cross

*/


#一）内连接
/*
语法：

select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件;

分类：
等值
非等值
自连接

特点：
①添加排序、分组、筛选
②inner可以省略
③ 筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
④inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集

*/

#1、等值连接
#案例1.查询员工名、部门名
SELECT first_name,department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;

SELECT first_name,department_name
FROM departments d INNER JOIN employees e
    ON d.department_id = e.department_id;

#案例2.查询名字中包含e的员工名和工种名（添加筛选）
SELECT e.last_name,j.job_title
FROM employees e INNER JOIN jobs j on e.job_id = j.job_id
WHERE e.last_name LIKE '%e%';

#3. 查询部门个数>3的城市名和部门个数，（添加分组+筛选）
#①查询每个城市的部门个数
SELECT l.city,COUNT(*)
FROM locations l INNER JOIN departments d ON l.location_id = d.location_id
GROUP BY l.city;

#②在①结果上筛选满足条件的
SELECT l.city,COUNT(*)
FROM locations l INNER JOIN departments d ON l.location_id = d.location_id
GROUP BY l.city
HAVING count(*)>3;

#案例4.查询哪个部门的员工个数>3的部门名和员工个数，并按个数降序（添加排序）
#①查询每个部门的员工个数
SELECT department_name,COUNT(*)
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id;

#② 在①结果上筛选员工个数>3的记录，并排序
SELECT department_name,COUNT(*)
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING COUNT(*)>3
ORDER BY COUNT(*) Desc;

#5.查询员工名、部门名、工种名，并按部门名降序（添加三表连接）
SELECT e.last_name,d.department_name,j.job_title
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY d.department_name Desc;


#二）非等值连接

#查询员工的工资级别
SELECT e.first_name,e.salary,g.grade_level
FROM employees e
    INNER JOIN job_grades g on e.salary BETWEEN g.lowest_sal AND g.highest_sal;


 #查询工资级别的个数>20的个数，并且按工资级别降序
SELECT g.grade_level,COUNT(*)
FROM employees e
    INNER JOIN job_grades g on e.salary BETWEEN g.lowest_sal AND g.highest_sal
GROUP BY g.grade_level
HAVING COUNT(*)>20
ORDER BY g.grade_level Desc;


 #三）自连接

 #查询员工的名字、上级的名字
SELECT e.last_name,m.last_name,m.first_name
FROM employees e INNER JOIN employees m ON e.manager_id = m.employee_id;

  #查询姓名中包含字符k的员工的名字、上级的名字
SELECT e.last_name,m.last_name,m.first_name
FROM employees e INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE e.last_name LIKE '%k%';


 #二、外连接

 /*
 应用场景：用于查询一个表中有，另一个表没有的记录

 特点：
 1、外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表没有的记录
 2、左外连接，left join左边的是主表
    右外连接，right join右边的是主表
 3、左外和右外交换两个表的顺序，可以实现同样的效果
 4、全外连接=内连接的结果+表1中有但表2没有的+表2中有但表1没有的
 */
 #引入：查询男朋友 不在男神表的的女神名
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT g.name,g.boyfriend_id,b.boyname,B.usercp
FROM beauty g LEFT JOIN boys b ON g.boyfriend_id=b.id
WHERE b.id IS NULL;

SELECT g.name,g.boyfriend_id,b.boyname,B.usercp
FROM boys b RIGHT JOIN beauty g ON g.boyfriend_id=b.id
WHERE g.id IS NULL;

 #左外连接
 #案例1：查询哪个部门没有员工
 #左外
 SELECT d.department_name,e.employee_id
 FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id
 WHERE e.employee_id IS NULL;

 #右外
 SELECT d.department_name,e.employee_id
 FROM employees e RIGHT JOIN departments d  ON d.department_id = e.department_id
 WHERE e.employee_id IS NULL;

 #全外
USE girls;
SELECT b.*,bo.*
FROM beauty b FULL OUTER JOIN boys bo
ON b.boyfriend_id = bo.id;


 #交叉连接
SELECT b.*,bo.*
FROM beauty b CROSS JOIN boys bo;

 #sql92和 sql99pk
 /*
 功能：sql99支持的较多
 可读性：sql99实现连接条件和筛选条件的分离，可读性较高



 ########################################################################################################
#                     测试 -- 开始
########################################################################################################
#一、查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有，用null填充
USE girls;
SELECT b.*,bo.*
FROM beauty b LEFT JOIN boys bo ON b.boyfriend_id=bo.id
WHERE b.id>3;

#二、查询哪个城市没有部门
USE myemployees;
SELECT l.city,d.department_name
FROM departments d RIGHT JOIN locations l ON l.location_id = d.location_id
WHERE d.department_id IS NULL;

#三、查询部门名为SAL或IT的员工信息
SELECT d.department_name,e.*
FROM employees e LEFT JOIN departments d ON d.department_id = e.department_id
WHERE d.department_name IN ('SAL','IT');

SELECT d.department_name,e.*
FROM departments d  LEFT JOIN employees e ON d.department_id = e.department_id
WHERE d.department_name IN ('SAL','IT');

########################################################################################################
#                     测试 -- 结束
########################################################################################################
 */