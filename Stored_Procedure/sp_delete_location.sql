CREATE PROCEDURE sp_delete_location
	@id INT
AS
BEGIN
	DELETE FROM tbl_locations
	WHERE id = @id
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_location @id = 2

SELECT * FROM vw_location_page

--jika dibutuhkan
ROLLBACK