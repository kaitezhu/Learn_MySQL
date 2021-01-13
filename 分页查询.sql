#进阶8：分页查询（***）
/*
应用场景：当要显示的数据一页显示不全，需要分页提交sql请求
语法：
	select
	from table
	【join type】 join table 2
	on
	where
	group by
	having
	order by
	limit offset, size;
	
	offset - 要显示的条目的起始索引（起始索引从0开始）
	size - 要显示的条目歌实
特点：
	1.limit语句放在查询语句的最后
	2.公式
	要显示的页数 page， 每页的条目数size
	
	select 
	from 
	limit (page - 1) * size,size;
*/

#案例1：

SELECT * FROM employees LIMIT 0, 5;
#或
SELECT * FROM employees LIMIT 5;

#案例2：查询第11条-第25条
SELECT * FROM employees LIMIT 10, 15;

#案例3：有奖金的员工信息，并且工资较高的前十名显示出来
SELECT * FROM employees WHERE commission_pct IS NOT NULL ORDER BY salary DESC LIMIT 10;

