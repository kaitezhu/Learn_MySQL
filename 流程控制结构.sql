#流程控制结构
/*
顺序结构：程序从上往下依次执行
分支结构：程序从两条或多条路径中选择一条去执行
循环结构：程序在满足一定条件的基础上，重复执行一段代码


*/

#一、分支结构
#1.if函数
/*
功能：实现简单的双分支
语法
select if(表达式1,表达式2，表达式3)
执行顺序：
如果表达式1成立，则返回2的值，否则返回3的值

应用：任何地方
*/

#2.case结构
情况1：类似于java中的switch语句，一般用于实现等值判断
语法：
	CASE 变量|表达式|字段
	WHEN 要判断的值 THEN 返回的值1或语句1
	WHEN 要判断的值 THEN 返回的值2或语句2
	...
	ELSE 要返回的值n或语句n;
	END CASE;
	
情况2：类似于java中的多重IF语句，一般用于实现区间判断
语法：
	CASE 变量|表达式|字段
	WHEN 要判断的条件1 THEN 返回的值1或语句1
	WHEN 要判断的条件2 THEN 返回的值2或语句2
	...
	ELSE 要返回的值n或语句n;
	END CASE;
	
特点：
（1）
可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，BEGIN END中或者外面
可以作为独立的语句去使用，只能放在BEGIN END中

（2）
如果WHEN中的值满足或条件成立，则执行对应的THEN后面的语句，并且结束CASE
如果都不满足，则执行ELSE中的语句或值

（3）
ELSE可以省略，如果ELSE省略了，并且所有WHEN条件都不满足，则返回NULL

#案例：

#创建存储过程，根据传入的成绩来显示等级，90-100 A，80-90 B，60-80 C，否则D
CREATE PROCEDURE test_case(IN score INT)
BEGIN
	CASE
	WHEN score >= 90 AND score <= 100 THEN SELECT 'A';
	WHEN score >= 80 THEN SELECT 'B';
	WHEN score >= 60 THEN SELECT 'C';
	ELSE SELECT 'D';
	END CASE;
END $

CALL test_case(96)$


#3.if结构
/*
功能：实现多重分支

语法：
if 条件1 then 语句1；
elseif 条件2 then 语句2；
...
【else 语句n；】
end if；

应用在begin end 中

*/

#案例1：根据传入的成绩来显示等级，90-100 A，80-90 B，60-80 C，否则D
CREATE FUNCTION test_if(score INT) RETURNS CHAR
BEGIN
	IF score >= 90 AND score <= 100 THEN RETURN 'A';
	ELSEIF score >= 90 THEN RETURN 'B';
	ELSEIF score >= 60 THEN RETURN 'C';
	ELSE RETURN 'D';
	END IF;
END$


#二、循环结构
/*
分类：
while、loop、repeat

循环控制：

iterate类似于 continue
leave类似于break

*/

#1。while
/*
语法：

【标签】：while 循环条件 do
	循环体；
end while 【标签】；
*/

#2.loop
/*
语法：
【标签：】loop
	循环体；
end loop 【标签】；

可以用来模拟简单的死循环
*/

#3.repeat
/*
语法：
【标签：】repeat
	循环体；
until 结束循环的条件
end repeat【标签】；

*/