CREATE PROCEDURE sp_add_country
	@id CHAR(3),
	@country_name VARCHAR(40),
	@region_id INT
AS
BEGIN
	INSERT INTO tbl_countries(id, country_name, region_id)
	VALUES(@id, @country_name, @region_id)
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_add_country @id = 'SGP', @country_name = 'singapura', @region_id = 1

SELECT * FROM vw_country_page

--jika diperlukan
ROLLBACK