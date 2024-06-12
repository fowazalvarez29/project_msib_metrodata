CREATE OR ALTER PROCEDURE sp_delete_location
	@id INT
AS
BEGIN
--pengecekan location id apakah ada di tbl_locations
	IF NOT EXISTS(SELECT 1
				  FROM tbl_locations
				  WHERE id = @id)
	BEGIN
		PRINT 'Location ID not found!'
		RETURN;
	END
--melakukan delete data jika semua data yang diperlukan ditemukan
	DELETE FROM tbl_locations
	WHERE id = @id

	PRINT 'Data with ID ' + CAST(@id AS VARCHAR) + ' has been successfully deleted.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_location @id = 2

SELECT * FROM vw_location_page

--jika dibutuhkan
ROLLBACK