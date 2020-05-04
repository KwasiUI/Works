/*
print the names of employees who also belong in the manager table 
using exist.
*/
select first_name, last_name
from employees
where exists(
select * from dept_manager
where dept_manager.emp_no=employees.emp_no
);

/*
Select the entire data for employees whos job title is assistant 
engineer using exist and also try joins.
*/
select *
from employees
where exists(
select * from titles
where titles.emp_no=employees.emp_no 
and
title="Assistant Engineer"
);
#In this case the join produced results faster than the sub query did

#using join for same work
select concat(first_name," ",last_name) as E_Name, gender,employees.emp_no,title 
from employees
join titles on employees.emp_no=titles.emp_no
where title="Assistant Engineer";

