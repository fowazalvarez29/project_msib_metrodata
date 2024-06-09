CREATE PROCEDURE sp_delete_department
	@id INT
AS
BEGIN
	DELETE FROM tbl_departments
	WHERE id = @id
END


--eksekusi Stored Procedure
BEGIN TRANSACTION;
EXEC sp_delete_department @id = 3

SELECT * FROM vw_department_page

--Jika diperlukan
ROLLBACK