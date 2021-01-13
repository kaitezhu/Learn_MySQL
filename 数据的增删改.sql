#DML语言
/*
数据操作语言：
插入 insert
修改 update
删除 delete
*/

#一.插入语句
/*
语法：
insert into table(col_name,...) values(val,...);
*/

SELECT * FROM beauty;
#1.插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES (13, '唐艺昕', '女', '1990-4-23', '1898888888', NULL, 2);

#2.不可以为null的列必须插入值。可以为null的列如何插入值？
#方式1：
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES (13, '唐艺昕', '女', '1990-4-23', '1898888888', NULL, 2);

#方式2：
INSERT INTO beauty(id,NAME,sex,borndate,phone,boyfriend_id)
VALUES (15, '金星', '女', '1990-4-23', '1898888888333', 9);

#3.列的顺序是否可以调换
INSERT INTO beauty(NAME, sex, id, phone) VALUES ('蒋欣', '女', 16, '110');

#4.列数和值必须一致
INSERT INTO beauty(NAME, sex, id, phone, boyfriend_id) VALUES ('关晓彤', '女', 17, '110');

#5.可以省略列名，默认所有列，而且顺序和表中一致
INSERT INTO beauty VALUES (18, '张飞', '男', NULL, '119', NULL, NULL);

#方式二：
/*
语法：
insert into table
set 列名 = 值,....
*/

INSERT INTO beauty SET id=19, NAME='刘涛', phone='999';

SELECT * FROM beauty;

#两种方式比较
#1.方式一支持插入多行
INSERT INTO beauty
VALUES (23, '唐艺昕1', '女', '1990-4-23', '1898888888', NULL, 2),
(24, '唐艺昕2', '女', '1990-4-23', '1898888888', NULL, 2),
(25, '唐艺昕3', '女', '1990-4-23', '1898888888', NULL, 2);

#2.方式一支持子查询，方式二不支持
INSERT INTO beauty(id, NAME, phone)
SELECT 26, '宋茜','11809677';

INSERT INTO beauty(id, NAME, phone)
SELECT id, boyname,'1233333'
FROM boys WHERE id<3


#二、修改语句

/*
1.修改单表的记录（***）

语法：
update table
set col=newVal, col=newVal,...
where conditions;

2.修改多表的记录【补充】

语法：

update 表1 别名，表2 别名
set 列=值,...
where 连接条件
and 筛选条件；

sql99语法：
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值,...
where 筛选条件；

*/

#1.修改单表的记录
#案例1：修改beauty中姓唐的女生的电话为1389988899

UPDATE beauty SET phone='13899988899'
WHERE NAME LIKE '唐%';

#案例2：修改boys中id为2的名称为张飞，魅力值10
UPDATE boys SET boyName='张飞', userCP=10
WHERE id=2;

SELECT * FROM boys;

#修改多表的记录

#案例1：修改张无忌的女朋友手机号为114

UPDATE boys bo
INNER JOIN beauty b ON bo.`id` = b.`boyfriend_id`
SET b.`phone` = 114
WHERE bo.`boyName`='张无忌';

#案例2：修改没有男朋友的女神的男朋友编号为2号

UPDATE boys bo
RIGHT JOIN beauty b ON bo.`id` = b.`boyfriend_id`
SET b.`boyfriend_id`=2
WHERE bo.`id` IS NULL;

SELECT * FROM boys;


#三、删除语句
/*
方式一：delete

语法：
1.单表的删除（***）
delete from 表名 where 筛选条件

2.多表的删除【补充】
SQL92语法：
delete 别名
from 表1 别名, 表2 别名
where 链接条件
and 筛选条件;

SQL99语法：
delete 表1 别名， 表2 别名
from 表1 别名
inner|left|right join 表2 别名
on 连接条件
where 筛选条件；

方式二：truncate

语法：
truncate table;

*/

#方式一：delete
#1.单表的删除
#案例1：删除手机号以9结尾的女神信息

DELETE FROM beauty WHERE phone LIKE '%4';
SELECT * FROM beauty;

#2.多表的删除

#案例：删除张无忌的女朋友的信息

DELETE b
FROM beauty b
JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName`='张无忌';

#案例：删除黄晓明的信息以及它女朋友的信息

DELETE b, bo
FROM beauty b
INNER JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName`='黄晓明';


#方式二：truncate语句

#案例：将魅力值>100的男神信息删除
TRUNCATE TABLE boys;


#delete vs truncate（面试题***）
/*
1.delete可以加where条件，truncate不能加
2.truncate删除效率高
3.假如要删除的表中有自增长列，
如果用delete删除后，再插入数据，自增长列的值从断电开始，
而truncate删除后，再插入数据，自增长列的值从1开始。
4.truncate删除没有返回值，delete删除有返回值
5.truncate删除不能回滚，delete删除可以回滚
*/