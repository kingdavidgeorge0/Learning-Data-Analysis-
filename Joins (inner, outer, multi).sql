-- Joins

-- Used to combine tables with similar columns. The column name doesn't have to be the same, as long as the data contained is similar, 
-- It can be done

-- Inner join returns columns that are the exact same with the other

select *
from employee_demographics;

select *
from employee_salary;

select *
from  employee_demographics
inner join employee_salary
	on employee_salary.employee_id = employee_demographics.employee_id;
    
-- Take note of the order, after an inner join command, use the on to specify which column the join is happening, also, specify the table 
-- you are referring to explicitly, this is to avoid the error of ambiguity

-- We can take this a step further by the use of aliasing, as follows

select *
from  employee_demographics as dem
inner join employee_salary as sal
	on sal.employee_id = dem.employee_id;
    
-- If we were to select specific columns from the joined tables, its possible but in instances where you can have a similar column name for more
-- than one table, be sure to specify

select dem.employee_id, age, occupation
from  employee_demographics as dem
inner join employee_salary as sal
	on sal.employee_id = dem.employee_id;
    
-- Notice how the age and occupation columns are not referenced to their table?
-- When you alias, use the aliased name. The system no longer recognizes the previous name

select employee_demographics.employee_id, age, occupation
from  employee_demographics 
inner join employee_salary 
	on employee_demographics.employee_id = employee_salary.employee_id;

-- Outer joins
-- Divided into left and right outer joins but can be written as just left or right
-- The first mentioned table is treated as the left and the second as the right

select *
from  employee_demographics 
left join employee_salary 
	on employee_demographics.employee_id = employee_salary.employee_id;
    
-- This basically writes out all the data in employee_demographics then all the matching data in employee_salary
-- We can reverse this and something interesting happens

select *
from  employee_demographics 
right join employee_salary 
	on employee_demographics.employee_id = employee_salary.employee_id;

-- It writes out all the data in employee_salary then those in employee_demographics. Those rows in employee_demographics that do not have
-- a corresponding row in employee_salary are returned as null

-- SELF JOIN

-- Used to join a table to itself

select *
from employee_demographics as dem1
join employee_demographics as dem2
	on dem1.employee_id = dem2.employee_id;
    
-- Lets do a secret santa program where, based on employee_id, secret santas are assigned to the next number on the list

select dem1.employee_id as SN,
dem1.first_name as Secret_Santa,
dem1.last_name as ___, 
dem2.first_name as Elf,
dem2.last_name as __
from employee_demographics as dem1
join employee_demographics as dem2
	on dem1.employee_id + 1 = dem2.employee_id;
    
    
-- Joining multiple tables

-- Let's use the parks_department 

select *
from parks_departments;

select *
from employee_salary;

-- On the basis of the department id, lets join it to the parks_department to the joint of both employee_salary and employee_demographics
-- Notice that only employee_salary has dept_id meanwhile no similar field appears on the employee_demographics

select *
from employee_demographics as Dem
join employee_salary as Sal
	on Dem.employee_id = Sal.employee_id
join parks_departments as Dept
	on sal.employee_id = Dept.department_id;
    
-- Only fields that are in the three tables are reflected