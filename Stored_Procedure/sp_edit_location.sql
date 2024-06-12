CREATE OR ALTER PROCEDURE sp_edit_location
	@id INT,
	@street_address VARCHAR(40),
	@postal_code VARCHAR(12),
	@city VARCHAR(30),
	@state_province VARCHAR(25),
	@country_id CHAR(3)
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
--pengecekan country id apakah ada di tbl_countries
	IF NOT EXISTS(SELECT 1
				  FROM tbl_countries
				  WHERE id = @country_id)
	BEGIN
		PRINT 'Country ID not found!'
		RETURN;
	END
--melakukan update data jika semua data yang diperlukan ditemukan 
	UPDATE tbl_locations
	SET street_address = @street_address, postal_code = @postal_code, city = @city, state_province = @state_province, country_id = @country_id
	WHERE id = @id

	PRINT 'Data with ID ' + CAST(@id AS VARCHAR) + ' has been successfully updated.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_edit_location @id = 2, @street_address = '92 Sudirman St', @postal_code = '92592', @city = 'Palembang', @state_province = 'Sumatera Selatan', @country_id = 'INA'

SELECT * FROM vw_location_page

--jika dibutuhkan
ROLLBACK
