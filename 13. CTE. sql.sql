-- CTEs common table expression (with is the key word to define CTEs)
with CTE_example (gender,avg_sal, max_sal, min_sal, count_sal)as 
(
select gender, avg(salary), max(salary), min(salary), count(salary)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_example
;

-- can also be written like this but above is standard in workforce
select avg(avg_sal)
from (-- subquery
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
) exmaple_subquery
;

-- CTEs are just queries you are writing. Not pernament tables 
with CTE_example as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)
from CTE_example
;
-- error cause SQL is trying to look for the table CTE_example which does not exist cause we never created one
select avg(avg_sal)
from CTE_example
;















