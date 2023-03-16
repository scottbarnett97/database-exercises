select database();

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name 
--   for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied 
--    for user ...", it means that the query was attempting to write a new table to a database that you can only read.
use pagel_2190;
use employees;
CREATE TEMPORARY TABLE pagel_2190.employees_with_departments as
SELECT emp_no, first_name, last_name, dept_name, to_date
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
where to_date > curdate();

select * from employees_with_departments;

-- a) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

-- b) Update the table so that the full_name column contains the correct data.
-- a simple example where we want the email address to be just the first name
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

select database();




-- c) Remove the first_name and last_name columns from the table.
-- d) What is another way you could have ended up with this same table?




-- 2. Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
--    For example, 1.99 should become 199.

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?