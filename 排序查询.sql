#进阶3：排序查询
/*
1. order by子句中可以支持单个字段或多个字段，表达式，函数，别名
2. 一般放在查询语句最后面，limit子句除外
*/

SELECT * FROM employees;

#案例：查询员工信息，要求工资从高到低排序
#默认为升序
SELECT * FROM employees ORDER BY salary DESC;

SELECT * FROM employees ORDER BY salary;

#案例2：查询部门编号大于等于90的员工信息，按入职时间进行排序
SELECT * 
FROM employees 
WHERE department_id >= 90 
ORDER BY hiredate;

#案例3：按年薪的高低显示员工的信息和年薪
SELECT *, salary * 12 * (1 + IFNULL (commission_pct, 0)) AS annual_sal
FROM employees
ORDER BY annual_sal DESC;

#案例4：按姓名的长度显示员工的姓名和工资
SELECT LENGTH(last_name) AS name_len, last_name, salary
FROM employees
ORDER BY name_len DESC;

#案例5：查询员工信息，要求先按工资排序，再按员工编号排序
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;