#显示表departments的结构，并查询其中的全部数据
DESC departments;

SELECT * FROM departments;

#显示出表employees中的全部job_id(不能重复)
SELECT DISTINCT job_id FROM employees;

#显示出表employees的全部列，各个列之间用逗号连接，列头显示成output

SELECT 
	IFNULL(commission_pct, 0) AS 奖金率,
	commission_pct
FROM employees;

SELECT 
	CONCAT(`first_name`,',',`last_name`,',',`job_id`,',',IFNULL(commission_pct, 0)) AS output
FROM 
	employees;