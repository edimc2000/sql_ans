-- 1.	Write a query to display the employee id, employee name (first name and last name) for all employees who earn more than the average salary. 
SELECT employee_id, first_name || ' ' || last_name AS "Employee Name"
 FROM employees
 WHERE salary > ( SELECT AVG( salary ) FROM employees ); 

-- 2.	Write a query to display the employee name (first name and last name), employee id, and salary of all employees who report to Payam. 
SELECT first_name || ' ' || last_name AS "Employee Name", employee_id, salary
  FROM employees 
  WHERE manager_id = ( SELECT employee_id FROM employees WHERE first_name = 'Payam' ); 

-- 3.	Write a query to display the department number, name (first name and last name), job_id and department name for all employees in the Finance department.
SELECT  department_id, first_name || ' ' || last_name AS "Name", job_id, department_name
  FROM 
    (
      SELECT e.*,d.department_name 
        FROM  employees e 
        LEFT JOIN departments d 
          ON e.department_id= d.department_id
    )
  WHERE department_name = 'Finance';

-- 4.	Write a query to display all the information of the employees whose salary is within the range of the smallest salary and 2500.
SELECT * 
  FROM employees
  WHERE salary 
  BETWEEN ( SELECT MIN(salary) FROM employees ) -- min salary is 2100 
  AND 2500;

-- 5.	Write a SQL query to find the first name, last name, department, city, and state province for each employee.
SELECT employees.first_name,
       employees.last_name,
       departments.department_name,
       departments.city,
       departments.state_province
  FROM employees
  JOIN (
   SELECT departments.*,
          locations.city,
          locations.state_province
     FROM departments
     JOIN locations
   ON departments.location_id = locations.location_id
) departments
ON employees.department_id = departments.department_id;


-- 6.	Write a SQL query to find all those employees who work in department ID 80 or 40. Return first name, last name, department number, and department name.
SELECT employees.first_name,
       employees.last_name,
       employees.department_id,
       departments.department_name
  FROM employees
  JOIN departments
ON employees.department_id = departments.department_id 
WHERE departments.department_ID IN (40, 80);


-- 7.	 Write a query to display the employee name (first name and last name) and hire date for all employees in the same department as Clara. Exclude Clara.
SELECT first_name  || ' ' || last_name AS "Name",
       hire_date
  FROM employees
  WHERE department_id = (
   SELECT department_id
     FROM employees
    WHERE first_name = 'Clara'
  ) AND first_name != 'Clara'; 

-- 8.	Write a query to display the employee number, name (first name and last name), and salary for all
-- employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT  employee_id, 
        first_name  || ' ' || last_name AS "Name", 
        salary
  FROM employees
  WHERE salary > ( SELECT AVG(salary) FROM employees) 
  AND department_id IS NOT NULL
  AND LOWER ( first_name  || ' ' || last_name ) LIKE '%j%';


 
-- 9.	Write a SQL query to find those employees whose first name contains the letter ‘z’. Return first name, last name, department, city, and state province.
SELECT e.first_name,
       e.last_name,
       d.department_name,
       l.city,
       l.state_province
  FROM employees e
  LEFT JOIN departments d
ON e.department_id = d.department_id
  LEFT JOIN locations l
ON d.location_id = l.location_id
 WHERE LOWER ( first_name ) LIKE '%z%';


-- 10.	Write a SQL query to find all departments, including those without employees. Return first name, last name, department ID, department name.
SELECT e.first_name,
       e.last_name,
       d.department_id,
       d.department_name
  FROM employees e
  full JOIN departments d
ON e.department_id = d.department_id;



-- 11.	Write a query to display the employee number, name (first name and last name) and job title for all employees 
-- whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS "Name",
       j.job_title
  FROM employees e
  LEFT JOIN jobs j
ON e.job_id = j.job_id
 WHERE salary < (
   SELECT MIN(salary)
     FROM employees
    WHERE job_id = 'MK_MAN'
  ); 


-- 12.	Write a query to display the employee number, name (first name and last name) and job title for all employees whose 
-- salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS "Name",
       j.job_title
  FROM employees e
  LEFT JOIN jobs j
  ON e.job_id = j.job_id
  WHERE salary >  ( SELECT MAX(salary)
                      FROM employees
                      WHERE job_id = 'PU_MAN'
                  ); -- PU MAN salary is 11 000

