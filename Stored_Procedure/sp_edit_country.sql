CREATE PROCEDURE sp_edit_country
	@id CHAR(3),
	@country_name VARCHAR(40),
	@region_id INT
AS
BEGIN
	UPDATE tbl_countries
	SET country_name = @country_name, region_id = @region_id
	WHERE id = @id
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_edit_country @id = 'SGP', @country_name = 'Singapura', @region_id = 1

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK

