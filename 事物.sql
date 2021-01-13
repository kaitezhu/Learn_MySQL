#TCL
/*
Transaction control language 事物控制语言

事物：
一个或一组SQL语句组成的执行单元，这个执行单元要么全部执行要不全部不执行

案例：转账


事物的特性：
acid
原子性：一个事物不可再分割，要么都执行要么都不执行
一致性：一个事物执行会使数据从一个一致状态切换到另一个一致状态
隔离性：一个事物的执行不受其他事物干扰
持久性：一个事务一旦提交，则会永久地改变数据库的数据

事物的创建
隐式事物：事物没有明显的开启和结束标记
	比如insert,update,delete语句

显式事物：事物具有明显的开启和结束标记
前提：必须先设置自动提交功能为禁用

set autocommit=0;

步骤1：开启事物
set autocommit=0;
start transaction;(可不写)

步骤2：编写事物的SQL语句（SELECT, INSERT, UPDATE, DELETE）
语句1；
语句2；
...

步骤3：结束事物
commit; 提交事物
rollback; 回滚事物

savepoint 节点名：设置保存点

事物的隔离级别：
			脏读	不可重复读	幻读	
read uncommited： 	 可	   可	  	 可
read committed:		不可	   可	  	 可
repeatable read:	不可	   不可		 可
serializable		不可	   不可		 不可

mysql中默认 repeatable read
oracle中默认 read committed

查看隔离级别：
select @@tx_isolation;

设置隔离级别：
set session|global transaction isolation level 隔离级别；
*/

SHOW ENGINES;

SHOW VARIABLES LIKE 'autocommit';

#演示事物的使用步骤

#开启事物
SET autocommit=0;
START TRANSACTION;
#编写事物语句
update...
#结束事物
#rollback;
COMMIT;

#2.delete和truncate在事物使用时的区别

SELECT * FROM account;

#演示delete
SET autocommit=0;
START TRANSACTION;
DELETE FROM account;
ROLLBACK;

#演示truncate
SET autocommit=0;
START TRANSACTION;
TRUNCATE TABLE account;
ROLLBACK;


#3.演示savepoint的使用
SELECT * FROM dept2;

SET autocommit=0;
START TRANSACTION;
DELETE FROM dept2 WHERE department_id=10;
SAVEPOINT a;
DELETE FROM dept2 WHERE department_id=30;

ROLLBACK TO a;

