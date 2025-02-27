-- Window functions


-- group by fucntion 
select gender, avg(salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal 
	on dem. employee_id = sal.employee_id
group by gender
;


-- window function 
-- display different table then GROUP BY
-- partition by: Used to perform a calculation on individual rows of a group using other rows of that group.
select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender)  
from employee_demographics as dem
join employee_salary as sal 
	on dem. employee_id = sal.employee_id
;


-- SUM of salary rolling total 
select dem.first_name, dem.last_name, gender, salary,
-- Ex/ takes 75,000 from Leslie and adds it to the 25,000 April made to output rolling_total 100,000 until all females are looked at
sum(salary) over(partition by gender ORDER BY dem.employee_id) as rolling_total  
from employee_demographics as dem
join employee_salary as sal 
	on dem. employee_id = sal.employee_id
;


-- Row number just gives rows numbers to visualize from Desc or Asc
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary Desc) as row_num,
-- rank is same but will have assign duplicates the same number, AND next number displayed positionally not numerically (5,5,7)
rank() over( partition by gender order by salary Desc) as rnk_num,
-- dense rank WILL diaply the next number after duplicates in numericale order (5,5,6)
dense_rank() over( partition by gender order by salary Desc) as dense_rank_num
from employee_demographics as dem
join employee_salary as sal 
	on dem. employee_id = sal.employee_id
;



