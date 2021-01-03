#进阶4：常见函数

#调用：select func() [from table]

#一。字符函数，获取参数值的字节个数
#length
SELECT LENGTH('john');

SHOW VARIABLES LIKE '%char%';

#2.concat拼接字符串
SELECT CONCAT(last_name, '_', first_name) AS emp_name FROM employees;

#3.upper, lower
SELECT UPPER('john');

#demo：将姓便大写，名变小写，然后拼接
SELECT CONCAT(UPPER(first_name), LOWER(last_name)) AS empl_name FROM employees;

#4.substr, substring
SELECT SUBSTR('李莫愁爱上了草泥马', 7) out_put;
SELECT SUBSTR('李莫愁爱上了草泥马', 1, 3) out_put;

#案例：姓名中首字符大写，其他字符小写然后用——拼接
SELECT CONCAT(UPPER(SUBSTR(last_name, 1, 1)), '_', LOWER(SUBSTR(last_name, 2))) AS out_put FROM employees;

#5.instr 返回子串第一次出现的索引，如果找不到返回0
SELECT INSTR('chicken', 'chi') AS out_put;

#6.trim
SELECT LENGTH(TRIM('this is        '));

SELECT TRIM('a' FROM 'aaaaaaaaaaaaaaaaaaaabbbbbbbaaaa');

#7.lpad 左填充指定长度
SELECT LPAD('zhukaite', 10, '*');

#8.rpad 右填充指定长度
SELECT RPAD('zhukaite', 10, '*');

#9。replace替换
SELECT REPLACE('abbbbbbbbbbb', 'ab', 'xx');

#二。数学函数
#round
SELECT ROUND(1.65);
SELECT ROUND(1.872, 2);

#ceil
SELECT CEIL(1.52);

#floor
SELECT FLOOR(1.52);

#truncate
SELECT TRUNCATE(1.65, 1);

#mod
#mod(a,b): a-a/b*b
SELECT MOD(10, 3);

#三。日期函数
#now
SELECT NOW();

#curdate
SELECT CURDATE();

#curtime
SELECT CURTIME();

#可以获得指定的部分，年月日小时分钟秒
SELECT YEAR(NOW());
SELECT YEAR('1998-1-1');

SELECT YEAR(hiredate) FROM employees;

SELECT MONTH(NOW());

SELECT MONTHNAME(NOW());

#str_to_date
SELECT STR_TO_DATE('1998-3-2', '%Y-%c-%d') AS out_put;

#查询入职日期为1992-4-3的员工日期
SELECT * FROM employees WHERE hiredate = '1992-4-3';

SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992', '%c-%d %Y');

#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(), '%y年%m月%d日');

#查询有奖金的员工名和入职日期（xx月/xx日/xx年）
SELECT last_name, DATE_FORMAT(hiredate, '%m月/%d日 %y年') FROM employees WHERE commission_pct IS NOT NULL;

#四。其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#五。流程控制函数
#1.if
SELECT IF(10 > 5, '大', '小');

SELECT last_name, commission_pct, IF(commission_pct IS NULL, 'empty', 'valid commission') FROM employees;

#2.case
/*案例：查询员工的工资

部门号=30， 工资为1.1倍
部门号=40， 工资为1.2倍
部门号=50， 工资为1.3倍
其他部门， 工资不变
*/
SELECT salary AS og_sal, department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS new_sal
FROM employees;

#case, use 2
#案例：查询员工的工资
/*
如果工资>20000, A
如果工资>15000, B
如果工资>10000, C
else， D
*/
SELECT salary,
CASE
WHEN salary > 20000 THEN 'A'
WHEN salary > 15000 THEN 'B'
WHEN salary > 10000 THEN 'C'
ELSE 'D'
END AS new_lvl
FROM employees;