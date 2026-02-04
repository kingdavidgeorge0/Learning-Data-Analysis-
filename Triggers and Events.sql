-- TRIGGERS AND EVENTS

-- Triggers are blocks of code that execute automatically when an event takes place on a specific table 
-- Key Phrase 'CREATE TRIGGER'

-- Let's create a trigger that automatically updates values into the demographics table when data is inputted into the salary table

delimiter $$ 
-- We are working with more than one block of code, so we need to change the delimiter
create trigger Auto_Insert -- Naming first
	after insert on employee_salary -- Trigger condition, 'after' for new entries, 'before' for deleted entries
    for each row -- Tells MySql to execute it on a row basis
begin -- Triggers the delimiter change
	Insert into employee_demographics -- Tells it the table to insert into
    (employee_id, first_name, last_name) -- The columns we are dealing with
    values (new.employee_id, new.first_name, new.last_name); -- The 'new' keyword is for newly inputed data, use 'old' for deleted data
end $$
delimiter ;

-- Note to self, never put comments on the same line as 'delimiter' its a client command not sql

-- Lets trigger the code by making an event happen

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values(13, 'David', 'George', 'CEO', 10000000, null);

select *
from employee_salary ;


-- EVENTS

-- These are blocks of code that are executed after a scheduled time

-- Lets create an event that deletes employee info after they have retired, retirement age is 60

delimiter $$ 
create event Delete_retirees_data -- (Creation and naming)
on schedule every 30 second -- (Setting the time interval)
do -- (Gives the command to begin)
begin
	delete
    from employee_demographics
    where age >= 60;
end $$
delimiter ;

select *
from employee_demographics;




