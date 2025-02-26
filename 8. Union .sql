-- Unions allows you to combine rows together from seperate or same tables 
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

-- more advanced 
SELECT first_name, last_name, 'Old man' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old lady' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly paid emp' AS label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;