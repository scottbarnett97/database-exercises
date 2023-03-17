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

--
USE employees;
-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
-- all curr/past emps with 101010's hire date

/*select * 
from employees 
where hire_date = -- emp_no=101010 hire_date
(select hire_date from employees where emp_no =101010);
*/
-- all CURRENT emps with 101010's hire date
select * 
from employees e
JOIN salaries s on s.emp_no = e.emp_no
where hire_date = (select hire_date from employees where emp_no =101010)
	and s.to_date > curdate();


/*
 2. Find all the titles ever held by all **current employees with the first name Aamod.
 
 select * from employees where first_name = 'Aamod';
 select emp_no from employees where first_name = 'Aamod';
 select * from titles;
 select * from employees e
 join titles t on t.emp_no = e.emp_no;
*/

select t.title from employees e
join titles t on t.emp_no = e.emp_no
where t.emp_no IN (select emp_no from employees where first_name = 'Aamod')
	and t.to_date > curdate()
group by t.title;

/*
 3. How many people in the employees table are no longer working for the company? 
 Give the answer in a comment in your code.
select * from employees;
select * from titles;
-- list of prev employed emp_no's
select distinct(emp_no) from titles where to_date<curdate(); -- count: 188,132
*/

select count(*) AS PrevEmpCount -- 59,900
from employees e 
where emp_no NOT IN (select emp_no from dept_emp where to_date > curdate());


/*
4. Find all the current department managers that are female. 
List their names in a comment in your code.
select * from dept_manager;
select distinct gender from employees;
select * from dept_manager d
join employees e on e.emp_no = d.emp_no
where e.gender='F';
select * from employees e 
where e.emp_no in (	select e.emp_no from dept_manager d
					join employees e on e.emp_no = d.emp_no
					where e.gender='F');
 */

select concat(first_name, ' ', last_name) from employees e
where e.emp_no in (select d.emp_no from dept_manager d
					join employees e on e.emp_no = d.emp_no
					where d.to_date > curdate()
						and gender = 'F');
	
/*
'Isamu Legleitner'
'Karsten Sigstam'
'Leon DasSarma'
'Hilary Kambil'
*/

/*
5. Find all the employees who currently have a higher salary than the 
companies overall, historical average salary.
select avg(salary) from salaries;
select * from salaries
select * from employees
*/

 -- select count(*) from(
	select concat(first_name, ' ', last_name) as EmpName, s.salary from employees e
	join salaries s on s.emp_no = e.emp_no
	where s.to_date > curdate()
		and s.salary > (select avg(salary) from salaries) 
 -- )a

/*
6. How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) 
What percentage of all salaries is this?
- Hint You will likely use multiple subqueries in a variety of ways
- Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. 
You will use this number (or the query that produced it) in other, larger queries.
*/
-- current max salary
select max(salary) from salaries where to_date>curdate();
-- select now(), curdate()

-- stddev of current salary
SELECT ROUND(stddev(s.salary), 2) as STDdev
FROM salaries AS s
WHERE s.to_date > curdate();

-- testing out difference of MAX & STD
select max(salary), ROUND(stddev(salary), 2) as STDdev, max(salary) - ROUND(stddev(salary), 2)
from salaries where to_date>curdate();

-- Find the emps within 1 stdev away from the max salary
select * from salaries s
where s.salary > (select max(salary) - ROUND(stddev(salary), 2)
					from salaries where to_date>curdate())
and s.to_date > curdate();

-- Count
select count(*) from salaries s
where s.salary > (select max(salary) - ROUND(stddev(salary), 2)
					from salaries where to_date>curdate())
and s.to_date > curdate();

SELECT ROUND((
	(select count(*) from salaries s 
	where s.salary > (select max(salary) - ROUND(stddev(salary), 2) from salaries where to_date>curdate())
	and s.to_date > curdate()) 
/ 
	(select count(*) from salaries s where s.to_date > curdate()) 
) * 100, 2) AS PctMaxStd;


-- BONUS
/*
1b. Find all the department names that currently have female managers.
select * from departments
select * from dept_manager
select * from employees
-- list of female emp_no's
select * from employees where gender = 'F'
-- list dept_manager info for dept's w/female managers
select * from dept_manager dm  where dm.emp_no in (select emp_no from employees where gender = 'F')
-- list all dept info
select * from dept_manager dm 
join departments d on d.dept_no = dm.dept_no
where dm.emp_no in (select emp_no from employees where gender = 'F')
	and dm.to_date>curdate()
*/

-- list all depts w/current female managers
select dept_name from dept_manager dm 
join departments d on d.dept_no = dm.dept_no
where dm.emp_no in (select emp_no from employees where gender = 'F')
	and dm.to_date>curdate();


/*
2b. Find the first and last name of the employee with the highest salary.
-- find highest salary
select * from salaries where salary = (select max(salary) from salaries);
-- join in employees to get name
select * from salaries s
join employees e on e.emp_no = s.emp_no
where salary = (select max(salary) from salaries);
*/

-- Clean up column
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee with the Highest Salary'
from salaries s
join employees e on e.emp_no = s.emp_no
where salary = (select max(salary) from salaries);

/*
3b. Find the department name that the employee with the highest salary works in.
select * from dept_emp;
-- join in de to get dept_no associated w/emp
select * from salaries s
join dept_emp de on de.emp_no = s.emp_no
where salary = (select max(salary) from salaries);
-- join in dept to get dept_name
select * from salaries s
join dept_emp de on de.emp_no = s.emp_no
join departments d on de.dept_no = d.dept_no
where salary = (select max(salary) from salaries);
 */

-- consolidate to one col dept_name
select dept_name as DeptNameOfHighestSalary from salaries s
join dept_emp de on de.emp_no = s.emp_no
join departments d on de.dept_no = d.dept_no
where salary = (select max(salary) from salaries);

/*
4B.Who is the highest paid employee within each department.
*/
SELECT * from salaries;
select * from dept_emp;

-- Find max salaries/dept
select max(salary), dept_no 
from employees.salaries s
join employees.dept_emp de on de.emp_no = s.emp_no
group by dept_no;


-- clean and add joins for specific cols
SELECT d.dept_name, concat(e.first_name, ' ', last_name) as EmployeeName, s.salary
FROM salaries AS s
join dept_emp de on de.emp_no = s.emp_no
join employees e on e.emp_no = s.emp_no
join departments d on d.dept_no = de.dept_no
join (select max(salary) as maxsal, dept_no 
			from salaries s
			join dept_emp de on de.emp_no = s.emp_no
			group by de.dept_no) t 
on t.maxsal = s.salary and t.dept_no = de.dept_no;

