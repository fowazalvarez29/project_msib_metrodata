CREATE OR ALTER PROCEDURE sp_add_country
	@id CHAR(3),
	@country_name VARCHAR(40),
	@region_id INT
AS
BEGIN
--pengecekan region id apakah ada di tbl_regions
	IF NOT EXISTS(SELECT 1
				  FROM tbl_regions
				  WHERE id = @region_id)
	BEGIN
		PRINT 'Region ID not found!'
		RETURN;
	END
--melakukan insert data jika semua data yang diperlukan ditemukan
	INSERT INTO tbl_countries(id, country_name, region_id)
	VALUES(@id, @country_name, @region_id)

	PRINT 'Data with ID ' + @id + ' has been successfully added.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_add_country @id = 'MYS', @country_name = 'Malaysia', @region_id = 5

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK
