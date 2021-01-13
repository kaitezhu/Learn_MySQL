#进阶9：联合查询

/*
union 联合：将多条查询语句的结果合并成一个结果

语法：
查询语句1
union
查询语句2
union...

应用场景：
要查询的结果来自于多个表，且多个表没有直接的连接关系，但查询的信息一致时

特点：
1.要求多条查询语句的列数是一致的
2.要求多条查询语句每一列的类型和顺序最好一致
3.union关键字默认去重，如果使用union all可以包含重复项（取并集！）
*/

#引入的案例：查询部门编号>90或邮箱包含a的员工信息

SELECT * FROM employees WHERE email LIKE '%a%' OR department_id > 90;

#Union
SELECT * FROM employees WHERE email LIKE '%a%'
UNION ALL
SELECT * FROM employees WHERE department_id > 90;

#案例：查询中国用户中男性的信息以及外国用户中年龄>12的用户信息

SELECT id, cname, csex FROM t_ca WHERE csex='男'
UNION
SELECT t_id, tName, tGender FROM t_ua WHERE tGender='male';