show databases;
use employees;
select database ();
show tables;
-- 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?

select *
from employees
where first_name IN (	'Irena', 'Vidya', 'Maya')
;

-- 10200, 10397, 10610

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?

select *
from employees
where first_name = 'Irena'or first_name = 'Vidya' or first_name = 'Maya'
;

-- 10200, 10397, 10610

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.

select *
from employees
 where (first_name = 'Irena'or first_name = 'Vidya' or first_name = 'Maya')
	and gender = "M";
-- 10200, 10397, 10821

-- 4. Find all unique last names that start with 'E'.

select distinct last_name
from employees
where last_name like "e%";

-- 5. Find all unique last names that start or end with 'E'.

select distinct last_name
from employees
where last_name like "e%" 
or last_name like "%e";

-- 6. Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name not like "e%" 
or last_name like "%e";

-- 7. Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like "e%e";

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
select *
from employees
where hire_date like "199%";

-- 10008,10011,10012

-- 9. Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where birth_date like "%-12-25";
-- 10078,10115,10261

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where hire_date like "199%"
	and birth_date like "%-12-25";
-- 10261,10438,10681

-- 11. Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like "%q%";

-- 12. Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like "%q%"
    and last_name not like "%qu%";

