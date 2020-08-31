########################################################################################################
#                     测试 -- 开始
########################################################################################################
已知表 stuinfo
id      学号
name    姓名
email   邮箱    John@126.com
gradeId 年级编号
sex     性别    男,女
age     年龄

已知表  grade
id        年级编号
gradeName 年级名称

一, 查询所有学员的邮箱的用户名,(注:邮箱中@前面的字符)
SELECT substr(email,1,)instr(email,'@')-1) FROM stuinfo;

二, 查询男生和女生的个数
SELECT COUNT(*),sex FROM stuinfo GROUP BY sex;

三, 查询年龄>18岁的所有学生的姓名和年级名称
SELECT name,gradeName from stuinfo s INNER JOIN grade g on s.gradeId=g.id WHERE s.age>18

四, 查询哪个年级的学生最小年龄>20岁
SELECT Min(age) FROM stuinfo GROUP BY gradeId HAVING Min(age)>20


五, 试说出查询语句中涉及到的所有的关键字,以及执行先后顺序
SELECT 查询列表         step 7
FROM 表1               step 1
连接类型 JOIN 表2       step 2
ON 连接条件             step 3
WHERE 筛选条件          step 4
GROUP BY 分组列表       step 5
HAVING 分组后的筛选      step 6
ORDER BY 排序列表       step 8
LIMIT 偏移,条目数        step 9


########################################################################################################
#                     测试 -- 结束
########################################################################################################