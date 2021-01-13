#函数
/*
含义：一组预先编译好的SQL语句的集合，理解成批处理语句
好处：
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率

区别:

存储过程：可以有0个返回，也可以有多个返回，适合做批量插入、批量更新
函数：有且只有一个返回，适合做数据处理后返回一个结果
*/

#一、创建语法
CREATE FUNCTION 函数名(参数列表) RETURNS 返回类型
BEGIN
	函数体
END

/*
注意：
参数列表 包含两部分：
参数名和参数类型

函数体：肯定会有return语句，如果没有会报错
如果return语句没有放在函数体的最后也不会报错，但不建议

return值：
函数体中仅有一句话，则可以省略begin end
使用delimiter语句作为设置结束标记

delimiter $
*/

#二、调用语法
SELECT 函数名(参数列表)

#-----------------案例演示-------------------
#1.无参返回
#案例：返回公司的员工个数
CREATE FUNCTION myf1() RETURNS INT
BEGIN
	DECLARE c INT DEFAULT 0;#变量声明
	SELECT COUNT(*) INTO c#赋值
	FROM employees;
	RETURN c;
END $

SELECT myf1()$


#2.有参返回
#案例1：根据员工名返回工资
CREATE FUNCTION myf2(empName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	SET @sal=0;#用户变量
	SELECT salary INTO @sal
	FROM employees
	WHERE last_name=empName;
	RETURN @sal;
END $

SELECT myf2('Kochhar')$

#案例2：根据部门名返回该部门的平均工资
DROP FUNCTION myf3$
CREATE FUNCTION myf3(deptName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE;
	SELECT AVG(salary) avg_sal INTO sal
	FROM employees e
	RIGHT OUTER JOIN departments d
	ON d.`department_id`=e.`department_id`
	WHERE d.`department_name`=deptName;
	
	RETURN sal;
END$

SELECT myf3('IT')$


#三、查看函数

DELIMITER;

SHOW CREATE FUNCTION myf3;

#四、删除函数

DROP FUNCTION myf3;

#案例
#1.创建函数，实现传入两个float，返回两者之和

CREATE FUNCTION test_func1(num1 FLOAT, num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE res FLOAT DEFAULT 0;
	SET res = num1 + num2;
	RETURN res;
END$

SELECT test_func1(1.0,2.0)$