show databases;
use employees;
select database ();
show tables;
-- 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
/*
select *
from employees
where first_name IN (	'Irena', 'Vidya', 'Maya')
;
*/
-- 499750, 499588, 497788

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
/*
select *
from employees, dept_emp
where first_name = 'Irena'or 'Vidya' or 'Maya'
;
*/
-- 494902, 494802, 492914 they do not match because it is grouping the names

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.

select *
from employees, dept_emp
where first_name = 'Irena' or 'Vidya' or 'Maya'
	and gender = 'M'
;

