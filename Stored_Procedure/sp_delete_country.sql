CREATE PROCEDURE sp_delete_country
	@id CHAR(3)
AS
BEGIN
	DELETE FROM tbl_countries
	WHERE id = @id 
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_country @id = 'SGP'

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK

