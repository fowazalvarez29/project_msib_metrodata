CREATE PROCEDURE sp_add_department
	@id INT,
	@department_name VARCHAR(30),
	@location_id INT
AS
BEGIN
	INSERT INTO tbl_departments(id, department_name, location_id)
	VALUES (@id, @department_name, @location_id)
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_add_department @id = 3, @department_name = 'Finance', @location_id = 1

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK