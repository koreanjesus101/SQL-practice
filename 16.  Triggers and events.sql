-- Triggers and events 

Select *
From employee_demographics;

Select *
from employee_salary;

Delimiter $$
Create Trigger employee_insert
	After insert on employee_salary 
    For each row 
Begin 
	Insert into employee_demographics (employee_id, first_name, last_name)
    Values (New.employee_id, new.first_name, new.last_name);
End $$
Delimiter ; 


insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
Values (13, 'Sean', 'Lee', 'Database Analyst', 85000, NULL);



-- Events 
Select *
from employee_demographics;

Delimiter $$
Create Event delete_retirees
On schedule Every 30 Second
Do 
Begin
	Delete 
	from employee_demographics
    where age >= 60;
End $$
Delimiter ; 
















