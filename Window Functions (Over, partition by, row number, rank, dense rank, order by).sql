-- Window functions

-- Operate similar to a group by but without a lot of it's previous limitations
-- Let's run a quick comparison between the two functions

-- Let's find the average salary for each gender.

-- Analysis:
	-- Gender belongs in the demographics table, but salary belongs in the salary table. Two distinct tables.
    -- Using the Join function we can work with both of them together directly.alter
    -- Then we query off of that joined table
    
Select gender, avg(salary) as 'Avg_Sal'
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id
group by gender;

-- Lets compare this to working on a window function

select gender, avg(salary) over() -- This over() function basically says average value for the entire salary column
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- We can make it more specific to a particular gender using the partition by command

select gender, avg(salary) over(partition by gender)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- This gives the avarage salary for each gender partition but without being constrained by typical group by constraints

-- Also, this function gives greater freedom and customization ability

select gender, dem.first_name, dem.last_name, avg(salary) over(partition by gender)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- If we tried this in a group by function, it would return a very different output

select gender, dem.first_name, dem.last_name, avg(salary)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id
group by gender, dem.first_name, dem.last_name;

-- This is because the group by function operates by first categorizing the data based on the given parameters, in this case, this (gender, dem.first_name, dem.last_name)
-- Then it checks for any similar combination of data before it begins any aggregate functions, but in this case, the combination of data
-- is totally unique so we get what we got.

-- That's why a windows function is so vital, that independence of aggregated columns

-- Let's try a different aggregate function, the sum
-- In this, lets do a rolling total, segmented by gender
-- This will be implemented using two commands in the over bracket; partition by and order by

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    sum(salary) over(partition by gender order by dem.employee_id) as 'Rolling total'
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;

-- Without the order by sub-command, we would just get a total for each gender categorization

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    sum(salary) over(partition by gender)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- Without the partition by sub-command we would get this

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    sum(salary) over(order by dem.employee_id)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- ROW NUMBER, RANK, DENSE RANK

-- These functions assign numbers to rows based on their nature and on certain rules

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    row_number() over()
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;

-- This is very basic and all inclusive
-- Let's organize it based on gender

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    row_number() over(partition by gender)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- In that, lets order it based on salary from the smallest first
select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    row_number() over(partition by gender order by salary asc)
from employee_demographics as Dem
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;

-- Using this as a guideline, lets look at the differences between row number, rank and dense rank

select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    row_number() over(partition by gender order by salary asc) as 'row_num',
    rank () over(partition by gender order by salary asc) as 'rank',
    dense_rank () over(partition by gender order by salary asc) as 'dense rank'
from employee_demographics as Dem 
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;


-- Looking at the resultant table, we'll find that employee_id 3 and 5 share a common salary (what we are ordering by) which is 50000, the rank function row number 
-- function disregards it, but the rank and dense rank acknowledge it, but in different ways
-- Rank assigns the two similar position the same value (2) then skips the next number and continues
-- Dense rank assigns the two the same value but doesn't skip anything and continues from the next number

-- Lets see another illustration



select dem.employee_id, gender, 
	dem.first_name, dem.last_name, salary, 
    dept_id,
    row_number() over(partition by gender order by dept_id asc) as 'row_num',
    rank () over(partition by gender order by dept_id asc) as 'rank',
    dense_rank () over(partition by gender order by dept_id asc) as 'dense rank'
from employee_demographics as Dem 
join employee_salary as Sal
	on dem.employee_id = sal.employee_id;
    
-- The above does a much better job of illustrating those differnces between the similar functions