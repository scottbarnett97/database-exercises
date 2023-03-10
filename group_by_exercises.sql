use albums_db;
select database();

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
select distinct name
from albums;
-- 31 UNIQUE TITLES

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' 
-- using GROUP BY
use employees;
select database();
select last_name
from employees
group by last_name
having last_name like 'e%e';

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last 
-- names start and end with 'E'.
select last_name, first_name
from employees
group by last_name, first_name
having last_name like 'e%e';

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.

select last_name
from employees
group by last_name
having last_name not like '%qu%'
   and last_name like '%q%';
   /*
   'Chleq'
'Lindqvist'
'Qiwen'
*/
-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
select last_name, count(*)
from employees
group by last_name
having last_name not like '%qu%'
   and last_name like '%q%';

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find 
-- the number of employees for each gender with those names.

select first_name, gender, count(*)
from employees
group by first_name, gender
having first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';

-- 8. Using your query that generates a username for all of the employees, 
-- generate a count employees for each unique username.









