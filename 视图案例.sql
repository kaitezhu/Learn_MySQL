#视图练习

#1.创建视图emp_v1，要求查询电话号码以011开头的员工姓名和工资、邮箱
CREATE OR REPLACE VIEW emp_v1
AS
SELECT last_name, salary, email
FROM employees
WHERE phone_number LIKE '011%';

#2.创建视图emp_v2，要求查询部门的最高工资高于12000的部门信息
CREATE OR REPLACE VIEW emp_v2
AS
SELECT MAX(salary) AS max_sal, department_id
FROM employees
GROUP BY department_id
HAVING max_sal > 12000;

#然后查询想要的信息
SELECT d.*, emp_v2.max_sal
FROM departments d
JOIN emp_v2
ON emp_v2.department_id=d.`department_id`;

#原来的写法
SELECT d.*, max_sal
FROM departments d
JOIN (
	SELECT MAX(salary) AS max_sal, department_id
	FROM employees
	GROUP BY department_id
	HAVING max_sal > 12000
) AS dep_max
ON dep_max.department_id = d.department_id;