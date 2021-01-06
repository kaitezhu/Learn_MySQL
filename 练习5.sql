#1.显示员工表的最大工资，工资平均值
SELECT MAX(salary) max_sal, AVG(salary) avg_sal
FROM employees

#2.查询员工表的employee_id, job_id, last_name, 按department_id降序，salary升序
SELECT employee_id, job_id, last_name
FROM employees
ORDER BY department_id DESC, salary;

#3.查询员工表的job_id中包含a和e的，并且a在e的前面
SELECT job_id
FROM employees
WHERE job_id LIKE '%a%e%';


#4.已知表student里面有id, name, gradeId
#   已知表grade里面有id, name
#   已知表result里面有id, score, studentNo; 查询姓名，年纪名，成绩
SELECT s.name, g.name, r.score
FROM student s, grade g, result r
WHERE s.gradeId = g.id
AND r.studentNo = s.id;


#5.显示当前日期，以及去前后空格，截取子字符串的函数
SELECT NOW();
SELECT TRIM();
SELECT SUBSTR(); # index start from 1

