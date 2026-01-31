-- Case Statements

-- Allows for addition of logic and logical operators in select statements. Kinda like a where clause

select first_name,
last_name,
age,
	case
	when age <= 40 then 'YOUNG'
end 
from employee_demographics;

-- Lets spice things up

select first_name, last_name, age,
case
    when gender = 'male' and age > 50
		then 'Old fogey'
	when gender != 'male' and age > 50
		then 'Old crone'
	when age <= 40 
		then 'Eligible for marrriage'
	when age between 41 and 50 
		then 'Alright, I guess'
End as Remark
from employee_demographics;

-- that was fun

-- Pay increase and bonus

select * 
from employee_salary
join parks_departments
	on dept_id = department_id;

-- > 50000 = 25%
-- < 50000 = 20%
-- Finance = 30%

select upper(concat(first_name, ' ', last_name)) 'Employee Name', salary 'Salary',
case
	when salary > 50000 then salary * 0.25
	when salary <= 50000 then salary * 0.2
    when dept_id = 6 then salary * 0.3
end as 'Bonus Amount'
from employee_salary;


-- Thats really cool, but management checked and decided that the public works department performed exemplarily and they must be rewarded for it
-- They mandated everyone from the department to be given 10% raises

select upper(concat(first_name, ' ', last_name)) 'Employee Name', salary 'Salary',
case
	when salary > 50000 then salary * 0.25
	when salary <= 50000 then salary * 0.2
    when dept_id = 6 then salary * 0.3
end as 'Bonus Amount',
case
	when dept_id = 3 then salary * 1.1 else 'Better Luck next time '
end as 'New Salary'
from employee_salary
order by `employee name`;


-- Sub-Queries in MySql

-- IN WHERE STATEMENTS

-- Boss asked us to pull up the demograpic data of people in the parks and recreation department

-- Analysis
-- Demographic data is in Employee_demographics table, 
-- But there is no tie or link between employee_demographic table and parks department table
-- There is a link in the Employee_salary table which is the dept_id column
-- Parks and recreation department has a department id of 1
-- And the link between Employee_demographics and Employee_salary is the employee_id column
-- We have to tie all of these together

select *
from employee_demographics
where employee_id in 
	(select employee_id
		from employee_salary
        where dept_id = 1);
        
-- Kinda like in a join statement, you have to find and subquery based on similar columns
-- The column name in the first where statement must be identical to that in the proceeding select statement

-- IN SELECT STATEMENT

-- We were told to make a table showing the average salary, minimum salary, maximum salary and difference between employee salary and average salary
-- for all employees

select upper(concat(first_name, ' ', last_name)) as 'FULL NAME',
	salary as 'SALARY',
	(select avg(salary) 	from employee_salary) AS 'AVERAGE SALARY',
    salary - (select avg(salary) from employee_salary) AS 'DIFFERNCE',
    (select min(salary) from employee_salary) AS 'MINIMUM',
    (select max(salary) from employee_salary) AS 'MAXIMUM'
from employee_salary;
    
select avg(avg_sal), avg(min_sal), avg(max_sal)
from
	(select *
	from
	(SELECT DEPT_ID as Id, 
		avg(salary) as Avg_Sal, 
		min(salary) as Min_sal, 
		max(salary) as Max_Sal
		from employee_salary
	group by dept_id) as tab
	join parks_departments
	on id = department_id) as tab2
    
-- To understand what i did there, highlight the inner queries and work your way up from there



    






