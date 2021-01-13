#1.查询和Zlotkey相同部门的员工姓名和工资

SELECT last_name, salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'
);

#2.查询工资比公司平均工资高的员工的员工号、姓名和工资

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary) avg_sal
	FROM employees
);

#3.查询各部门中工资比本部门平均工资高的员工的员工号、姓名和工资

SELECT employee_id, last_name, salary, e.`department_id`
FROM employees e
JOIN (
	SELECT AVG(salary) AS avg_sal, department_id
	FROM employees
	GROUP BY department_id 
) dep_avg_sal
ON e.`department_id` = dep_avg_sal.department_id
WHERE salary > avg_sal

#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名

SELECT employee_id, last_name
FROM employees e
WHERE department_id  IN (
	SELECT DISTINCT department_id
	FROM employees e
	WHERE last_name LIKE '%u%'
);

#5.查询在部门的location_id为1700的部门工作的员工的员工号

SELECT employee_id
FROM employees e
WHERE e.`department_id` IN (
	SELECT DISTINCT d.`department_id`
	FROM departments d
	WHERE d.`location_id` = 1700
);

#6.查询管理者是King的员工姓名和工资

SELECT last_name, salary
FROM employees
WHERE manager_id IN (
	SELECT employee_id
	FROM employees
	WHERE last_name = 'K_ing'	
);

#7.查询工资最高的员工姓名，要求first_name和last_name显示为一列，列名为 姓、名

SELECT CONCAT(first_name, ' ', last_name) AS 姓名
FROM employees e
WHERE e.`salary` = (
	SELECT MAX(salary) AS max_sal
	FROM employees
);