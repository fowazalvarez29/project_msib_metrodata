CREATE OR ALTER PROCEDURE sp_delete_country
	@id CHAR(3)
AS
BEGIN
--pengecekan country id apakah ada di tbl_countries
	IF NOT EXISTS(SELECT 1
				  FROM tbl_countries
				  WHERE id = @id)
	BEGIN
		PRINT 'Country ID not found!'
		RETURN;
	END
--melakukan delete data jika semua data yang diperlukan ditemukan
	DELETE FROM tbl_countries
	WHERE id = @id 

	PRINT 'Data with ID ' + @id + ' has been successfully deleted.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_country @id = 'SGP'

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK

