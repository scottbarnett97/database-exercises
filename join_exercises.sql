-- 1. Use the join_example_db. Select all the records from both the users and roles tables.

use join_example_db;
select database();
select *
from users, roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the 
-- lesson. Before you run each query, guess the expected number of results.
-- 4 results
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
left JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
Right JOIN roles ON users.role_id = roles.id;
-- 6 results
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- 5 results
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
--  Use count and the appropriate join type to get a list of roles along with the number of users that has the role.
--  Hint: You will also need to use group by in the query.

SELECT  roles.name AS role_name,
count(users.name) as number_of_employees
FROM users
Right JOIN roles ON users.role_id = roles.id
group by role_name
;



-- 1. Use the employees database.

use employees;
select * 
from dept_emp;

-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

select departments.dept_name, CONCAT (employees.first_name, ' ',employees.last_name) as full_name
from employees
join dept_manager on employees.emp_no = dept_manager.emp_no
join departments on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01'
order by dept_name asc ;

-- 3. Find the name of all departments currently managed by women.

select dept_name, CONCAT (employees.first_name, ' ',employees.last_name)as full_name
from employees
join dept_manager on employees.emp_no = dept_manager.emp_no
join departments on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01'and gender = 'F'
order by dept_name asc;


-- 4. Find the current titles of employees currently working in the Customer Service department.

select title, count(title)
from employees
join titles on employees.emp_no = titles.emp_no
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where titles.to_date = '9999-01-01'
and dept_emp.to_date = '9999-01-01'
and departments.dept_name = 'Customer Service'
group by title
order by title asc;

-- 5.  Find the current salary of all current managers.

select dept_name, concat(first_name, last_name) as name, salary
from employees as e
join salaries as s on e.emp_no = s.emp_no
join dept_manager as dm on dm.emp_no = e.emp_no
join departments as d on d.dept_no = dm.dept_no
where s.to_date = '9999-01-01'
and dm.to_date = '9999-01-01'
order by dept_name asc;

-- 6. Find the number of current employees in each department.

select d.dept_no, d.dept_name, count(d.dept_name)
from dept_emp as de
join departments as d on d.dept_no = de.dept_no
where de.to_date = '9999-01-01'
group by d.dept_no, d.dept_name
order by d.dept_no asc;

-- 7.Which department has the highest average salary? Hint: Use current not historic information.

select d.dept_name, avg(salary) 
from employees as e
join salaries as s on e.emp_no = s.emp_no
join dept_emp as de on de.emp_no = e.emp_no
join departments as d on d.dept_no = de.dept_no
where s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
group by d.dept_name
order by avg(salary)desc
limit 1;


-- 8. Who is the highest paid employee in the Marketing department?

select first_name, last_name
from employees as e
join salaries as s on s.emp_no = e.emp_no
join dept_emp as de on de.emp_no = e.emp_no
join departments as d on d.dept_no = de.dept_no

where s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and d.dept_name = 'Marketing'
order by salary desc
limit 1;

-- 9. Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from employees as e
join salaries as s on s.emp_no = e.emp_no
join dept_manager as dm on dm.emp_no = e.emp_no
join departments as d on d.dept_no = dm.dept_no
where s.to_date = '9999-01-01'
and dm.to_date = '9999-01-01'
order by salary desc
limit 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results.

select dept_name, Round(avg(salary)) as average_salary
from employees as e
join salaries as s on s.emp_no = e.emp_no
join dept_emp as de on de.emp_no = e.emp_no
join departments as d on d.dept_no = de.dept_no
group by dept_name
order by avg(salary) desc;

-- Bonus 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

-- select concat(e.first_name,' ',e.last_name)as Employee_Name
select *
from employees as e
join dept_emp as de on de.emp_no = e.emp_no
join departments as d on d.dept_no = de.dept_no
join dept_manager as dm on dm.emp_no = e.emp_no
where de.to_date = '9999-01-01'
;