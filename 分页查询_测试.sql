/*
已知表 stuinfo
-id
-name
-email
-gradeId
-sex
-age

grade
-id
-gradeName
*/

#1.查询所有学员的邮箱的用户名（@前面的字符）

SELECT SUBSTR(email, 1, INSTR(email, '@') - 1) AS username
FROM stuinfo;

#2.查询男生和女生的个数

SELECT COUNT(*), sex
FROM stuinfo
GROUP BY sex;

#3.查询年龄>18岁的所有学生的姓名和年级名称

SELECT NAME, grade_name
FROM stuinfo s
JOIN grade g
ON s.gradeId = g.id
WHERE s.age > 18;

#4.查询哪个年级的学生最小年龄>20

SELECT MIN(age) AS min_age, grade_id
FROM stuinfo
GROUP BY grade_id
HAVING min_age > 20

#5.说出查询语句中涉及到的所有关键字，以及执行先后顺序！！

SELECT 查询列表		7
FROM 表			1
连接类型 JOIN 表2	2
ON 连接条件		3
WHERE 筛选条件		4
GROUP BY 分组列表	5
HAVING 分组后的筛选	6
ORDER BY 排序列表	8
LIMIT 偏移，条目数	9