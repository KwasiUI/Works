/*
Extract a dataset containing the following information about the 
managers: employee number, first name, and last name.
 Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee,
 and another one saying whether this salary raise was higher than $30,000 or NOT.
*/
SELECT 
  dm.emp_no,concat(e.first_name," ",e.last_name) as Name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

   
