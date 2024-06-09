CREATE PROCEDURE sp_add_location
	@id INT,
	@street_address VARCHAR(40),
	@postal_code VARCHAR(12),
	@city VARCHAR(30),
	@state_province VARCHAR(25),
	@country_id CHAR(3)
AS
BEGIN
	INSERT INTO tbl_locations(id, street_address, postal_code, city, state_province, country_id)
	VALUES (@id, @street_address, @postal_code, @city, @state_province, @country_id)
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_add_location @id = 2, @street_address = '92 sudirman st', @postal_code = '62562', @city = 'Palembang', @state_province = 'Sumatera Selatan', @country_id = 'INA'

SELECT * FROM vw_location_page

--jika dibutuhkan
ROLLBACK
