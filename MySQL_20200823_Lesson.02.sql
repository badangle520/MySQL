USE myemployees;

#进阶2: 条件查询

/*
语法:
SELECT 查询列表 FROM 表名 WHERE 筛选条件;

执行顺序:
FROM > WHERE > SELECT

分类:
1. 按条件表达式筛选
 条件运算符: > < = != <>
2. 按逻辑表达式筛选，用于连接条件表达式
 逻辑运算符: && || ! and or not
    && 和 and： 两个条件都为true， 结果为true，反之为false
    || 或 or ： 如果一个条件为true，结果为true，反之为false
     ！或 not ：如果连接的条件本身为false，结果为true，反之为false

3. 模糊查询
 like
 between and
 in
 is null
*/

#一、 按条件表达式
#案例1：查询工资>12000的员工信息
SELECT * FROM employees where salary > 12000;

#案例2：查询部门编号不等于90号的员工名和部门编号
SELECT first_name, department_id FROM employees WHERE department_id <> 90;

#二、 按逻辑表达式筛选
#案例1： 查询工资在1000到20000之间的员工名，工资以及奖金
select first_name,salary,commission_pct from employees WHERE salary>=10000 and salary<=20000;

select first_name,salary,commission_pct from employees WHERE salary BETWEEN 10000 and 20000;

#案例2: 查询部门编号不是在90到110之间的, 或者工资高于15000的员工信息
select * from employees where department_id<90 OR department_id>110 or salary>15000;

select * from employees where not (department_id>=90 AND department_id<=110) or salary>15000;

select * from employees where department_id NOT BETWEEN 90 AND 110 or salary>15000;

# 三 模糊查询
/*
like
特点: 1 一般和通配符搭配使用
        % 任意多个字符, 包含0个字符
        _ 任意单个字符

between and
in
is null
is not null
*/
#1. like
# 案例1: 查询员工名中包含字符a的员工信息
SELECT * FROM employees WHERE first_name LIKE '%a%';

# 案例2: 查询员工名中第三个字符为e, 第五个字符为a的员工名和工资
select * from employees where first_name like '__e_a%';

# 案例3: 查询员工名中第二个字符为_的员工名 (默认转义字符\, 也可搭配ESCAPE和任意字符实现转义)
select * from employees where last_name like '_\_%';
select * from employees where last_name like '_$_%' ESCAPE '$';

#2. between and
/*
1 使用between and可以提供语句的简洁度
2 包含临界值
3 2个临界值不能调换顺序
*/

# 案例1: 查询员工编号在100到120之间的员工信息
select * from employees where employee_id>=100 and employee_id <=120;
select * from employees where employee_id BETWEEN 100 and 120;
#--------------------
select * from employees where employee_id BETWEEN 120 and 100;

#3. in
/*
含义: 判断某字段的值是否属于in列表中的某一项
1. 提高语句简洁度
2. in列表的值类型必须统一或兼容
3. in列表的值不支持通配符
*/
#案例: 查询员工的工种编号是 IT_PROG, AD_VP, AD_PRES中的一个员工名和工种编号
SELECT first_name,job_id from employees WHERE job_id = 'it_prog' OR  job_id= 'ad_vp' OR  job_id = 'ad_pres';
#--------------------
SELECT first_name,job_id from employees WHERE job_id in ('it_prog','ad_vp','ad_pres');

#4. is null
#案例1: 查询没有奖金的员工名和奖金率
select first_name,commission_pct from employees where commission_pct = null;

select first_name,commission_pct from employees where commission_pct is null;

select first_name,commission_pct from employees where commission_pct is not null;

select first_name,commission_pct from employees where NOT commission_pct is null;

#5. 安全等于 <=>
#案例1: 查询没有奖金的员工名和奖金率
select first_name,commission_pct from employees where commission_pct <=> null;

select first_name,commission_pct,salary from employees where salary <=> 12000;

