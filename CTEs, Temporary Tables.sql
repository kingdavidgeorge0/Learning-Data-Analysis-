-- CTEs (Comment Table Expression)
-- Keyword is WITH

With CTE as 
(
select gender, count(age), avg(salary), min(salary), max(salary)
from employee_salary as sal
join employee_demographics as dem
	on sal.employee_id = dem.employee_id
group by gender
)
select count(`avg(salary)`)
from cte;

-- This can also be done with subqueries statements

Select count(`avg(salary)`)
from
	(select gender, count(age), avg(salary), min(salary), max(salary)
	from employee_salary as sal
	join employee_demographics as dem
		on sal.employee_id = dem.employee_id
	group by gender) as stuff;
    
-- The major advantage of CTEs over normal subqueries is readability and professionality

-- You can only use a CTE immediately after it is built. 

-- Multiple CTEs can be created at once and joined

-- Lets say we want the entire data of people who are older than 40 in the company

With 
CTE_Example1 as 
(
select *
from employee_demographics
where age > 40
),
CTE_Example2 as
(
select *
from employee_salary
)
select *
from CTE_Example1 
join CTE_Example2
	on CTE_Example1.employee_id = CTE_Example2.employee_id
;



-- Labelling columns directly in a CTe can override other labels

With CTE (GENDER, AGEcount, AVGsal, MINsal, MAXsal) as 
(
select gender AS G, count(age) AS C, avg(salary) AS A, min(salary) AS M, max(salary) AS  MA
from employee_salary as sal
join employee_demographics as dem
	on sal.employee_id = dem.employee_id
group by gender
)
select *
from cte;


-- TEMPORARY TABLES

-- There are two major ways to create temporary tables; From scratch or from another table

-- From scratch

create temporary table Temp_Table
-- Next we name the columns and assign the data types for them
(
First_Name Varchar (50),
Last_Name varchar(50),
Religion varchar (50)
)
;

-- Then we can insert into the tables (Keyword is insert into)

insert into Temp_table
values ('David', 'George', 'Christianity');

select *
from Temp_table;

-- Derived Temp Tables

create temporary table Female_Company_Workers_1
with 
Cte as
(select *
from employee_demographics
),
Cte2 as
(
select salary, employee_id as id
from employee_salary
)
select *
from cte
join cte2
on cte.employee_id = cte2.id
where gender = 'female';

select *
from Female_Company_Workers_1;

-- Temp Tables only exist for the duration of the session it is created, 

