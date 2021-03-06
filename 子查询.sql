#进阶7：子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句，称为主查询或外查询

分类：
按子查询出现的位置：
	select后面
		标量子查询
	from后面
		表子查询
	where或having后面（***）
		标量子查询（单行）（***）
		列子查询（多行）（***）
		行子查询
	exists后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）
*/

#一。where或having后面
#1.标量子查询（单行子查询）
#2.列子查询（多行子查询）

#3.行子查询（一行多列）

/*
特点：
1.子查询放在小括号内
2.子查询一般放在条件的右侧
3.标量子查询，一般搭配着单行操作符使用 > < >= <= = <>
4.列子查询，一般搭配着多行操作符使用 in any/some all
5.子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果
*/

#1.标量子查询
#案例1：谁的工资比Abel高？

#（1）.查询Abel工资
SELECT salary FROM employees WHERE last_name = 'Abel';

#（2）.查询员工的信息，满足salary > 1结果
SELECT *
FROM employees
WHERE salary > (
	SELECT salary 
	FROM employees 
	WHERE last_name = 'Abel'
);

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工 姓名，job_id和工资

#（1）.查询141号员工的job_id
SELECT job_id
FROM employees
WHERE employee_id = 141

#（2）.查询143号员工的salary
SELECT salary
FROM employees
WHERE employee_id = 143

#（3）.查询员工的姓名、job_id和工资，要求job_id = #1 而且 salary > #2
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
) AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143
);

#案例3：返回工资工资最少的员工的last_name, job_id, salary

#（1）.查询最低工资
SELECT MIN(salary)
FROM employees

#（2）.查询last_name, job_id, salary， 要求salary = #1
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);


#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资 having

#（1）.查询50号部门的最低工资
SELECT MIN(salary)
FROM employees
WHERE department_id = 50

#（2）.查询每个部门的最低工资
SELECT MIN(salary)
FROM employees
GROUP BY department_id;

#（3）.筛选2，满足大于 min sal > 1
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

#非法使用标量子查询
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);


#2.列子查询（多行子查询）
/*
-返回多行
-使用多行比较操作符
-体会any和all的区别
IN/NOT IN - 等于列表中的任意一个
ANY / SOME - 和子查询返回的某一个值比较
ALL - 和子查询返回的所有值比较
*/

#案例1：返回location_id是1400或1700的部门中的所有员工姓名

#（1）.查询location_id是1400或1700的部门编号
SELECT department_id
FROM departments
WHERE location_id IN (1400, 1700)

#（2）.查询员工姓名，要求部门号是1列表中的某一个
SELECT last_name
FROM employees
WHERE department_id IN(
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);


#案例2：返回其他部门中比job_id为'IT_PROG'部门任意工资低的员工

#（1）.查询job_id为'IT_PROG'部门最低工资
SELECT MIN(salary) min_sal
FROM employees
WHERE job_id = 'IT_PROG'

#或者
SELECT DISTINCT salary
FROM employees
WHERE job_id = 'IT_PROG'

#（2）.
SELECT employees.*
FROM employees
WHERE salary < (
	SELECT MIN(salary) min_sal
	FROM employees
	WHERE job_id = 'IT_PROG'
);

#或者
SELECT last_name, employee_id, salary
FROM employees
WHERE salary < ANY (
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
)  AND job_id <> 'IT_PROG';

#案例3：返回其他部门中比job_id为'IT_PROG'部门所有工资低的员工
SELECT last_name, employee_id, salary
FROM employees
WHERE salary < ALL (
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
)  AND job_id <> 'IT_PROG';

#3.行子查询（结果集为一行多列或多行多列）

#案例：查询员工编号最小并且工资最高的员工信息

SELECT employees.*
FROM employees
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary)
	FROM employees
);


#（1）.查询最小的员工编号
SELECT MIN(employee_id)
FROM employees

#（2）.查询最高工资
SELECT MAX(salary)
FROM employees

#（3）.查询员工信息
SELECT *
FROM employees
WHERE employee_id = (
	SELECT MIN(employee_id)
	FROM employees
) AND salary = (
	SELECT MAX(salary)
	FROM employees
);

#二。select后面
/*
仅仅支持标量子查询
*/

#案例：查询每个部门的员工个数
SELECT department_name, (
	SELECT COUNT(*)
	FROM employees
	WHERE employees.`department_id` = departments.`department_id`
) AS emp_number
FROM departments




#案例2：查询员工号=102的部门名
SELECT (
	SELECT department_name
	FROM departments d
	INNER JOIN employees e
	ON d.department_id = e.department_id
	WHERE e.employee_id = 102
	
);


#三。from后面
/*
将子查询结果充当一张表，要求必须起别名
*/

#案例：查询每个部门的平均工资的等级

#（1）查询每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id

#（2）2连接1的结果集和job_grades表，筛选条件平均工资between lowest_sal and highest_sal

SELECT dep_avg_sal.*, g.grade_level
FROM (
	SELECT AVG(salary) AS avg_sal, department_id
	FROM employees
	GROUP BY department_id
) AS dep_avg_sal
INNER JOIN job_grades g
ON dep_avg_sal.avg_sal BETWEEN lowest_sal AND highest_sal

#四。exists后面（相关子查询）
/*
语法：
exists（完整的查询语句）
结果：1或0
*/

SELECT EXISTS(SELECT employee_id FROM employees WHERE salary=300000);

#案例1：查询有员工的部门名

#in
SELECT department_name
FROM departments d
WHERE d.`department_id` IN (
	SELECT department_id
	FROM employees e
);

SELECT department_name
FROM departments d
WHERE EXISTS (
	SELECT *
	FROM employees e
	WHERE e.`department_id` = d.`department_id`
);

#案例2：查询没有女朋友的男神信息

#in
SELECT bo.*
FROM boys bo
WHERE bo.id NOT IN (
	SELECT boyfriend_id
	FROM beauty
);

#exists
SELECT bo.*
FROM boys bo
WHERE NOT EXISTS (
	SELECT b.boyfriend_id
	FROM beauty b
	WHERE b.`boyfriend_id` = bo.`id`
);

