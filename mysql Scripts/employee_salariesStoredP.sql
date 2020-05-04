/*Create a program that returns the name salary start and end date
of a specific employee of my choice(i will give my input) */

delimiter $$
create procedure employee_salaries(in p_emp_no integer)
BEGIN
select concat(first_name, " ", last_name) as Employee_names,
salaries.salary as Salary, salaries.from_date, salaries.to_date
from employees
join salaries  on employee.emp_no=salaries.emp_no
where empoyees.emp_no=p_emp_no;

END$$ 

delimiter ;



