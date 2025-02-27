-- subquries

SELECT *
FROM employee_demographics
WHERE employee_id IN -- operator 
				(SELECT employee_id -- operand (can only have one)
					FROM employee_salary
                    WHERE dept_id = 1)
;


SELECT first_name, salary, 
(SELECT AVG (salary)
FROM employee_salary)
FROM employee_salary
;


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT AVG (max_age) -- make sure to add ` ` (back tick) 
FROM 
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age, 
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS agg_table -- tables must be named 
;











