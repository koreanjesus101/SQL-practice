-- WHERE clause 

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators 
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;


-- LIKE statements 
-- % (anything) and _ (specific value)
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;


