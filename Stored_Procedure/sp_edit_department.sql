CREATE PROCEDURE sp_edit_department
	@id INT,
	@department_name VARCHAR(30),
	@location_id INT
AS
BEGIN
	UPDATE tbl_departments
	SET department_name = @department_name, location_id = @location_id
	WHERE id = @id
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_edit_department @id = 3, @department_name = 'Human Resource', @location_id = 1

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK