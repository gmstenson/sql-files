-- W10 Assignment: Summary Queries --
-- Author: Gizelle Manilay -- 

--
-- Questions 1-3 using the bike database 

USE bike;

-- Question #1 query 

SELECT ROUND(AVG(quantity)) AS 'Stock Average'
FROM stock;

-- Question #2 query 

SELECT DISTINCT product_name
FROM product p 
	JOIN stock sk
		ON p.product_id = sk.product_id
	JOIN store se
		ON sk.store_id = se.store_id
WHERE quantity = 0
ORDER BY product_name;

-- Question #3 query 

SELECT category_name, COUNT(category_name) AS instock
FROM category c
	JOIN product p
		ON c.category_id = p.category_id
	JOIN stock sk
		ON p.product_id = sk.product_id
	JOIN store se
		ON sk.store_id = se.store_id
WHERE se.store_id = 2
GROUP BY category_name
ORDER BY instock;

--
-- Questions 4-6 using the employees database 

USE employees;

-- Question #4 query 

SELECT COUNT(*) AS 'Number of Employees'
FROM employees;

-- Question #5 query 

SELECT dept_name, FORMAT(AVG(salary), 2, 'en-US') AS average_salary
FROM departments
	JOIN dept_emp
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		ON dept_emp.emp_no = salaries.emp_no
GROUP BY dept_name
HAVING AVG(salary) < 60000;

-- Question #6 query 

SELECT dept_name, COUNT(gender) AS 'Number of Females'
FROM departments
	JOIN dept_emp
		ON departments.dept_no = dept_emp.dept_no
	JOIN employees
		ON dept_emp.emp_no = employees.emp_no
WHERE gender = 'F'
GROUP BY dept_name
ORDER BY dept_name;




