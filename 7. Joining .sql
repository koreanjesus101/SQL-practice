-- Joins 

SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_salary
; 

SELECT dem.employee_id, age, occupation 
FROM employee_demographics AS dem 
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
; 
-- The INNER JOIN keyword returns only rows with a match in both tables. 
-- Which means that if you have a product with no CategoryID, or with a CategoryID that is not present in the Categories table, 
-- that record would not be returned as a result.

-- Outer Joins Left and Right JOIN
SELECT *
FROM employee_demographics AS dem 
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
; 
-- The RIGHT JOIN keyword returns all records from the right table (table2), 
-- and the matching records from the left table (table1). 
-- The result is 0 records from the left side, if there is no match.


SELECT *
FROM employee_demographics AS dem 
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
; 
-- The LEFT JOIN keyword returns all records from the left table (table1), 
-- and the matching records from the right table (table2). 
-- The result is 0 records from the right side, if there is no match.


-- Self Join 
SELECT emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;
--A self join is a regular join, but the table is joined with itself.



-- Joining multiple tables together 
SELECT *
FROM employee_demographics AS dem 
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd 
	ON sal.dept_id = pd.department_id
; 

SELECT *
FROM parks_departments
;

SELECT *
FROM employee_salary
;





