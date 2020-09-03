########################################################################################################
#                     测试 -- 开始
########################################################################################################
USE student;

#一、查询每个专业的学生人数
SELECT majorid,COUNT(*) FROM student GROUP BY majorid;

#二、查询参加考试的学生中，每个学生的平均分、最高分
SELECT AVG(score),MAX(score),studentno FROM result GROUP BY studentno;

#三、查询姓张的每个学生的最低分大于60的学号、姓名
SELECT s.studentno,s.studentname,MIN(score)
FROM student s INNER JOIN result r ON s.studentno = r.studentno
WHERE substr(s.studentname,1,1)='张'
GROUP BY s.studentno
HAVING MIN(score)>60;

#四、查询生日在“1988-1-1”后的学生姓名、专业名称
SELECT s.studentname,m.majorname,s.borndate
FROM student s INNER JOIN major m ON s.majorid = m.majorid
WHERE s.borndate>'1988-01-01';

SELECT s.studentname,m.majorname,s.borndate
FROM student s INNER JOIN major m ON s.majorid = m.majorid
WHERE datediff(s.borndate,'1988-01-01')>0;

#五、查询每个专业的男生人数和女生人数分别是多少
方式一
SELECT majorid,sex,count(*) FROM student GROUP BY majorid,sex ORDER BY majorid;

方式二
SELECT majorid,
(SELECT COUNT(*) FROM student WHERE SEX='男' AND majorid=s.majorid) 男,
(SELECT COUNT(*) FROM student WHERE SEX='女' AND majorid=s.majorid) 女
FROM student s
GROUP BY majorid;

#六、查询专业和张翠山一样的学生的最低分
#①查询张翠山的专业编号
SELECT majorid
FROM student WHERE s.studentname ='张翠山';

#②查询编号=①的所有学生编号
SELECT studentno
FROM student
WHERE majorid=(SELECT majorid FROM student s WHERE s.studentname ='张翠山');

#②查询最低分
SELECT s.studentno,r.score
FROM student s JOIN result r ON s.studentno = r.studentno
WHERE majorid=(SELECT majorid FROM student WHERE studentname ='张翠山')
ORDER BY r.score ASC
LIMIT 1;

SELECT MIN(score)
FROM result
WHERE studentno IN (
    SELECT studentno
    FROM student
    WHERE majorid=(
        SELECT majorid
        FROM student
        WHERE studentname ='张翠山'
        )
    )
;

#七、查询大于60分的学生的姓名、密码、专业名
SELECT s.studentname,s.loginpwd,m.majorname
FROM student s
JOIN major m ON s.majorid = m.majorid
JOIN result r ON s.studentno = r.studentno
WHERE r.score>60;

#八、按邮箱位数分组，查询每组的学生个数
SELECT length(email) 邮箱长度,COUNT(*)
FROM student
GROUP BY LENGTH(email)

#九、查询学生名、专业名、分数
SELECT s.studentname,m.majorname,r.score
FROM student s
JOIN major m ON s.majorid = m.majorid
LEFT JOIN result r ON s.studentno = r.studentno;

#十、查询哪个专业没有学生，分别用左连接和右连接实现
#左
SELECT s.majorid,m.majorname,s.studentno
FROM student s
LEFT JOIN major m ON s.majorid = m.majorid
WHERE studentno IS NULL;

#右
SELECT s.majorid,m.majorname,s.studentno
FROM major m
RIGHT JOIN student sON s.majorid = m.majorid
WHERE studentno IS NULL;

#十一、查询没有成绩的学生人数
SELECT s.*,r.id
FROM student s
LEFT JOIN result r ON s.studentno = r.studentno
WHERE r.id IS NULL;

SELECT count(*)
FROM student s
LEFT JOIN result r ON s.studentno = r.studentno
WHERE r.id IS NULL;

########################################################################################################
#                     测试 -- 结束
########################################################################################################