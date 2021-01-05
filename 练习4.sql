#1.查询各job_id的员工工资的最大值，最小值，平均值，总和，并按job_id升序

SELECT MAX(salary) max_sal, MIN(salary) min_sal, AVG(salary) avg_sal, SUM(salary) sum_sal, job_id job
FROM employees
GROUP BY job
ORDER BY job;

#2.查询员工最高工资和最低工资的差距(diff)

SELECT (MAX(salary) - MIN(salary)) AS diff
FROM employees;


#3.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT MIN(salary) min_sal, manager_id manager
FROM employees
WHERE manager IS NOT NULL
GROUP BY manager_id
HAVING min_sal >= 6000;

#4.查询所有部门的编号，员工数量和工资的平均值，并按照平均工资降序
SELECT department_id department, COUNT(*) emp_count, AVG(salary) avg_sal
FROM employees
GROUP BY department
ORDER BY avg_sal;

#5.选择具有各个job_id的员工人数
SELECT COUNT(*) emp_count, job_id
FROM employees
WHERE job_id IS NOT NULL
GROUP BY job_id;