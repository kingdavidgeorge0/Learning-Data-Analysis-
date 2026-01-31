-- UNIONS

-- Allow for the combination of rows, unlike columns as in joins
-- Works with two select statements unlike the join operation

select first_name, last_name
from employee_demographics
union
select occupation, salary
from employee_salary;

-- You can only work with the same number of columns at a time (first_name) and (last_name) make two same as occupation and salary
-- To be practical and effective, join similar data, not random disorganized ones

select first_name, last_name
from employee_demographics
union
select first_name, last_name
from employee_salary;

-- The union function defaults to returning only distinct values, no duplicates

select first_name, last_name
from employee_demographics
union distinct
select first_name, last_name
from employee_salary;

-- This can be changed by using a Union All

select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary;

-- HR asked you to get your hands dirty, but its a surprise. You are to prepare a list of young or lower paid employees for a giveaway

-- Analysis First

-- Age data is in employee_demographics table
-- Salary data is in employee_salary table

-- There are conditions given, so where function is needed

-- In order to present the data from the two tables simultaneously a union is needed

select first_name, last_name, age
from employee_demographics
where age < 40
union
select first_name, last_name, salary
from employee_salary
where salary < 60000;

-- That's nice, but you showed it to HR and she said to make it neater and give them labels according to the category they fall under
-- Also, indicate their gender, and ensure there are no duplicates


	select first_name, last_name, age, 'Freshman' as label
	from employee_demographics
	where age < 40
	and gender = 'male'
	union
	select first_name, last_name, age, 'Belle' as label
	from employee_demographics
	where age < 40
	and gender = 'female'
	union
	select first_name, last_name, salary, 'broke' as label
	from employee_salary
	where salary < 60000
order by first_name, last_name;


-- STRING FUNCTIONS
-- Set of function that help work with or manipulate string or text data
-- Remember to add the apostrophe signs to indicate they are strings

-- Length: Returns the number of letters a string has

select length('WATERFALL');

select first_name, length(first_name)
from employee_demographics;

-- Upper and Lower: Capitalizes or reduces the case of strings respectively

select lower('WATERFALL');

select upper('WATERFALL');

select first_name, upper(first_name) Yell, lower(first_name) whisper
from employee_demographics;

-- TRIM: Removes the white space or empty space in a string value, can be detrimental sometimes
-- rtrim: Removes from the right
-- ltrim: Removes from the left

select trim(' How Are You '), rtrim('help   '), ltrim('   no');


-- LEFT, RIGHT, SUBSTRINGS
-- Can remove characters totally

select 
upper(left(first_name, 5)), 
upper(right(last_name, 3)), 
birth_date, 
substring(birth_date, 6, 2) as birth_month
from employee_demographics;

-- Locate: Find the position value of a letter in a string

select first_name, locate('e', first_name)
from employee_demographics;

-- Replace: Substitute one letter in a string with another designated one

select gender, replace(gender, 'e', 'x')
from employee_demographics;

-- Concat: combine column into one

select first_name, last_name, age, concat(first_name, ' ', last_name, ' ', age) as Brief
from employee_demographics;