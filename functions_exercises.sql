show databases;
use employees;
select database ();
show tables;
-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name.
	--  In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name
	-- of the last person in the table?
select *
from employees
 where first_name = 'Irena'or first_name = 'Vidya' or first_name = 'Maya'
    order by first_name;
    -- Irena Reutenauer, Vidya Simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then 
	-- last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first 
    -- and last name of the last person in the table?
select *
from employees
 where first_name = 'Irena'or first_name = 'Vidya' or first_name = 'Maya'
    order by first_name, last_name;
    -- Irena Acton, Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then 
	-- first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first 
	-- and last name of the last person in the table?
select *
from employees
 where first_name = 'Irena'or first_name = 'Vidya' or first_name = 'Maya'
    order by last_name, first_name;   
    -- Irena Acton, Maya Zyda

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
    -- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last
	-- employee number with their first and last name.
select *
from employees
 where last_name like "e%" and last_name like "%e"
    order by emp_no;
select count(*)
from employees
 where last_name like "e%" and last_name like "%e"
    order by emp_no;    
    
    -- count 899, 10021 Ramzi Erde, 499648 Tadahiro Erde
    
-- 6.  Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date,
	-- so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest
    -- employee, and the name of the oldest employee.
select *
from employees
 where last_name like "e%" and last_name like "%e"
    order by hire_date DESC; 
select count(*)
from employees
 where last_name like "e%" and last_name like "%e"
    order by hire_date DESC; 
    -- 899 count, newest employee Teiji Eldridge, oldest employee Sergi Erde
    
-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last 
	-- is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last,
	-- and the name of the youngest employee who was hired first.
select *
from employees
where hire_date like "199%"
	and birth_date like "%-12-25"
    order by birth_date ASC, hire_date DESC;
    select count(*)
from employees
where hire_date like "199%"
	and birth_date like "%-12-25"
    order by birth_date ASC, hire_date DESC;
    
    -- count 362, Khun Bernini, Douadi Pettis
-- 1.     
use employees;
show tables;

-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.

select concat(first_name, " ", last_name) as full_name
from employees
where (last_name like "e%" and last_name like "%e");

-- 3. Convert the names produced in your last query to all uppercase.

select UPPER(concat(first_name, " ", last_name)) as full_name
from employees
where (last_name like "e%" and last_name like "%e");

-- 4. Use a function to determine how many results were returned from your previous query.

select COUNT(UPPER(concat(first_name, " ", last_name))) as full_name
from employees
where (last_name like "e%" and last_name like "%e");

-- 5. Find all employees hired in the 90s and born on Christmas.
--  Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),

SELECT datediff(curdate(),hire_date) as days_worked
, birth_date, first_name, last_name, hire_date
from employees 
where hire_date like "199%"
  and birth_date like "%-12-25";
  
-- 6. Find the smallest and largest current salary from the salaries table.
use employees;
select min(salary), max(salary)
from salaries;

-- 7. Use your knowledge of built in SQL functions to generate a username for all of the employees.
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born,
-- and the last two digits of the year that they were born. Below is an example of what the first 
-- 10 rows will look like:
select concat(
lower(substr(first_name,1,1))
 , lower(substr(last_name,1,4))
 , "_"
 , month(birth_date)
 , substr(year(birth_date),-2)) as username
 , first_name, last_name, birth_date
from employees;

-------------------------
use employees;

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together 
-- as a single column named full_name.

select CONCAT(first_name, ' ' ,last_name) as full_name
from employees
where last_name like 'e%e'
;

-- Convert the names produced in your last query to all uppercase.

select UPPER( CONCAT(first_name, ' ' ,last_name))  as full_name
from employees
where last_name like 'e%e'
;


-- Use a function to determine how many results were returned from your previous query.

select count(*) -- , count(first_name), count(UPPER( CONCAT(first_name, ' ' ,last_name)))
from employees
where last_name like 'e%e'
;

-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),

select *, datediff(curdate(), hire_date) as tenure_days
from employees
where hire_date like '199%'
	and birth_date like '%-12-25'
;


-- Find the smallest and largest current salary from the salaries table.

select *
from salaries
where emp_no = '10001' -- see that each employee can have multiple salaries
;

select *
from salaries
where to_date = '9999-01-01' -- way 1 of finding current salaries
;

select *
from salaries
where to_date > now() -- way 2 of finding current salaries
;

select MIN(salary), MAX(salary)
from salaries
where to_date > now()
;

-- Use your knowledge of built in SQL functions to generate a username 
-- for all of the employees. A username should be all lowercase, 
-- and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, 
-- and the last two digits of the year that they were born. 

select
	lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username
    ,date_format(birth_date, '_%m%y') as another_date_retrevial
from employees
;

