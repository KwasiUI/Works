/*Select all employees whose average salary is higher than $120,000 per annum*/
SELECT 
    emp_no, (salary) AS Average_Salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;
