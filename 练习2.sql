#测试题
#1.查询没有奖金，且工资小于18000的salary，last_name
SELECT
	last_name,
	salary,
	commission_pct
FROM
	employees
WHERE
	salary < 18000 AND commission_pct IS NULL;
	
#2.查询employees表中，job_id不为"IT"或者工资为12000的员工信息
SELECT
	*
FROM
	employees
WHERE
	job_id NOT LIKE '%IT%' OR salary = 12000;

#3.查询departments结构

DESC departments;

#4.查询部门departments表中涉及到了哪些位置编号

SELECT DISTINCT location_id FROM departments;

#5.