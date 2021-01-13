#1.查询工资最低的员工信息：last_name, salary

SELECT last_name, salary
FROM employees e
WHERE e.`salary` = (
	SELECT MIN(salary)
	FROM employees
);

#2.查询平均工资最低的部门信息

SELECT d.*
FROM departments d, (
	SELECT AVG(salary) AS avg_sal, department_id
	FROM employees e
	GROUP BY department_id
	ORDER BY avg_sal
	LIMIT 1) AS dep_avg_sal
WHERE d.department_id = dep_avg_sal.department_id;

#alt_ans

SELECT d.*
FROM departments d
WHERE d.`department_id` = (
	SELECT AVG(salary), department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) = (
		SELECT MIN(ag)
		FROM (
			SELECT AVG(salary) ag, department_id
			FROM employees
			GROUP BY department_id
		) AS ag_dep
	)
)


#3.查询平均工资最低的部门信息和该部门的平均工资

SELECT d.*, dep_avg_sal.avg_sal
FROM departments d
JOIN (
	SELECT AVG(salary) AS avg_sal, department_id
	FROM employees e
	GROUP BY department_id
	ORDER BY avg_sal
	LIMIT 1) AS dep_avg_sal
ON d.department_id = dep_avg_sal.department_id;

#4.查询平均工资最高的job信息

SELECT j.*
FROM jobs j
JOIN (
	SELECT AVG(salary) avg_sal, job_id
	FROM employees e
	GROUP BY job_id
	ORDER BY avg_sal DESC
	LIMIT 1
) AS t1
ON j.`job_id` = t1.job_id

#5.查询平均工资高于公司平均工资的部门

SELECT d.*
FROM departments d
JOIN (
	SELECT AVG(salary) avg_sal, department_id
	FROM employees
	GROUP BY department_id
	HAVING avg_sal > (
		SELECT AVG(salary) avg_sal
		FROM employees
	)
) AS t1
ON d.department_id = t1.department_id;


#6.查询公司所有的manager详细信息

SELECT e.*
FROM employees e
WHERE e.`employee_id` IN (
	SELECT DISTINCT manager_id
	FROM employees
);

#7.各个部门中，最高工资中最低的那个部门的 最低工资是多少

SELECT MIN(t1.max_sal) min_sal
FROM (
	SELECT MAX(salary) max_sal, e.`department_id`
	FROM employees e
	GROUP BY department_id
) AS t1;


#8.查询平均工资最高的部门的manager的详细信息：last_name, department_id, email, salary

#平均工资最高的部门
SELECT AVG(salary) avg_sal, e.`department_id`
FROM employees e
GROUP BY e.`department_id`
ORDER BY avg_sal DESC
LIMIT 1

#平均工资最高的部门的manager_id
SELECT manager_id
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM (
		SELECT AVG(salary) avg_sal, e.`department_id`
		FROM employees e
		GROUP BY e.`department_id`
		ORDER BY avg_sal DESC
		LIMIT 1
	) AS t1
);

SELECT e.*
FROM employees e
WHERE e.`employee_id` = (
	SELECT manager_id
	FROM departments
	WHERE department_id = (
		SELECT department_id
		FROM (
			SELECT AVG(salary) avg_sal, e.`department_id`
			FROM employees e
			GROUP BY e.`department_id`
			ORDER BY avg_sal DESC
			LIMIT 1
		) AS t1
	)
);