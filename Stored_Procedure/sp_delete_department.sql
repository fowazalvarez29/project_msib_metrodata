CREATE OR ALTER PROCEDURE sp_delete_department
	@id INT
AS
BEGIN
--pengecekan department id apakah ada di tbl_departments
	IF NOT EXISTS(SELECT 1
				  FROM tbl_departments
				  WHERE id = @id)
	BEGIN
		PRINT 'Department ID not found!'
		RETURN;
	END
--melakukan delete data jika id ditemukan di tbl_departments
	DELETE FROM tbl_departments
	WHERE id = @id

	PRINT 'Data with ID' + CAST(@id AS VARCHAR) + ' has been successfully deleted.'
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_delete_department @id = 3

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK