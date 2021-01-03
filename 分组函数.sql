#1.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary) max_sal, MIN(salary) min_sal, ROUND(AVG(salary), 2) avg_sal, SUM(salary) sum_sal
FROM employees;

#2.查询员工中的最大入职时间和最小入职时间的相差天数
SELECT DATEDIFF(MAX(hiredate), MIN(hiredate)) AS diff
FROM employees;

#3.查询部门编号为90的员工个数
SELECT COUNT(*)
FROM employees
WHERE department_id = 90;