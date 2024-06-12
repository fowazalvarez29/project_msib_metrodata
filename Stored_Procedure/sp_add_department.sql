CREATE OR ALTER PROCEDURE sp_add_department
	@id INT,
	@department_name VARCHAR(30),
	@location_id INT
AS
BEGIN
--pengecekan location id apakah ada di tbl_locations
	IF NOT EXISTS(SELECT 1
				  FROM tbl_locations
				  WHERE id = @location_id)
	BEGIN
		PRINT 'Location ID not found!'
		RETURN;
	END
--melakukan insert data jika location id ditemukan
	INSERT INTO tbl_departments(id, department_name, location_id)
	VALUES (@id, @department_name, @location_id)

	PRINT 'Data with ID ' + CAST(@id AS VARCHAR) + ' has been successfully added.'
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_add_department @id = 3, @department_name = 'Finance', @location_id = 1

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK