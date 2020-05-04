/*
Create a view that will extract the average salary of all managers registered in the database.
 Round this value to the nearest cent.

*/CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no; 