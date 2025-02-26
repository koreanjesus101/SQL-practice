-- String Functions

-- LENGTH shows how many characters are in 
SELECT LENGTH ('skyfall')
;

SELECT first_name, LENGTH(first_name) 
FROM employee_demographics
ORDER BY 2
;

SELECT UPPER ('sky');
SELECT LOWER ('SKY');

SELECT first_name, UPPER(first_name) 
FROM employee_demographics
;

SELECT RTRIM('         SKY         '); -- Eliminates trailing white spaces 


SELECT first_name,
LEFT(first_name, 4), -- 4 is how many charcters from left side we want to SELECT
RIGHT(first_name, 4), 
SUBSTRING(first_name, 3,2 ), -- 3rd position, over to the right 2 characters 
birth_date,
SUBSTRING(birth_date, 6,2 ) AS brith_month
FROM employee_demographics
;


SELECT first_name, REPLACE (first_name, 'a', 'z') -- replacing 'a' with 'z'
FROM employee_demographics
;

SELECT LOCATE ('e','Sean')-- looking for 'e' in 'Sean' and says it is in position '2'
; 

SELECT first_name, LOCATE('An', first_name) -- looking for peopl with 'An' in their name
FROM employee_demographics
;

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name-- combing first_name and last_name together 
FROM employee_demographics
;