-- 13.	Write a query to display the employee number, name (first name and last name) and job title for all employees whose 
-- salary is more than any average salary of any department.
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS "Name",
       j.job_title
  FROM employees e
  LEFT JOIN jobs j
  ON e.job_id = j.job_id
  WHERE salary > (
  SELECT MAX("Average Salary")
    FROM (
    SELECT department_id,
            SUM(salary) AS "Total Salary",
            round(
              avg(salary),
              2
            ) AS "Average Salary"
      FROM employees
      GROUP BY department_id
  ));  --- max average salary of the departments 271800

-- 14.	Write a query to display the department id and the total salary for those departments which contains at least one employee.
SELECT department_id,
       "Total Salary"
  FROM (
   SELECT department_id,
          SUM(salary) AS "Total Salary",
          COUNT(*) AS "Num_Employees"
     FROM employees
    GROUP BY department_id
  )
  WHERE "Num_Employees" > 1;

-- 15.	Write a SQL query to find the employees who earn less than the employee of ID 182. 
-- Return first name, last name and salary.
SELECT first_name,
       last_name,
       salary
  FROM employees
 WHERE salary < (
   SELECT salary
     FROM employees
    WHERE employee_id = 182
);     -- 182's salary is 2500


-- 16.	Write a SQL query to find the employees and their managers. Return the first name of the employee and manager.
SELECT e.first_name "Employee",
       m.first_name "Manager"
  FROM employees e
  LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- 17.	Write a SQL query to display the department name, city, and state province for each department.
SELECT d.department_name,
       l.city,
       l.state_province
  FROM departments d
  LEFT JOIN locations l
ON d.location_id = l.location_id;

-- 18.	Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.
SELECT first_name || ' ' || last_name AS "Name",
       department_id,
       salary
  FROM employees
  WHERE department_id IN ( SELECT department_id FROM departments WHERE upper(department_name) LIKE 'IT%')
  AND salary > ( SELECT AVG(salary) FROM employees);

-- 19.	Write a SQL query to find out which employees have or do not have a department. Return first name, last name, department ID, department name.
SELECT  e.first_name, 
        e.last_name, 
        e.department_id,
        d.department_name
  FROM employees e 
  LEFT JOIN departments d 
    ON e.department_id = d.department_id
  WHERE e.department_id is null;

-- 20.	Write a SQL query to find the employees and their managers. Those managers do not work under any manager also appear in the list. 
-- Return the first name of the employee and manager.
SELECT e.first_name "Employee",
       m.first_name "Manager"
  FROM employees e
  LEFT JOIN employees m
ON e.manager_id = m.employee_id;


-- 21.	 Write a query to display the name (first name and last name) for those employees who 
-- gets more salary than the employee whose ID is 163.
SELECT first_name || ' ' || last_name AS "Name",
       salary
  FROM employees
  WHERE salary > ( SELECT salary FROM employees WHERE employee_id = 163 ); -- 163 salary is 9500


-- 22.	 Write a query to display the name (first name and last name), salary, department id, job id 
-- for those employees who works in the same designation as the employee works whose id is 169.
SELECT first_name || ' ' || last_name AS "Name",
       salary,
       department_id,
       e.job_id
  FROM employees e
  JOIN jobs j
ON e.job_id = j.job_id 
WHERE e.job_id = (select job_id from employees where EMPLOYEE_ID = 169 );
-- designation is job is or  title, 169 is id is SA-REP sales rep


-- 23.	Write a SQL query to find the employees who work in the same department as the employee 
-- with the last name Taylor. Return first name, last name and department ID.
SELECT first_name, last_name,  department_id
  FROM employees
  WHERE department_id IN ( SELECT department_id FROM employees WHERE last_name = 'Taylor' ); 

-- 24.	Write a SQL query to find the department name and the full name (first and last name) of the manager.
SELECT "Department", "Name"
   FROM (
    SELECT DISTINCT e.manager_id,
                    m.first_name || ' ' || m.last_name AS "Name",
                    d.department_name AS "Department"
      FROM employees e
      JOIN employees m
    ON e.manager_id = m.employee_id
      JOIN departments d
    ON m.department_id = d.department_id
      WHERE e.manager_id IS NOT NULL
      ORDER BY manager_id ASC
    ); 


-- 25.	Write a SQL query to find the employees who earn $12000 or more. Return employee ID, starting date, end date, job ID and department ID.
SELECT e.employee_id,
       e.hire_date,
        j.end_date,
       e.job_id,
       e.department_id
  FROM employees e
  LEFT JOIN job_history j
    ON e.employee_id = j.employee_id
  WHERE salary > 12000
  ORDER BY employee_id;