select database();

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name 
--   for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied 
--    for user ...", it means that the query was attempting to write a new table to a database that you can only read.
use pagel_2190;
use employees;
CREATE TEMPORARY TABLE pagel_2190.employees_with_departments as
SELECT first_name, last_name, dept_name, to_date
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

-- c) Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- d) What is another way you could have ended up with this same table?
-- could have created it this way initially

-- 2. Create a temporary table based on the payment table from the sakila database.

use sakila;
CREATE TEMPORARY TABLE pagel_2190.temp_payments as
select*
from payment;
use pagel_2190;
select * from temp_payments;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
--    For example, 1.99 should become 199.
alter table temp_payments modify amount decimal(10,2);
update temp_payments
set amount = amount*100;
alter table temp_payments modify amount int;
select * from temp_payments;

describe temp_payments;


-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company.
--  For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for?
--  The worst?
use employees;
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
    SELECT salary,
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries
    WHERE to_date > now();
create temporary table pagel_2190.current_info as
(    
select dept_name, Round(avg(salary)) as average_salary
	from employees as e
	join salaries as s on s.emp_no = e.emp_no
	join dept_emp as de on de.emp_no = e.emp_no
	join departments as d on d.dept_no = de.dept_no
	where de.to_date > curdate()
	and s.to_date > curdate()
	group by dept_name
	order by avg(salary) desc
    );
    select * from pagel_2190.current_info;
    


