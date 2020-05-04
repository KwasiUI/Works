/*Before the index search time was 0.141*/
select *
from salaries
where salary > 89000;

create index salary_check on salaries(salary);
/*After  the index search time  0.047*/
select *
from salaries
where salary > 89000;
