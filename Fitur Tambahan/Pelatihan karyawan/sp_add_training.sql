USE Employee_Management_System
GO

IF OBJECT_ID('sp_add_training') IS NOT NULL
    DROP PROC sp_add_training;
GO

CREATE PROCEDURE sp_add_training
    @id VARCHAR(10),
    @training_name VARCHAR(50),
    @start_date DATETIME,
    @end_date DATETIME,
    @department_id INT,
    @employee_id INT
AS
BEGIN
  
    IF NOT EXISTS (SELECT 1 FROM tbl_departments WHERE id = @department_id)
    BEGIN
        SELECT 'Department ID does not exist' AS Message;
        RETURN;
    END

   
    INSERT INTO tbl_trainings (
        id, 
        training_name, 
        start_date, 
        end_date, 
        department_id)
    VALUES (
        @id,
        @training_name, 
        @start_date, 
        @end_date, 
        @department_id);


    INSERT INTO tbl_employee_trainings (
        employee_id,
        training_id)
    VALUES (
        @employee_id,
        @id);


    SELECT 'Training and employee training details successfully added' AS Message;
END;
GO


-- Memanggil Procedure
EXEC sp_add_training
    @id = 'TR003',
	@training_name = 'Full Stack Developer',
    @start_date = '2025-06-15 07:00:00.000',
    @end_date = '2025-09-15 23:59:00.000',
    @department_id = 3,
	@employee_id = 21;



SELECT * FROM tbl_trainings
select * from tbl_employees;
select * from tbl_employee_trainings;

SELECT * FROM [dbo].[vw_training_details];