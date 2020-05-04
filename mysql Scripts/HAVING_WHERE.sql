/*Using having and group by effieciently
Exact list of names that are encounted less than 200 times 
let this data be for people who were hired after 01/01/1999 
*/
SELECT 
    first_name, COUNT(first_name) AS Name_Occurance
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200;

/*Using having and group by effieciently
Select the employee numbers of all individuals who have signed
 more than 1 contract after the 1st of January 2000.
*/

SELECT 
    emp_no, count(emp_no)
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no; 

/*Adding Limits
Print the top 10 highest paid people in the company
*/
select  concat(first_name," ",last_name) as Employe ,salary
from employees join salaries on employees.emp_no=salaries.emp_no
order by salary desc
limit 10; 