#进阶2：条件查询
/*
语法：
	select 
		查询列表
	from
		表名
	where
		筛选条件;
		
分类：
	1.按条件表达式筛选
	简单条件运算符：> < = != <> >= <=
	
	2.按逻辑表达式筛选
	逻辑运算符：
		&& || !
		and or not
	3.模糊查询
		like
		between and
		in
		is null
*/

#1.按条件表达式筛选
#案例1：查询工资>12000的员工信息

SELECT 
	*
FROM
	employees
WHERE
	salary>12000;
	
#案例2：查询部门编号不等于90号的员工名和部门编号
SELECT 
	CONCAT(first_name, ' ' ,last_name), department_id
FROM
	employees
WHERE
	department_id != 90;
	
#2.按逻辑表达式筛选
#案例1：查询工资在10000到20000之间的员工名、工资以及奖金
SELECT
	last_name,
	salary,
	commission_pct
FROM
	employees
WHERE
	salary >= 10000 AND salary <= 20000
	

#案例2:查询部门编号不是在90到110之间，或者工资高于15000的员工信息
SELECT
	*
FROM
	employees
WHERE
	department_id < 90 OR department_id > 110 OR salary > 15000;
	
#3.模糊查询
/*
like
between and
in
is null | is not null
*/

#1.like

#案例1：查询员工名中包含字符a的员工信息

SELECT
	*
FROM
	employees
WHERE
	last_name LIKE '%a%' OR first_name LIKE '%a%'
	
#案例2：查询员工名中第三个字符为e，第5个字符为a的员工名和工资
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	last_name LIKE '__n_l%';
	
#案例3：查询员工名中第二个字符为_的员工名

SELECT
	last_name,
	first_name
FROM
	employees
WHERE
	last_name LIKE '_$_%' ESCAPE '$';
	
#2.between and

/*
1. between and 可以提高语句简洁度
2. 包含临界值
3. 两个临界值不要调换顺序
*/

#案列1：查询员工编号在100到120之间的员工信息

SELECT
	*
FROM
	employees
WHERE
employee_id BETWEEN 100 AND 120;

#3. in

/*
1.使用in提高简洁度
2.in列表的值类型必须一致或兼容
*/

#案例：查询员工的工种编号是IT_PROG,AD_VP,AD_PRES中的一个

SELECT
	*
FROM
	employees
WHERE job_id IN ('IT_PROG', 'AD_VP', 'AD_PRES');


#4. is null

#案例1：查询没有奖金的员工名和奖金率
SELECT
	CONCAT(last_name, ' ', first_name), commission_pct
FROM
	employees
WHERE
	commission_pct IS NULL;

#案例2：查询有奖金的员工名和奖金率
SELECT
	employee_id
FROM
	employees
WHERE
	commission_pct IS NOT NULL;
	
#安全等于 <=>

#案例1：查询没有奖金的员工名和奖金率
SELECT
	CONCAT(last_name, ' ', first_name), commission_pct
FROM
	employees
WHERE
	commission_pct <=> NULL;
	
#案例2：查询工资为12000的员工信息
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	salary <=> 12000;
	
# is null vs <=>
# IS NULL: 仅仅可以判断NULL值，可读性较高，建议使用
# <=>: 既可以判断null值，又可以判断普通的数值，可读性较低

#查询员工号为176的员工的姓名和部门号和年薪
SELECT
	last_name,
	department_id,
	salary * 12 * (1+ IFNULL(commission_pct, 0)) AS annual_salary
FROM
	employees
WHERE
	employee_id = 176;
