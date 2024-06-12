CREATE OR ALTER PROCEDURE sp_edit_country
	@id CHAR(3),
	@country_name VARCHAR(40),
	@region_id INT
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
--pengecekan region id apakah ada di tbl_regions
	IF NOT EXISTS(SELECT 1
				  FROM tbl_regions
				  WHERE id = @region_id)
	BEGIN
		PRINT 'Region ID not found!'
		RETURN;
	END
--melakukan update data jika semua data yang diperlukan ditemukan
	UPDATE tbl_countries
	SET country_name = @country_name, region_id = @region_id
	WHERE id = @id

	PRINT 'Data with ID ' + @id + ' has been successfully updated.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_edit_country @id = 'SGP', @country_name = 'Singapura', @region_id = 1

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK

