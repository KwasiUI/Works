/* From the emp_manager table select employees who are also maagers themselves.
*/
select distinct e1. *
from emp_manager e1
join emp_manager e2
on e1.emp_no=e2.manager_no
