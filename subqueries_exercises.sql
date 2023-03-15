use employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

select concat(first_name," ", last_name) "Employee Name"
from employees
where hire_date = 
	(select hire_date
      from employees
      join dept_emp using (emp_no)
      where emp_no = 101010
      and dept_emp.to_date > curdate());

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
select title
from  titles
where title IN (
     select title
     from employees as e
     join titles using (emp_no)
     join dept_emp as de using (emp_no)
     where  e.first_name = "Aamod"
     and de.to_date >now()
     )
     group by title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select count(e.emp_no)
from employees e
where emp_no not IN (
	select emp_no
	from dept_emp
	where to_date > curdate());
    
    -- 59900 people that no longer work for the company are on the employee table

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
select Concat(first_name," ", last_name) as "manager name"
from employees 
where emp_no in(
	select e.emp_no
	from employees as e
	join dept_manager as dm on e.emp_no = dm.emp_no
	join departments as d on d.dept_no = dm.dept_no
	where dm.to_date = '9999-01-01'and gender = 'F'
	);
 
    
/*'Isamu Legleitner'
'Karsten Sigstam'
'Leon DasSarma'
'Hilary Kambil'
*/


-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.


select concat(first_name," ",last_name)as Full_name
from employees 
where emp_no in 
(select emp_no
	from dept_emp
	where to_date ="9999-01-01")
   and emp_no in 
    (select emp_no
	from salaries s
	join employees e using (emp_no)
	where s.salary > 
    ( select avg(salary) from salaries));

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate
-- the standard deviation.) What percentage of all salaries is this?
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

select count(emp_no)
from salaries
where salary > (select max(salary)-(round(std(salary),2)) from salaries where to_date >curdate())
and to_date >curdate();
-- 83

select concat(
(select count(emp_no)
from salaries
where salary > (select max(salary)-(round(std(salary),2)) from salaries where to_date >curdate())
and to_date >curdate())/(
select count(*)
from salaries where to_date >now())*100, '%');
-- 0.0003%

-- BONUS

-- Find all the department names that currently have female managers.
select dept_name
from departments 
where dept_no in
	(select dept_no
    from dept_emp
    where emp_no in(
	select e.emp_no
	from employees as e
	join dept_manager as dm on e.emp_no = dm.emp_no
	join departments as d on d.dept_no = dm.dept_no
	where dm.to_date = '9999-01-01'and gender = 'F'
	order by dept_name asc));
/*'Finance'
'Human Resources'
'Development'
'Research'
*/

-- Find the first and last name of the employee with the highest salary.
select first_name, last_name
from employees
where emp_no in 
	(select emp_no
    from salaries
    where salary in (
    select max(salary)
    from salaries));
    -- Tokuyasu Pesch
    
-- Find the department name that the employee with the highest salary works in.

select dept_name
from departments
where dept_no in
(
select dept_no 
from dept_emp
where emp_no in 
	(select emp_no
    from salaries
    where salary in (
    select max(salary)
    from salaries))
    );
-- Sales

-- Who is the highest paid employee within each department.*/
