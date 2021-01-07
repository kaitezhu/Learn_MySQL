#1.查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有，用null填充
SELECT bo.*, b.`id` GIRL_ID, b.`name` GIRL_NAME
FROM beauty b
LEFT JOIN boys bo
ON bo.`id` = b.`boyfriend_id`
WHERE b.`id` > 3;


#2.查询哪个城市没有部门
SELECT city, department_id
FROM locations l
LEFT JOIN departments d
ON l.`location_id` = d.`location_id`
WHERE department_id IS NULL;

#3.查询部门名为SAL或IT的员工信息
SELECT d.`department_name`, e.*
FROM departments d
LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE department_name IN('SAL','IT');