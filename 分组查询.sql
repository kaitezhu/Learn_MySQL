#进阶5：分组查询
/*
分组前筛选
	数据源为原始表
	where -》 groupby前面
分组后筛选
	数据源为结果集
	having -》 grouphy后面
	
1.分组函数做条件肯定是放在having子句中
2.能用分组前筛选的，就优先使用
*/

#引入：查询每个部门的平均工资
SELECT ROUND(AVG(salary), 2), department_id
FROM employees
GROUP BY department_id;

#案例：查询每个工种的最高工资
SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id;

#案例2：查询每个位置上的部门个数
SELECT COUNT(*), location_id
FROM departments
GROUP BY location_id;

#添加筛选条件
#案例1：查询邮箱中包含a字符的，每个部门的平均工资
SELECT ROUND(AVG(salary), 2), department_id, email
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#案例2：查询有奖金的每个领导手下员工的最高工资
SELECT MAX(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#添加筛选条件
#案例1：查询哪个部门的员工个数>2
SELECT COUNT(*) AS empl_count, department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT job_id AS job, MAX(salary) max_sal
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING max_sal > 12000;

#案例3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及其最低工资
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING MIN(salary) > 5000;

#按表达式/函数分组
#案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些
SELECT COUNT(*) emp_count, LENGTH(last_name) len_name
FROM employees
GROUP BY len_name
HAVING emp_count > 5;