-- Temporary Tables 
-- 2 ways to create

-- 1)
Create temporary table temp_table 
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

Select *
from temp_table
;

insert into temp_table
values('Alex', 'Freberg', 'Lord of the Rings: The Two towers')
;

-- 2)
Select *
from employee_salary
;

Create temporary table salary_over_50k
select *
from  employee_salary
where salary >= 50000;

select *
from salary_over_50k
;
 
















