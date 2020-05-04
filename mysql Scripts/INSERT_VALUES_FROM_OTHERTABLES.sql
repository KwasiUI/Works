/*Inserting into a table with values from another table*/

create table dep_dup (
dept_no char(4) not null,
dep_name varchar(40) not null);

insert into dep_dup
select * 
from departments;

select *
from dep_dup;