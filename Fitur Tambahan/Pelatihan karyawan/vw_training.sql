USE Employee_Management_System
GO

CREATE VIEW vw_training_page AS
SELECT
tr.id,
tr.training_name AS 'Training',
tr.start_date AS 'Start Training',
tr.end_date AS 'End of Training',
dp.department_name AS 'Department Name'
FROM tbl_trainings tr
LEFT JOIN
tbl_departments dp ON tr.department_id = dp.id;

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_training_page];


