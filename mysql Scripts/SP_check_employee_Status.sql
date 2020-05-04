/*
Extract the employee number, first name, and last name of the first 100 employees,
 and add a fourth column, called “current_employee” saying “Is still employed” 
 if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.
*/

select concat(first_name," ",last_name) As Name,
case when max(to_date)>current_date() 
then "Is Still employed"
else "Not an employee" 
end as Employement_Status
from employees
join 
dept_emp on employees.emp_no=dept_emp.emp_no
group by dept_emp.emp_no
limit 100;

#make this a procedure to check status of a given employee number
delimiter $$
create procedure check_employee_status(in p_emp_no integer)
Begin

select concat(first_name," ",last_name) As Name,
case when max(to_date)>current_date() 
then "Is Still employed"
else "Not an employee" 
end as Employement_Status
from employees
join 
dept_emp on employees.emp_no=dept_emp.emp_no
where p_emp_no=employees.emp_no
group by dept_emp.emp_no
limit 100;

End $$
delimiter ;



