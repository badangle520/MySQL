USE myemployees;

# 进阶4: 常见函数
/*
函数: 功能/概念, 类似于java的方法, 将一组逻辑语句封装在方法体中, 对外暴露方法名
好处: 1. 隐藏了实现细节 2. 提高代码的重要性
调用: SELECT 函数名(实参列表) [From 表]
特点: 1.叫什么(函数名)
     2.干什么(函数功能)
分类: 1. 单行函数; 如: concat, length, ifnull等
     2. 分组函数; 功能:做统计使用, 又称为统计函数, 聚合函数, 组函数
常见函数:
    字符函数: LENGTH, CONCAT SUBSTR, INSTR, TRIM, REPLACE, UPPER, LOWER, LPAD, RPAD
    数学函数: ROUND, CEIL, FLOOR, TRUNCATE, MOD
    日期函数: NOW, CURDATE, CURTIME, YEAR, MONTH, MONTHNAME, DAY, HOUR, MINUTE, SECOND, STR_TO_DATE, DATE_FORMAT
    其他函数: VERSION, DATABASE, USER
    控制函数: IF, CASE


*/

#一, 字符函数
#1. LENGTH 字段长度
SELECT LENGTH('johh');
SELECT LENGTH('张三丰hahaha');

SHOW VARIABLES LIKE '%char%';
# UTF8编码中文占3个字节

#2. CONCAT 拼接字符串
SELECT concat(last_name,'_',first_name) FROM employees;

#3. UPPER, LOWER
SELECT UPPER('john');
SELECT LOWER('JOHN');
#示例: 将姓变成大写, 名变成小写, 然后拼接
SELECT CONCAT(UPPER(last_name),'_',LOWER(first_name)) FROM employees;

#4. substr, substring 数据截取
#注意, 索引从1开始
#截取从指定索引处后面所有字符
SELECT SUBSTR('李莫愁爱上了陆展元',7) out_put;
SELECT SUBSTR('李莫愁爱上了陆展元' FROM 7) out_put;
#截取从指定所引处指定字符长度的字符
SELECT SUBSTR('李莫愁爱上了陆展元',1,3) out_put;
SELECT SUBSTR('李莫愁爱上了陆展元' FROM 1 FOR 3) out_put;

#案例: 姓名中首字符大写, 其他字符小写然后用_拼接, 显示出来
SELECT CONCAT(UPPER(SUBSTR(first_name,1,1)),'_',LOWER(SUBSTR(first_name, 2))) FROM employees;

#5. instr 返回子串第一次出现的索引, 如果找不到返回0

SELECT INSTR('杨不悔爱上了殷六侠','殷六侠') 起始索引;
SELECT INSTR('杨不悔爱上了殷六侠','殷八侠') 起始索引;
SELECT INSTR('杨不悔殷六侠爱上了殷六侠','殷六侠') 起始索引;

#6. trim
SELECT '     张翠山     ' 姓名,  LENGTH('     张翠山     ') 长度;
SELECT TRIM('     张翠山     ') 姓名, LENGTH(TRIM('     张翠山     ')) 长度;

SELECT TRIM('张aaaa翠aaaaaaaa山aaaaaaaaaa') OUT_PUT;

SELECT TRIM('a' FROM 'aaa张aaaa翠aaaaaaaa山aaaaaaaaaa') OUT_PUT;
SELECT TRIM(BOTH 'a' FROM 'aaa张aaaa翠aaaaaaaa山aaaaaaaaaa') OUT_PUT;
SELECT TRIM(TRAILING 'a' FROM 'aaa张aaaa翠aaaaaaaa山aaaaaaaaaa') OUT_PUT;
SELECT TRIM(LEADING 'a' FROM 'aaa张aaaa翠aaaaaaaa山aaaaaaaaaa') OUT_PUT;

#7. lpad 用指定的字符实现左填充指定长度

 SELECT LPAD('殷素素',10,'*') out_put;
 SELECT LPAD('殷素素',2,'*') out_put;

#8. rpad 用指定的字符实现左填充指定长度

 SELECT RPAD('殷素素',10,'*') out_put;
 SELECT RPAD('殷素素',2,'*') out_put;

#9. replace 替换

 SELECT  REPLACE('张无忌爱上了周芷若','周芷若','赵敏');
 SELECT  REPLACE('周芷若张无忌爱上了周芷若','周芷若','赵敏');
 SELECT REPLACE('aaa张aaaa翠aaaaaaaa山aaaaaaaaaa','a','') OUT_PUT;


#二, 数学函数
#1. ROUND 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.65,1);
SELECT ROUND(-1.45);
SELECT ROUND(-1.65);
SELECT ROUND(-1.45,1);

#2 ceil 向上取整, 返回>=该参数的最小整数
SELECT CEIL(1.00);
SELECT CEIL(1.02);
SELECT CEIL(-1.00);
SELECT CEIL(-1.02);

#2 floor 向下取整, 返回<=该参数的最大整数
SELECT FLOOR(9.99);
SELECT FLOOR(-9.99);

#3 TRUNCATE 截断
SELECT TRUNCATE(1.69999,2);

#4 MOD 取余
#MOD(a,b)  :  a-a/b*b
#MOD(-10,-3): -10-(-10)/(-3)*(-3)=-1

SELECT MOD(10,3);
SELECT MOD(-10,3);
SELECT MOD(-10,-3);
SELECT 10%3;

#三, 日期函数
#1. NOW 返回当前系统日期+时间
SELECT NOW();

