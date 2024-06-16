USE Employee_Management_System
GO

IF OBJECT_ID('sp_add_training') IS NOT NULL
    DROP PROC sp_add_training;
GO

CREATE PROCEDURE sp_add_training
    @id VARCHAR(10),
    @training_name VARCHAR(50),
	@duration_inday INT,
	@criteria_inmonth INT,
    @department_id INT
AS
BEGIN
	
    IF NOT EXISTS (SELECT 1 FROM tbl_departments WHERE id = @department_id)
    BEGIN
        SELECT 'Department ID does not exist' AS Message;
        RETURN;
    END
--Start pelatihan dimulai dari pelatihan di tambahkan
	DECLARE @start_date DATE;
	DECLARE @end_date DATE;
	SET @start_date = GETDATE()
	SET @end_date = DATEADD(day, @duration_inday, @start_date)

    INSERT INTO tbl_trainings (
        id, 
        training_name, 
        start_date, 
        end_date,
		criteria,
        department_id)
    VALUES (
        @id,
        @training_name, 
        @start_date, 
        @end_date,
		@criteria_inmonth,
        @department_id);

    SELECT 'Training successfully added' AS Message;
END;
GO


-- Memanggil Procedure

EXEC sp_add_training
    @id = 'FI102',
	@training_name = 'Investment and Portfolio Management Expert',
	@duration_inday = 50,
    @criteria_inmonth = 2,
	@department_id = 1;

SELECT * FROM tbl_trainings
select * from tbl_employees;
select * from tbl_employee_trainings;

SELECT * FROM [dbo].[vw_training_details];

DELETE FROM tbl_trainings
WHERE id = 'FI103'


