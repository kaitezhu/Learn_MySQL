#视图
/*
含义：虚拟表，和普通表一样使用
mysql5.1版本出现的新特性，是通过表动态生成的数据

比如：舞蹈班和普通班级的对比

	创建语法的关键字	是否占用物理空间	使用

视图	create view		只保存了sql逻辑		增删改查，一般不能增删改

表	create table		保存了数据		增删改查

*/

#案例：查询姓张的学生名和专业名
CREATE VIEW v1
AS 
SELECT stuname, majorname
FROM stuinfo
INNER JOIN major m ON s.majorid=m.id;

SELECT * FROM v1 WHERE stuname LIKE '张%';

#一、创建视图
/*
语法：
create view name
as
查询语句；
*/

USE myemployees;
#1.查询姓名中包含a字符的员工名、部门名和工种信息
#（1）创建
CREATE VIEW myv1
AS
SELECT last_name, department_name, job_title
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN jobs j ON j.job_id=e.job_id;

#（2）使用
SELECT * FROM myv1 WHERE last_name LIKE '%a%';
 

#2.查询各部门的平均工资级别

CREATE VIEW myv2
AS
SELECT AVG(salary) avg_sal, department_id
FROM employees
GROUP BY department_id

SELECT myv2.avg_sal, g.grade_level
FROM myv2
JOIN job_grades g
ON myv2.`avg_sal` BETWEEN g.lowest_sal AND g.highest_sal;

#3.查询平均工资最低的部门信息

SELECT * FROM myv2 ORDER BY avg_sal LIMIT 1;

#4.查询平均工资最低的部门名和工资

CREATE VIEW myv3
AS
SELECT * FROM myv2 ORDER BY avg_sal LIMIT 1;

SELECT d.*, m.avg_sal
FROM myv3 m
JOIN departments d
ON m.department_id = d.`department_id`;


#二、视图的修改

#方式一：
/*
create or replace view 视图名
as
查询语句；

*/

SELECT * FROM myv3;

CREATE OR REPLACE VIEW myv3
AS
SELECT AVG(salary), job_id
FROM employees
GROUP BY job_id;

#方式二：
/*
alter view 视图名
as
查询语句；

*/

ALTER VIEW myv3
AS
SELECT * FROM employees;

#三、删除视图

/*
语法：
drop view 视图名，视图名,...
*/

DROP VIEW myv3;


#四、查看视图
DESC myv3;

SHOW CREATE VIEW myv3;


#五、视图的更新
/*

*/
DROP VIEW emp_v1, emp_v2;

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email
FROM employees;

SELECT * FROM myv1;
#1.插入
INSERT INTO myv1 VALUES('zhangfei','zf@qq.com');

#2.修改
UPDATE myv1 SET last_name='zhangfei' WHERE last_name='Gietz';

#3.删除
DELETE FROM myv1 WHERE last_name = 'zhangfei';

#具备以下特点的视图不允许更新

#（1）包含一下关键字的sql语句：分组函数,distinct,group by, having, union or union all

CREATE OR REPLACE VIEW myv1
AS
SELECT MAX(salary) m, department_id
FROM employees
GROUP BY department_id;

SELECT * FROM myv1;

#更新
UPDATE myv1 SET m=900 WHERE department_id=10;

#（2）常量视图
CREATE OR REPLACE VIEW myv2
AS
SELECT 'john' NAME;

SELECT * FROM myv2;

#更新
UPDATE myv2 SET NAME='lucy';

#（3）select中包含子查询
CREATE OR REPLACE VIEW myv3
AS
SELECT (SELECT MAX(salary) FROM employees) 最高工资;

#更新
SELECT * FROM myv3;
UPDATE myv3 SET 最高工资=100000;

#（4）join
CREATE OR REPLACE VIEW myv4
AS
SELECT last_name, department_name
FROM employees e
JOIN departments d
ON e.department_id=d.department_id;

SELECT * FROM myv4;
#更新
UPDATE myv4 SET last_name='zhangf' WHERE last_name='Fay';
INSERT INTO myv4 VALUES('chengzhen', 'xxx');

#（5）from一个不能更新的视图
CREATE OR REPLACE VIEW myv5
AS
SELECT * FROM myv3;

#（6）where子句的子查询引用了from子句中的表
CREATE OR REPLACE VIEW myv6
AS
SELECT last_name, salary
FROM employees
WHERE employee_id IN (
	SELECT manager_id
	FROM employees
	WHERE employee_id IS NOT NULL
);

SELECT * FROM myv6;

#更新
UPDATE myv6 SET salary=190000 WHERE last_name ='k_ing';