#2. CURDATE 返回当前系统日期, 不包含时间
SELECT CURDATE();

#3. CURTIME 返回当前系统时间, 不包含日期
SELECT CURTIME();

#可以获取指定的部分: 年, 月, 日, 小时, 分钟, 秒
SELECT YEAR(NOW())      年;
SELECT MONTH(NOW())     月;
SELECT MONTHNAME(NOW()) 月名;
SELECT DAY(NOW())       日;
SELECT HOUR(NOW())      时;
SELECT MINUTE(NOW())    分;
SELECT SECOND(NOW())    秒;

SELECT YEAR(hiredate) 年 FROM employees;

#4. STR_TO_DATE 将字符通过自定的格式转换成日期
SELECT str_to_date('1998-3-2','%Y-%m-%d') out_put;

#查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%m-%d %Y');

#DATE_FORMAT 将日期转换成字符
SELECT DATE_FORMAT('2020-8-24','%Y年%m月%d日') out_put;

#查询有奖金的员工名和入职日期(xx月/xx日/xx年)

select first_name,DATE_FORMAT(hiredate,'%m月/%d日/%y年') FROM employees WHERE NOT commission_pct IS NULL;

#四, 其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#五, 流程控制函数
#1 IF函数, IF ELSE的效果
SELECT IF(10>5,'大','小');
SELECT first_name,commission_pct,IF(commission_pct IS NULL,'没奖金 哈哈','有奖金 嘻嘻') out_put FROM employees;

#2 CASE函数的使用一,  switch case的效果
/*
JAVA
switch(变量或表达式);
    case 敞亮1;语句1; break;
    ...
    default:语句n;break;

MySQL
CASE 要判断的字段或表达式
WHEN 常量1 THEN 要显示的值1 或 语句1;
WHEN 常量2 THEN 要显示的值2 或 语句2;
...
ELSE 要显示的值n 或语句n;
END
*/

/*
案例, 查询员工的工资, 要求
部门号=30, 显示的工资为1.1
部门号=40, 显示的工资为1.2
部门号=50, 显示的工资为1.3
其他部门, 显示的工资为工资
 */

SELECT first_name,department_id,salary 原始工资,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END 新工资
FROM employees;

SELECT first_name,department_id,salary 原始工资,
CASE department_id
WHEN 30 THEN '1.1倍工资'
WHEN 40 THEN '1.2倍工资'
WHEN 50 THEN '1.3倍工资'
ELSE '1.0倍工资'
END 新工资
FROM employees;

SELECT first_name,department_id,salary 原始工资,
CASE
WHEN department_id=30 THEN salary*1.1
WHEN department_id=40 THEN salary*1.2
WHEN department_id=50 THEN salary*1.3
ELSE salary
END 新工资
FROM employees;

#3 CASE函数的使用二,  类似于 多重if
/*
 JAVA中
 if(条件1){
    语句1;
 }else if(条件2){
          语句2;
 }

 MySQL中
 CASE
 WHEN 条件1 THEN 要显示的值1 或 语句1;
 WHEN 条件2 THEN 要显示的值2 或 语句2;
 WHEN 条件3 THEN 要显示的值3 或 语句3;
 ...
 ELSE 要显示的值n 或 语句n
 END
 */

#案例: 查询员工的工资情况
/*
 如果工资>20000, 显示A级别
 如果工资>15000, 显示B级别
 如果工资>10000, 显示C级别
 否则,显示D级别
 */

#搜索函数可以写判断，并且搜索函数只会返回第一个符合条件的值，其他case被忽略
SELECT first_name,salary 工资,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END 级别
FROM employees;

########################################################################################################
#                     测试 -- 开始
########################################################################################################

#1. 显示系统时间(注:日期+时间)
SELECT NOW();

#2. 查询员工号，姓名，工资，以及工资提高百分之 20%后的结果(new salary)
SELECT employee_id,first_name,salary,salary*1.2 "new salary" FROM employees;

#3. 将员工的姓名按首字母排序，并写出姓名的长度(length)
SELECT SUBSTR(first_name,1,1) 首字母,first_name,LENGTH(first_name) FROM employees ORDER BY SUBSTR(first_name,1,1) ASC;

/*
 4. 做一个查询，产生下面的结果
 <last_name> earns <salary> monthly but wants <salary*3>
 |--------------------------------------------------------|
 |                        Dream Salary                    |
 |--------------------------------------------------------|
 |        King earns 24000 monthly but wants 72000        |
 |                                                        |
 |--------------------------------------------------------|
 */
SELECT CONCAT(last_name,' earns ',TRUNCATE(salary,0),' monthly but wants ',salary*3) AS "DREAM SALARY" FROM employees WHERE salary=24000;

/*
 5. 使用 case-when，按照下面的条件:
    job     grade
    AD_PRES A
    ST_MAN  B
    IT_PROG C
    SA_REP  D
    ST_CLERK E
 产生下面的结果
    Last_name Job_id   Grade
    king      AD_PRES  A
 */

 SELECT last_name,job_id JOB,
     CASE job_id
        WHEN 'AD_PRES'  THEN 'A'
        WHEN 'ST_MAN'   THEN 'B'
        WHEN 'IT_PROG'  THEN 'C'
        WHEN 'SA_REP'   THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
     END grade
 FROM employees WHERE job_id='AD_PRES';



########################################################################################################
#                     测试 -- 结束
########################################################################################################