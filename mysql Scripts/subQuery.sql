/*Assign employee number 110022 as a manager to all employees from
10001 to10020 and employee number 110039 as manager to 10021 to 10040*/

SELECT 
    A.*
FROM
    (SELECT 
        employees.emp_no AS Employee_ID,
            dept_emp.dept_no AS Department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS Manager_id
    FROM
        employees
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    WHERE
        employees.emp_no < '10020'
    GROUP BY employees.emp_no
    ORDER BY employees.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        employees.emp_no AS Employee_ID,
            dept_emp.dept_no AS Department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS Manager_id
    FROM
        employees
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    WHERE
        employees.emp_no > '10020'
            AND employees.emp_no <= '10040'
    GROUP BY employees.emp_no
    ORDER BY employees.emp_no) AS B
;
