#1.显示系统时间
SELECT NOW();

#2.查询员工号，姓名，工资，以及工资提高百分之20之后的效果
SELECT employee_id, last_name, salary, salary*1.2 AS new_sal FROM employees;

#3.将员工的姓名按首字母排序，并写出姓名的长度
SELECT LENGTH(last_name) AS name_len, SUBSTR(last_name, 1, 1) AS first_char, last_name
FROM employees
ORDER BY first_char;

#4.查询 
<last_name> earns <salary> monthly but wants <salary * 3>
Dream Salary
King earns 24000 monthly but wants 72000

SELECT CONCAT(last_name, ' earns ', salary, ' monthly but wants ', salary * 3) AS dream_sal
FROM employees;

#5.使用case-when
job grade
ad_pres A
st_man B
IT_PROG C

SELECT last_name, job_id AS job,
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_PRE' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
END AS job_level
FROM employees;