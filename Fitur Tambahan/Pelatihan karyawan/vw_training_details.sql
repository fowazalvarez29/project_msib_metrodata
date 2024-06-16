USE Employee_Management_System
GO

CREATE VIEW vw_training_details AS
SELECT
tr.id AS 'ID Training',
tr.training_name AS 'Training Name',
tr.start_date AS 'Start Training',
tr.end_date AS 'End of Training',
tr.criteria AS 'Criteria in Month',
dp.department_name AS 'Department Name',
CONCAT(emp.first_name, ' ', emp.last_name) AS 'Full Name Employee',
emp.email AS 'Email',
emp.phone AS 'Phone'
FROM tbl_trainings tr
LEFT JOIN
tbl_departments dp ON tr.department_id = dp.id
LEFT JOIN
tbl_employee_trainings et ON tr.id = et.training_id
LEFT JOIN
tbl_employees emp ON et.employee_id = emp.id ;

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_training_details];