

/*Question 1
print the name of the employees that are also department managers
*/
select employees.first_name, employees.last_name
from employees
where employees.emp_no 
/*Here we are saying that the employees with the following
emp no can also be found in the dept manager table.
1. Sub query runs first and submits its results 
to the outer query for use*/
in (
select dept_manager.emp_no
from dept_manager

);

/*Question2
Extract the information about all department managers
 who were hired between the 1st of January 1990 and 
 the 1st of January 1995.*/
 
 select * from dept_manager
 where emp_no
 in (
 select emp_no
 from employees
 where hire_date between '1990-01-01' AND '1995-01-01'
 );