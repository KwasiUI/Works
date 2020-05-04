/*
function for average salary of individual
*/delimiter $$
create function f_emp_avg_salary(p_emp_no int ) returns decimal(10,2) DETERMINISTIC
begin
declare v_avg_salary decimal(10,2);
select avg(salaries.salary)
into v_avg_salary
from employees
join salaries on employees.emp_no=salaries.emp_no
where employees.emp_no=p_emp_no;

return v_avg_salary;

end$$
delimiter ;
select f_emp_avg_salary(11300);

