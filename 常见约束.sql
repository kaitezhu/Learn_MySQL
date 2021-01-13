#常见约束

CREATE TABLE 表名 (
	字段名 字段类型 约束
);

/*
含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确和可靠性

分类：六大约束
	-NOT NULL: 非空，用于保证该字段的值不能为空
		比如姓名、学号等
	-DEFAULT: 默认，用于保证该字段有默认值
		比如性别
	-PRIMARY KEY: 主键，用于保证该字段的值具有唯一性，并且非空
		比如学号、员工编号等
	-UNIQUE: 唯一，用于保证该字段的值具有唯一性，可以为空
		比如座位号
	-CHECK: 检查约束【mysql不支持】
		比如年龄、性别
	-FOREIGN KEY: 外键，用于限制两个表的关系，保证该字段的值必须来自于主表的关联列的值
		在【从表】添加外键约束，用于引用主表中某列的值
		比如学生表的专业编号，员工表的部门编号，员工表的工种编号
		
添加约束的时机：
1.创建表时
2.修改表时

约束的添加分类
	列级约束：
		六大约束语法上都支持，但外键没有效果
	表级约束：
		除了非空、默认都支持
		
主键和唯一的对比：
	保证唯一性	是否允许为空	一个表中可以有多少个	是否允许组合
主键	   可以		   不可以		至多一个	    可以，但不推荐
唯一	   可以		   可以			可以多个	    可以，但不推荐


外键：
	1.要求在从表设置外键关系
	2.从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3.主表的关联列必须是一个key（一般是主键或唯一）
	4.插入数据时，先插入主表，再插入从表
	删除数据时，先删除从表再删除主表
*/


#一、创建表时添加约束
#1.添加列级约束

/*
语法：

直接在字段名和类型后面追加约束类型即可
只支持：默认，非空，主键，唯一
*/

CREATE DATABASE IF NOT EXISTS students;
USE students;

CREATE TABLE stuinfo(
	id INT PRIMARY KEY,#主键
	stuName VARCHAR(20) NOT NULL,#非空
	gender CHAR(1) CHECK (gender='男' OR gender='女'),#检查
	seat INT UNIQUE,#唯一
	age INT DEFAULT 18,#默认约束
	majorId INT REFERENCES major(id)#外键
);

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

DESC stuinfo;
DESC major;

#查看stuinfo中所有的索引，包括主键，外键，唯一
SHOW INDEX FROM stuinfo;

#2.添加表级约束
/*
语法：在各个字段的最下面
【constraint 约束名】 约束类型（字段名）
*/
DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo (
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT,
	
	PRIMARY KEY(id),#主键
	UNIQUE(seat),#唯一键
	CHECK(gender='男' OR gender='女'),#检查
	FOREIGN KEY(majorId) REFERENCES major(id)#外键
);

SHOW INDEX FROM stuinfo;

#通用的写法:
CREATE TABLE IF NOT EXISTS stuinfo (
	id INT PRIMARY KEY,
	stuname VARCHAR(20) NOT NULL，
	sex CHAR(1),
	age INT DEFAULT 18,
	seat INT UNIQUE,
	majorid INT,
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorid) REFERENCES major(id)
	
);

#二、修改表时添加约束

/*
1.添加列级约束
alter table modify column type constraint

2.添加表级约束
alter table add [constraint name] constraint [references ]
*/

DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo (
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT
	
);

DESC stuinfo;
#1.添加非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NOT NULL;

#2.添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;

#3.添加主键
#列级约束
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;
#alt 表级约束
ALTER TABLE stuinfo ADD PRIMARY KEY(id);

#4.添加唯一

#列级约束
ALTER TABLE stuinfo MODIFY COLUMN seat INT UNIQUE;
#alt 表级约束
ALTER TABLE stuinfo ADD UNIQUE(seat);

#5.添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuifo_major FOREIGN KEY(majorId) REFERENCES major(id);

#三、修改表时删除约束

#1.删除非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NULL;

#2.删除默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT;

#3.删除主键
ALTER TABLE stuinfo DROP PRIMARY KEY;

#4.删除唯一键
ALTER TABLE stuinfo DROP INDEX seat;

SHOW INDEX FROM stuinfo;

#5.删除外键约束
ALTER TABLE stuinfo DROP FOREIGN KEY fk_stuinfo_major;