/*
Create a visualization that provides a 
breakdown between the male and female employees
 working in the company each year, starting from 1990.
*/
select year(from_date ) As C_Year,
gender, count(t_employees.emp_no) as Employees
from t_dept_emp
join 
t_employees on t_dept_emp.emp_no=t_employees.emp_no
group by C_Year,gender
having C_Year>=1990;