# is null pk <=>
is null: 仅仅可以判断NUL值, 可读性高, 建议使用
<=>    : 既可以判断NULL值, 又可以判断普通的数值, 可读性低, 不建议使用

########################################################################################################
#                     测试 -- 开始
########################################################################################################

#1. 查询工资大于 12000 的员工姓名和工资
select count(*) FROM employees where first_name is NULL OR salary IS  NULL;
SELECT first_name,salary FROM employees WHERE salary > 12000;

#2. 查询员工号为 100 的员工的姓名和部门号和年薪
SELECT first_name,department_id,salary,salary*12*(1+commission_pct) AS 年薪 FROM employees WHERE employee_id = 100;
SELECT first_name,department_id,salary,salary*12*(1+ifnull(commission_pct,0)) AS 年薪 FROM employees WHERE  employee_id = 100;

# 3. 选择工资不在 5000 到 12000 的员工的姓名和工资
SELECT first_name,salary FROM employees WHERE NOT salary BETWEEN 5000 AND 12000;
SELECT first_name,salary FROM employees WHERE salary NOT BETWEEN 5000 AND 12000;

# 4. 选择在 20 或 50 号部门工作的员工姓名和部门号
SELECT first_name,department_id FROM employees WHERE department_id IN (20,50);

# 5. 选择公司中没有管理者的员工姓名及 job_id
SELECT  first_name, job_id FROM employees WHERE manager_id IS NULL;

# 6. 选择公司中有奖金的员工姓名，工资和奖金级别
SELECT first_name, salary, commission_pct FROM employees WHERE commission_pct IS NULL;

# 7. 选择员工姓名的第三个字母是 a 的员工姓名
SELECT first_name FROM employees WHERE first_name LIKE '__a%';

# 8. 选择姓名中有字母 a 和 e 的员工姓名
SELECT first_name FROM  employees WHERE first_name LIKE '%a%' OR first_name LIKE '%e%';

# 9. 显示出表 employees 表中 first_name 以 'e'结尾的员工信息
SELECT * FROM employees WHERE first_name LIKE '%e';

# 10. 显示出表 employees 部门编号在 80-100 之间 的姓名、职位
SELECT first_name, job_id, department_id FROM employees WHERE department_id BETWEEN 80 and 90;

# 11. 显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、职位
SELECT first_name,department_id,manager_id FROM employees WHERE manager_id IN (100,101,110);

#一 查询没有奖金, 且工资小于18000的salary, last_name
SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NULL AND salary < 18000;

#二 查询employee表中, job_id不为'IT'或者工资为12000的员工信息
SELECT * FROM employees WHERE NOT job_id LIKE 'IT%' OR salary =12000;
SELECT * FROM employees WHERE job_id NOT LIKE 'IT%' OR salary =12000;
SELECT * FROM employees WHERE NOT SUBSTR(job_id,1,2) = 'IT' OR salary = 12000;
SELECT * FROM employees WHERE SUBSTR(job_id,1,2) <> 'IT' OR salary = 12000;

#三 查看部门departments表的结构
DESC departments;

#四 查询部门deparments表中涉及到了哪些位置编号
SELECT DISTINCT location_id FROM departments;

#五 经典面试题: 以下SQL运行结果是否一样,并说明原因.
SELECT * FROM employees;
SELECT * FROM employees WHERE commission_pct LIKE '%%' AND last_name LIKE  '%%';
#第1句, 结果包含NULL
#第2句, 结果不包含NULL
SELECT * FROM employees WHERE commission_pct LIKE '%%' OR last_name LIKE  '%%';
#第3句, 因为last_name字段不含NULL, 且是使用的OR, 所以结果与第1句一致.

SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM employees WHERE NOT commission_pct IS NULL;
SELECT COUNT(*) FROM employees WHERE last_name IS NULL;

########################################################################################################
#                     测试 -- 结束
########################################################################################################
