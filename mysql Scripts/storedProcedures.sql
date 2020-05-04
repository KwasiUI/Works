/*
Creatting stored procedures
case 1 this procedure returns first 999 row from employees
case 2 this procedure returns full names of employees 
*/
use employees;
drop procedure if exists select_employees;
delimiter $$
create procedure select_employees()
BEGIN
select *
from employees
limit 999;
END$$ 

delimiter ;
call employees.select_employees();
#or
call select_employees();

#case 2
delimiter $$
create procedure fullname_employees()
BEGIN
select concat(first_name, " ", last_name) as Employee_names
from employees
limit 1000;
END$$ 

delimiter ;
call fullname_employees();