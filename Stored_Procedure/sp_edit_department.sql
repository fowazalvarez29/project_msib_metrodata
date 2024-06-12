CREATE OR ALTER PROCEDURE sp_edit_department
	@id INT,
	@department_name VARCHAR(30),
	@location_id INT
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
--pengecekan location id apakah ada di tbl_locations
	IF NOT EXISTS(SELECT 1
				  FROM tbl_locations
				  WHERE id = @location_id)
	BEGIN
		PRINT 'Location ID not found!'
		RETURN;
	END
--melakukan update data jika semua data yang diperlukan ditemukan 
	UPDATE tbl_departments
	SET department_name = @department_name, location_id = @location_id
	WHERE id = @id

	PRINT 'Data with ID' + CAST(@id AS VARCHAR) + ' has been successfully updated.'
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_edit_department @id = 2, @department_name = 'Human Resource', @location_id = 10

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK