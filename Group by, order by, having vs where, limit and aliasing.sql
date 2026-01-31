 SELECT gender,
 AVG(age)
 FROM employee_demographics
 GROUP BY gender
 ;
 
 -- What the above means is, find the average for male and for female
 
SELECT occupation
FROM employee_salary
group by occupation
;

SELECT occupation, salary
FROM employee_salary
group by occupation, salary
;

-- This shows we can group by more than one parameter, notice how 'OFFICE MANAGER' appears more than once? thats cuz the salary coln for the both are differnt values

 SELECT gender,
 AVG(age),
 max(age),
 min(age)
 FROM employee_demographics
 GROUP BY gender
 ;
 
 select gender, avg(age), min(age)
 from employee_demographics
 group by gender
 ;
 
select gender, avg(age), min(age), count(*)
 from employee_demographics
 group by gender
 ;
 
 -- Count returns the number of rows for that particular group
 
 select salary
 from employee_salary
 group by salary
 ;
 
 -- ORDER BY
  select *
 from employee_salary
 order by salary
 ;
 
 -- default mode is smallest first (ascending) or ASC, it can be changed to descending or desc
 
select salary
from employee_salary
order by salary desc
;

-- we can order by multiply things like gender and age simultaneously

select *
from employee_demographics
order by gender;

select *
from employee_demographics
order by gender, age
;

-- what this does is that within that female order, the rows are further organized by age
 
select *
from employee_demographics
order by gender desc, age asc
;

-- What's cool is that even in instances of multiple orders, we can still specify how we want them to de ordered individually
-- switching the order of columns in the order by function can be pretty disastrous 

select *
from employee_demographics
order by age, gender
;
 
-- The ages are totally unique, so it will be impossible to get the same result as before where the genders were non distinct
-- Also, in MySQL we can use numbers to represent columns as long as they correspond, gender is the fifth column so 5, age is the fourth so 4
-- This is not recommended though

 select *
from employee_demographics
order by 5, 4
;
 
-- HAVING VS WHERE

-- We sometimes may want to further filter outputs based on certain criteria EXAMPLE:

select gender, avg(age)
from employee_demographics
group by gender
where avg(age) > 40;

-- The above is faulty because the 'where' conflicts with the first avg function as that avg hasnt been calculated yet
-- To remedy this, a special function, HAVING was created

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;
 
-- Limit and aliasing

-- Limit sets a limit to the number of rows returned. it can be combined with order by to become very helpful

select *
from employee_demographics
limit 3
;

-- This gives the first three rows of data

select *
from employee_demographics
order by age desc
limit 3
;
 
-- This returns the top three oldest people

select *
from employee_salary
;

-- lets find the top three highest earning people

select *
from employee_salary
order by salary desc
limit 3
;

select *
from employee_salary
order by salary desc
limit 3, 5
;

-- what the above does is that it starts from position three and takes the next 5 rows, so after the top 3 highest paid, the next five

-- Aliasing

-- A way to change column name
 
select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

-- from this code, if we want to change the name of the avg(age) column we can do it with aliasing, AS

select gender, avg(age) as Average_Age
from employee_demographics
group by gender
having Average_Age > 40;
 
-- Now the 'as' isnt really compulsory, the next code will run just fine

select gender, avg(age)  Average_Age
from employee_demographics
group by gender
having Average_Age > 40;
 
 
 
 