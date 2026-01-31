SELECT *
FROM employee_salary;

SELECT *
FROM employee_salary
WHERE employee_id > 6;

SELECT *
FROM employee_salary
WHERE last_name = 'Dwyer'
;

SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM employee_salary
WHERE salary < 50000;

SELECT *
FROM employee_salary
WHERE salary <= 50000;

SELECT *
FROM employee_demographics
WHERE gender = 'MALE';

SELECT *
FROM employee_demographics
WHERE gender != 'MALE';

SELECT *
FROM employee_demographics
WHERE birth_date > '1977-07-30'
AND gender = 'Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1977-07-30'
OR gender = 'Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1977-07-30'
AND NOT gender = 'Female';

-- LIKE STATEMENT
-- % and __
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___'
;

-- % and __ can be combined
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%'
;

-- We can use it for more than just strings
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1977%'
;