#储存过程和函数
/*
类似于java中的方法

好处：
1.提高代码的重用性
2.简化操作
*/

#存储过程
/*
含义：一组预先编译好的SQL语句的集合，理解成批处理语句
好处：
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率
*/

#一、创建语法

CREATE PROCEDURE 存储过程名(参数列表)
BEGIN
	存储过程体（SQL语句）
END

注意：
1.参数列表包含三部分
参数模式 参数名 参数类型
例如：IN stuname VARCHAR(20)

参数模式：
IN：该参数可以作为输入，需要调用方传入值
OUT：该参数可以作为输出，作为返回值
INOUT：该参数既可以作为输入又可以作为输出，既需要传入值又需要返回值


2.如果存储过程体只有一句话，BEGIN END 可以省略
  存储过程体中的每条SQL语句的结尾要求必须加分号
  存储过程的结尾可以使用DELIMITER重新设置
  
  语法：
DELIMITER 结束标识
#案例
DELIMITER $  

#二、调用语法

CALL 存储过程名(实参列表);

#1.空参列表
#案例：插入到admin表中的五条记录
SELECT * FROM admin;

DELIMITER $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username, `password`) VALUES('john1','0000'),
	('lizy','0000'),('rose','0000'),('jack','0000'),('tom','0000');
END$

#调用
CALL myp1()$

#2.创建带in模式参数的存储过程

#案例1：创建存储过程实现 根据女神名，查询对应的男神信息

CREATE PROCEDURE myp2(IN beautyName VARCHAR(20))
BEGIN
	SELECT bo.*
	FROM boys bo
	RIGHT JOIN beauty b ON bo.id=b.boyfriend_id
	WHERE b.name=beautyName;
END $

#调用
CALL myp2('小昭')$

#案例2：创建存储过程实现，用户是否登录成功

CREATE PROCEDURE myp4(IN username VARCHAR(20), IN PASSWORD VARCHAR(20))
BEGIN
	DECLARE result INT DEFAULT 0;#声明并初始化
	
	SELECT COUNT(*) INTO result#赋值
	FROM admin
	WHERE admin.username=username
	AND admin.password=`password`;
	
	SELECT IF(result > 0, '成功','失败');#使用
END $

#调用
CALL myp4('张飞','8888')$

#3.创建带out模式的存储过程

#案例1：根据女神名，返回对应的男神名

CREATE PROCEDURE myp5(IN beautyName VARCHAR(20), OUT boyName VARCHAR(20))
BEGIN
	SELECT bo.boyName INTO boyName
	FROM boys bo
	INNER JOIN beauty b ON b.boyfriend_id=bo.id
	WHERE b.name=beautyName;
END $

#调用
SET @bName$
CALL myp5('小昭',@bName)$
SELECT @bName$

#案例2：根据女神名，返回对应的男生名和魅力值

CREATE PROCEDURE myp6(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20),OUT userCP INT)
BEGIN
	SELECT bo.boyName, bo.userCP INTO boyName, userCP
	FROM boys bo
	INNER JOIN beauty b ON b.boyfriend_id=bo.id
	WHERE b.name=beautyName;
END $

#调用
CALL myp6('小昭',@bName,@usercp)$


#4.创建带inout模式参数的存储过程
#案例1：传入a和b两个值，最终a和b都翻倍并返回

CREATE PROCEDURE myp8(INOUT a INT, INOUT b INT)
BEGIN
	SET a=a*2;
	SET b=b*2;
END $

#调用
SET @m=10$
SET @n=20$
CALL myp8(@m,@n)$
SELECT @m,@n$