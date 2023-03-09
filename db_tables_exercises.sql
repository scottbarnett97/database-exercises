SELECT * FROM mysql.user;
SELECT user, host FROM mysql.user;
SELECT * FROM mysql.help_topic;
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;
SHOW DATABASES;
USE albums_db;
SELECT DATABASE();
SHOW TABLES;
USE employees;

-- Which table(s) do you think contain a numeric type column? salaries,employees, titles
-- Which table(s) do you think contain a string type column? dept_empl, dept_manager, titles, department,employees
-- Which table(s) do you think contain a date type column? dept_empl, dept_manager, employees, salaries, titles
-- What is the relationship between the employees and the departments tables? none directly, the dept_emp is the link between the two displaying the dept_number and emp_number
-- 
SHOW create table dept_manager;
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1