#进阶6：连接查询
/*
多表查询

笛卡尔乘积现象：表1有m行，表2有n行，结果为mn行
如何避免：添加有效的连接条件

分类：
	按年代分类
	-sql92标准：仅支持内连接
	-sql99标准 【推荐】：支持内+外+交叉连接
	
	按功能分类：
	-内连接
		等值连接
		非等值连接
		自连接
	-外连接
		左外连接
		右外连接
		全外连接
	-交叉连接
		

*/

SELECT * FROM beauty;

SELECT * FROM boys;

SELECT NAME, boyName FROM boys, beauty
WHERE beauty.`boyfriend_id` = boys.`id`

#一。sql92标准

/*
1.多表等值连接的结果为多表交集的部分
2.n表连接，至少需要n-1个连接条件
3.多表的顺序没有要求
4.一般需要为表起别名
5.可以搭配前面的所有子句使用

*/

#1.等值连接

#案例1：查询女神名和对应的男神名
SELECT NAME, boyName 
FROM beauty, boys
WHERE beauty.`boyfriend_id` = boys.`id`;

#案例2：查询员工名和对应的部门名
SELECT last_name, department_name
FROM employees, departments
WHERE employees.`department_id` = departments.`department_id`;

#2.为表起别名
#提高语句的简介度
#区分多个重名字段
#如果为表起了别名，就不能使用原名查询
#查询员工名，员工号，工种名
SELECT last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

#3.两个表的顺序是否可以调换
#查询员工名，员工号，工种名
SELECT last_name, e.job_id, job_title
FROM jobs j, employees e
WHERE e.job_id = j.job_id;

#4.可以加筛选

#案例：查询有奖金的员工名，部门名
SELECT last_name, department_name, commission_pct
FROM employees emp, departments dep
WHERE emp.commission_pct IS NOT NULL
AND emp.`department_id` = dep.`department_id`;

#案例2：查询城市名中第二个字符为o的部门名和城市名
SELECT department_name, city
FROM departments dep, locations loc
WHERE dep.`location_id` = loc.`location_id`
AND loc.`city` LIKE '_o%';

#5.分组
#案例：查询每个城市的部门个数
SELECT COUNT(*), city
FROM departments dep, locations loc
WHERE dep.`location_id` = loc.`location_id`
GROUP BY city;

#案例2：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT department_name d_name, dep.manager_id m_id, MIN(salary) min_sal
FROM departments dep, employees emp
WHERE dep.`department_id` = emp.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name;

#6.排序

#案例：查询每个工种的工种名和员工的个数，并且按员工个数降序

SELECT job_title, COUNT(*) total_emp
FROM jobs j, employees e
WHERE j.`job_id` = e.`job_id`
GROUP BY job_title
ORDER BY total_emp DESC;

#7.三表连接

#案例：查询员工名、部门名和所在的城市

SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`
AND city LIKE 's%';


#2.非等值连接

#案例1：查询员工的工资和工资级别

SELECT salary, grade_level
FROM employees e, job_grades
WHERE salary BETWEEN lowest_sal AND highest_sal;


#3.自连接

#案例：查询员工名和上级的名称

SELECT e.employee_id emp_id, e.last_name emp_name, m.employee_id leader_id, m.last_name leader_name
FROM employees e, employees m
WHERE e.`manager_id` = m.`employee_id`;
