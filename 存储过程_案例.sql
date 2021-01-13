#1.创建存储过程实现传入用户名和密码，插入到admin表中

CREATE PROCEDURE test_pro1(IN username VARCHAR(20), IN pwd VARCHAR(20))
BEGIN
	INSERT INTO admin(admin.username, PASSWORD) VALUES (username, pwd);
END $

#2.创建存储过程或函数实现传入女神编号，返回女神名称和女神电话

CREATE PROCEDURE test_pro2(IN id INT, OUT bname VARCHAR(20), OUT phone VARCHAR(20))
BEGIN
	SELECT b.name, b.phone INTO bname, phone
	FROM beauty b
	WHERE b.id=id;
END$

#3.创建储存过程或函数实现传入两个女神生日，返回大小

CREATE PROCEDURE test_pro3(IN bd1 DATETIME,IN bd2 DATETIME,OUT res INT)
BEGIN
	SELECT DATEDIFF(bd1,bd2) INTO res;
END$

#4.创建存储过程或函数实现传入一个日期，格式化成xx年xx月xx日并返回

CREATE PROCEDURE test_pro4(IN mydate DATETIME, OUT strDate VARCHAR(50))
BEGIN
	SELECT DATE_FORMAT(mydate, '%y年%m月%d日') INTO strDate;
END$

CALL test_pro4(NOW(),@str)$
SELECT @str$

#5.创建存储过程或函数实现传入女神名称，返回：女神 and 男神 格式的字符串
DROP PROCEDURE test_pro5$
CREATE PROCEDURE test_pro5(IN bName VARCHAR(20),OUT str VARCHAR(50))
BEGIN
	SELECT CONCAT(bName, ' AND ', IFNULL(boyName, 'null')) INTO str
	FROM beauty b
	LEFT JOIN boys bo
	ON b.boyfriend_id=bo.id
	WHERE b.name=bName;
END$

CALL test_pro5('小昭',@str)$
SELECT @str$

#6.创建存储过程或函数，根据传入的条目数和起始索引，查询beauty表的记录
DROP PROCEDURE test_pro6$
CREATE PROCEDURE test_pro6(IN startIdx INT, IN size INT)
BEGIN
	SELECT * FROM beauty LIMIT startIdx,size;
END$

CALL test_pro6(3,5)$


#二、删除存储过程
#语法：drop procedure name

DROP PROCEDURE p1;

#三、查看存储过程的信息
SHOW CREATE PROCEDURE myp2;