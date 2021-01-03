#进阶1：基础查询
/*
语法
select 查询列表 from 表名;

特点：
1. 查询列表可以是：表中的字段、常量、表达式、函数
2. 查询的结果是一个虚拟的表格

*/

USE myemployees;

#1.查询表中的单个字段
#SELECT last_name FROM employees;

#2.查询表中的多个字段
#select last_name,salary,email from employees;

#3.查询表中的所有字段
SELECT * FROM employees;

#4.查询常量值
SELECT 100;
SELECT 'john';

#5.查询表达式
SELECT 100%98;

#6.查询函数
SELECT VERSION();

#7.起别名
/*
1.便于理解
2.如果要查询的字段有重名的情况，使用别名可以区分开来
*/

#方式一：使用as
SELECT 100%98 AS res;
SELECT last_name AS 姓, first_name AS 姓 FROM employees;

#方式二：使用空格
SELECT last_name 姓, first_name 名 FROM employees;

#案例：查询salary，显示结果为output
SELECT salary AS "out put" FROM employees;

#8.去重

#案列：查询员工表中涉及到的所有的部门编号
SELECT DISTINCT department_id FROM employees;

#9.+价的作用

#案例：查询员工名和姓连接成一个字段，并显示为 姓名

SELECT CONCAT('a','b','c') AS Result;

SELECT 
	last_name+first_name AS 姓名
FROM
	employees;
	