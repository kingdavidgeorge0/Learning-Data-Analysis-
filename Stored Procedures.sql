-- STORED PROCEDURES

-- Used to save code in MySQL in order to avoid rewriting it
-- Key clause is 'CREATE PROCEDURE' then 'CALL PROCEDURE'

create procedure Female_Parks_Department()
Select *
from employee_salary as sal
join employee_demographics as dem 
on sal.employee_id = dem.employee_id
where gender = 'female'
and dept_id = 1;

call Female_Parks_Department();

-- Sometimes we want to save more than one statement into a stored procedure
-- Example

create procedure All_Parks_Department()
Select *
from employee_salary as sal
join employee_demographics as dem 
on sal.employee_id = dem.employee_id
where gender = 'female'
and dept_id = 1;
Select *
from employee_salary as sal
join employee_demographics as dem 
on sal.employee_id = dem.employee_id
where gender = 'male'
and dept_id = 1;

call All_Parks_Department();

-- Only one code ran, this is because of the limitation delimiter (;) 
-- We can remedy this by assigning a new delimiter


delimiter $$
create procedure All_Parks_Department2()
begin
	Select *
	from employee_salary as sal
	join employee_demographics as dem 
	on sal.employee_id = dem.employee_id
	where gender = 'female'
	and dept_id = 1;
	Select *
	from employee_salary as sal
	join employee_demographics as dem  
	on sal.employee_id = dem.employee_id
	where gender = 'male'
	and dept_id = 1;
end $$
delimiter ; -- Changes the delimiter back to ;

call parks_and_recreation.All_Parks_Department2();

-- This now returns two different tables as intended

-- We can make changes to the stored procedure directly from the schemas tab by right clicking the particular stored procedure 
-- and selecting 'Alter stored Procedure'

-- We can also create a new stored procedure from the schemas tab directly by right clicking on 'Stored Procedure' 
-- and selecting on 'create stored procedure'

-- Its possible to add 'parameters' to stored procedures such that, as we input a value, we get a specified output
-- This is done within the brackets

-- Let's create a parameter that output the salary of a particular person when their employee id is inputed

delimiter $$
create procedure All_Parks_Department3(employee_id_param int) -- Attach the data type after the parameter, It's best practice to name the parameter something related to or reminiscent of the actual column, 
begin
	Select salary
	from employee_salary
    where employee_id = employee_id_param;
end $$
delimiter ;

call All_Parks_Department3(3);