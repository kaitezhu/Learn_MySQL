#标识列
/*
又称为自增长列
含义：可以不用手动插入值，系统提供默认序列值

特点：
1.标识列必须和主键搭配？
  -不一定，但要求是一个key
2.一个表最多一个
3.类型只能时数值型
4.可以通过SET auto_increment_increment=1;设置步长，起始值
*/

#一、创建表时设置标识列
DROP TABLE IF EXISTS tab_identity;
TRUNCATE TABLE tab_identity;
CREATE TABLE tab_identity(
	id INT,
	NAME VARCHAR(20),
	seat INT
);

INSERT INTO tab_identity VALUES (NULL, 'john');

SELECT * FROM tab_identity;

SHOW VARIABLES LIKE '%auto_increment%';
SET auto_increment_increment=1;


#二、修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
DESC tab_identity;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;