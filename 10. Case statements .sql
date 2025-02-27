-- Case statements 
SELECT first_name, 
last_name,
age,
CASE
	WHEN age <= 30 THEN 'young'
    WHEN age BETWEEN 31 and 50 THEN 'old'
    WHEN age >= 50 THEN "on death's door"
END AS Age_bracket -- AS at the end after END to change title 
FROM employee_demographics
;

-- pay increase and bonus
-- < 50,000 = 5%
-- > 50,000 = 7% 
-- finance = 10% bonus 
SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05 -- can do this way 
    WHEN salary > 50000 THEN salary + (salary * 0.07) -- or can do this way 
END AS New_salary,
CASE 
	WHEN dept_id = 6 THEN salary *0.10
END AS Bonus
FROM employee_salary
;


SELECT *
FROM employee_salary
;
SELECT *
FROM parks_departments
;












