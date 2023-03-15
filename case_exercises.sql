use employees;

-- 1 Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not.

select  emp_no
		, first_name
        ,last_name
        ,dept_no
        ,hire_date
        ,to_date
		, if(to_date > curdate() ,1 ,0)as is_current_employee
from employees
	join dept_emp using (emp_no);

-- to filter out duplicates

select*
from employees;

select emp_no, max(to_date)
from dept_emp
group by emp_no;

select employees.emp_no,hire_date,max_date,dept_no,
if (max_date > now(), TRUE, FALSE) as is_current_employee
from employees
	join(select emp_no, max(to_date) as max_date
	from dept_emp
	group by emp_no) as current_hire_date
    using(emp_no)
    JOIN dept_emp on dept_emp.to_date =current_hire_date.max_date 
		and dept_emp.emp_no = current_hire_date.emp_no;
    
    
-- 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q',
--  or 'R-Z' depending on the first letter of their last name.
select first_name, last_name, 
	case
    when substr(last_name,1,1) <= 'H' then 'A-H'
    when substr(last_name,1,1) between 'I' and 'Q' then 'I-Q'
    when substr(last_name,1,1) >= 'R' then 'I-Q'
    END as alpha_group
from employees;

-- or 
select first_name, last_name,
	case
		when left(last_name, 1) <='H' then 'A-H'
        when left(last_name, 1) <='Q' then 'I-Q'
        else 'R-Z'
        end as alpa_group
from employees; 



-- 3 How many employees (current or previous) were born in each decade?
select 
	case 
        when substr(birth_date,3,4) between 50 and 59 then '50s'
        when substr(birth_date,3,4) between 60 and 69 then '60s'
        END as decade_born, count(*)
from employees
group by decade_born;

-- 4 What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select  
	case
    when d.dept_name = 'Research' then 'R&D'
    when d.dept_name = 'Development' then 'R&D'
    when d.dept_name = 'Sales' then 'Sales & Marketing'
    when d.dept_name = 'Marketing' then 'Sales & Marketing'
    when d.dept_name = 'Production' then 'Prod & QM'
    when d.dept_name = 'Quality Management' then 'Prod & QM'
    when d.dept_name = 'Finance' then 'Finance & HR'
    when d.dept_name = 'Human Resources' then 'Finance & HR' 
    Else d.dept_name
    End as department_group, round(avg(salary)) as avg_salary
From departments as d
	join dept_emp as de on de.dept_no = d.dept_no
    join salaries as s on s.emp_no = de.emp_no
    where s.to_date > curdate()
    and de.to_date > curdate()
    group by department_group;
	
