CREATE OR ALTER PROCEDURE sp_delete_training
    @id VARCHAR(10)
AS
BEGIN
-- Pengecekan apakah training id ada di tbl_trainings
	IF NOT EXISTS (SELECT 1 FROM
				   tbl_trainings 
				   WHERE id = @id)
    BEGIN
        SELECT 'Training ID does not exist' AS Message
        RETURN;
    END
-- Menghapus FK beserta data sesuai FK yang masih ada di tbl_employee_trainings
	DELETE FROM tbl_employee_trainings
	WHERE training_id = @id;
-- Menghapus data training 
    DELETE FROM tbl_trainings
	WHERE id = @id;

    SELECT 'Training successfully deleted' AS Message;
END;

-- Eksekusi stored procedure
EXEC sp_delete_training @id = 'FI102'

-- tabel yang datanya akan terhapus
SELECT * FROM tbl_trainings
SELECT * FROM tbl_employee_trainings