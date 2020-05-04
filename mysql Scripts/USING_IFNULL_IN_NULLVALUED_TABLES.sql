CREATE TABLE dep (
  `dept_no` char(4) NULL,
  `dept_name` varchar(40) NULL);
  
  insert into dep
  values
  ("D110","dog");
  
  
insert into dep(dept_no)
  values
  ("D112");
  
  select dept_no, ifnull(dept_name,"Name not provided") as name
from dep;

select dept_no, coalesce(dept_name,"Name not provided") as name
from dep;  