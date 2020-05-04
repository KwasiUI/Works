select concat(first_name," ",last_name) as  Employee_Name,
round(DATEDIFF (CURRENT_DATE(), birth_date)/365) as Age,
case when 
gender="M" then "Male"
else "Female"
end as Gender  

from employees;