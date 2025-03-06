-- Stored Procedures 

Select *
from employee_salary 
Where salary >= 50000
;

Delimiter $$
Create Procedure large_salaries4()
Begin
	Select *
	from employee_salary 
	Where salary >= 50000;
	Select *
	from employee_salary 
	Where salary >= 10000;
End $$
Delimiter ;
Call large_salaries4();



Delimiter $$
Create Procedure large_salaries5(p_employee_id INT)
Begin
	Select salary
	from employee_salary 
    where employee_id = p_employee_id
    ;
End $$
Delimiter ;
Call large_salaries5(1);







