#DDL
/*

数据定义语言

库和表的管理

一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建： create
修改： alter
删除： drop

*/

#一、库的管理
#1、库的创建
/*
语法：
create database  [if not exists]库名;
*/


#案例：创建库Books

CREATE DATABASE IF NOT EXISTS books ;


#2、库的修改

RENAME DATABASE books TO 新库名;

#更改库的字符集

ALTER DATABASE books CHARACTER SET gbk;


#3、库的删除

DROP DATABASE IF EXISTS books;




#二、表的管理
#1.表的创建 ★

/*
语法：
create table 表名(
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	...
	列名 列的类型【(长度) 约束】


)


*/
#案例：创建表Book

CREATE TABLE book(
	id INT,#编号
	bName VARCHAR(20),#图书名
	price DOUBLE,#价格
	authorId  INT,#作者编号
	publishDate DATETIME#出版日期
);




ALTER TABLE book CHANGE COLUMN pubDate pubDate DATETIME;

DESC book;

#案例：创建表author
CREATE TABLE IF NOT EXISTS author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(10)

)
DESC author;


#2.表的修改

/*
语法
alter table 表名 add|drop|modify|change column 列名 【列类型 约束】;

*/

#①修改列名

ALTER TABLE book CHANGE COLUMN publishdate pubDate DATETIME;


#②修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;

#③添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;

#④删除列

ALTER TABLE book_author DROP COLUMN  annual;
#⑤修改表名

ALTER TABLE author RENAME TO book_author;

DESC book;




#3.表的删除

DROP TABLE IF EXISTS book_author;

SHOW TABLES;


#通用的写法：

DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 新库名;


DROP TABLE IF EXISTS 旧表名;
CREATE TABLE  表名();



#4.表的复制

INSERT INTO author VALUES
(1,'村上春树','日本'),
(2,'莫言','中国'),
(3,'冯唐','中国'),
(4,'金庸','中国');

SELECT * FROM Author;
SELECT * FROM copy2;
#1.仅仅复制表的结构

CREATE TABLE copy LIKE author;

#2.复制表的结构+数据
CREATE TABLE copy2
SELECT * FROM author;

#只复制部分数据
CREATE TABLE copy3
SELECT id,au_name
FROM author
WHERE nation='中国';


#仅仅复制某些字段

CREATE TABLE copy4
SELECT id,au_name
FROM author
WHERE 0;


########################################################################################################
#                     测试 -- 开始
########################################################################################################
CREATE DATABASE IF NOT EXISTS test;

#1.	创建表dept1
NAME	NULL?	TYPE
id		        INT(7)
NAME		    VARCHAR(25)

USE test;

CREATE TABLE IF NOT EXISTS dept1(
    id      INT(7),
    NAME    VARCHAR(25)
);

#2.	将表departments中的数据插入新表dept2中
CREATE TABLE IF NOT EXISTS dept2
SELECT * FROM myemployees.departments;
SELECT * FROM dept2;

#3.	创建表emp5
NAME	    NULL?	TYPE
id		            INT(7)
First_name	        VARCHAR (25)
Last_name	        VARCHAR(25)
Dept_id		        INT(7)

CREATE TABLE IF NOT EXISTS emp5(
    id          INT(7),
    First_name	VARCHAR (25),
    Last_name	VARCHAR(25),
    Dept_id		INT(7)
);

#4.	将列Last_name的长度增加到50
ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);
DESC emp5;

#5.	根据表employees创建employees2
CREATE TABLE IF NOT EXISTS employees2 LIKE myemployees.employees;
DESC employees2;

#6.	删除表emp5
DROP TABLE IF EXISTS emp5;
DESC emp5;

#7.	将表employees2重命名为emp5
ALTER TABLE employees2 RENAME TO emp5;
DESC emp5;

#8.在表dept和emp5中添加新列test_column，并检查所作的操作
ALTER TABLE emp5 ADD COLUMN test_column VARCHAR(20);
DESC  emp5;

#9.直接删除表emp5中的列 dept_id
ALTER TABLE emp5 DROP COLUMN test_column;
DESC emp5;

########################################################################################################
#                     测试 -- 结束
########################################################################################################
