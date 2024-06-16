CREATE OR ALTER PROCEDURE sp_update_training
    @id VARCHAR(10),
    @training_name VARCHAR(50),
	@duration_inday INT,
	@criteria_inmonth INT,
    @department_id INT
AS
BEGIN
-- Pengecekan apakah training id ada di tbl_trainings
	IF NOT EXISTS (SELECT 1 FROM
				   tbl_trainings 
				   WHERE id = @id)
    BEGIN
        SELECT 'Training ID does not exist' AS Message;
        RETURN;
    END
-- Pengecekan apakah department id ada di tbl_departments
    IF NOT EXISTS (SELECT 1 FROM tbl_departments WHERE id = @department_id)
    BEGIN
        SELECT 'Department ID does not exist' AS Message;
        RETURN;
    END
-- var update durasi pelatihan, 
	DECLARE @end_date DATE;
	SET @end_date = DATEADD(day, @duration_inday, GETDATE())

    UPDATE tbl_trainings
    SET training_name = @training_name, 
        end_date = @end_date,
		criteria = @criteria_inmonth,
        department_id = @department_id
	WHERE id = @id;

    SELECT 'Training successfully updated' AS Message;
END;

-- Eksekusi stored procedure
EXEC sp_update_training @id = 'MK101', @training_name = 'Navigate Digital Marketing workplace', @duration_inday = 30, @criteria_inmonth = 0, @department_id = 2 

-- tabel yang datanya akan terupdate
SELECT * FROM tbl_trainings