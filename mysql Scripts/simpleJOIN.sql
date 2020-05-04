/*_ - */
SELECT 
    employees.first_name, salaries.salary
FROM
    employees
        JOIN
    salaries ON employees.emp_no = salaries.emp_no
        AND salary > 150000;