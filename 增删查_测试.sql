#1. 运行以下脚本创建表 my_employees
ues myemployees;
CREATE TABLE my_employees(
	Id INT(10),
	First_name VARCHAR(10),
	Last_name VARCHAR(10),
	Userid VARCHAR(10),
	Salary DOUBLE(10,2)
);

CREATE TABLE users(
	id INT,
	userid VARCHAR(10),
	department_id INT
);

#2. 显示表 my_employees 的结构

DESC my_employees;

#3. 向 my_employees 表中插入下列数据
SELECT * FROM my_employees;
INSERT INTO my_employees VALUES (1, 'Patel', 'Ralph', 'Rpatel', 895),
(2, 'Dancs', 'Betty', 'Bdancs', 860),
(3, 'Biri', 'Ben', 'Bbiri', 1100),
(4, 'Newman', 'Chad', 'Cnewman', 750),
(5, 'Ropeburn', 'Audrey', 'Aropebur', 1550);

#alt ans
INSERT INTO my_employees
SELECT 1, 'Patel', 'Ralph', 'Rpatel', 895 UNION
SELECT 2, 'Dancs', 'Betty', 'Bdancs', 860
SELECT 3, 'Biri', 'Ben', 'Bbiri', 1100
SELECT 4, 'Newman', 'Chad', 'Cnewman', 750
SELECT 5, 'Ropeburn', 'Audrey', 'Aropebur', 1550;

#4. 向 users 表中插入数据
SELECT * FROM users;

INSERT INTO users VALUES (1, 'Rpatel', 10),
(2, 'Bdancs', 10),
(3, 'Bbiri', 20),
(4, 'Cnewman', 30),
(5, 'Aropebur', 40);


#5. 将 3 号员工的 last_name 修改为“drelxer”
UPDATE my_employees
SET last_name='drelxer'
WHERE id=3;

#6. 将所有工资少于 900 的员工的工资修改为 1000
UPDATE my_employees
SET Salary=1000
WHERE Salary < 900;

SELECT * FROM my_employees;

#7. 将 userid 为 Bbiri 的 user 表和 my_employees 表的记录全部删除
DELETE u,e
FROM users u
JOIN my_employees e
ON e.`Userid` = u.`userid`
WHERE u.`userid`='Bbiri';

#8. 删除所有数据
DELETE FROM my_employees;
DELETE FROM users;

#9. 检查所作的修正
SELECT * FROM my_employees;
SELECT * FROM users;

#10. 清空表 my_employees
TRUNCATE TABLE my_employees;
