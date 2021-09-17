/*Query the two cities in STATION with the shortest and longest CITY names, 
as well as their respective lengths (i.e.: number of characters in the name).
If there is more than one smallest or largest city,choose the one that comes first when ordered alphabetically. */

select distinct city, length(city)
from station
order by length(city) asc,city asc
limit 1;


select distinct city, length(city)
from station
order by length(city) desc,city desc
limit 1;

/*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/
select city 
from station
where city like 'a%'or city like 'e%' or city like 'i%'or city like 'o%'or city like'u%';


/*starts and ends with vowels*/
SELECT DISTINCT city
FROM   station
WHERE  city RLIKE '^[aeiou].*[aeiou]$'

/*Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
Your result cannot contain duplicates.*/
SELECT DISTINCT city
FROM   station
WHERE  city not RLIKE '^[aeiou]'  and city not RLIKE '[aeiou]$'

/*Query the Name of any student in STUDENTS who scored higher than Marks. 
Order your output by the last three characters of each name. If two 
or more students both have names ending in the same last three characters 
(i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.*/
select name 
from students 
where marks > 75 
order by substr(name,length(name)-2,3),id asc;
