/*
Create a stored procedure for the top 10 employess earning employees and how much they make
*/
delimiter $$
create procedure Top10earning_employees()
BEGIN
select concat(first_name, " ", last_name) as Employee_names,salary as Annuanl_Salary
from employees
join salaries
on employees.emp_no=salaries.emp_no
order by salary desc
limit 10;
END$$

delimiter ;

call employees.Top10earning_employees();

