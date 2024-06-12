CREATE OR ALTER PROCEDURE sp_edit_ajob
	@id VARCHAR(10),
	@title VARCHAR(35),
	@min_salary INT,
	@max_salary INT
AS
BEGIN
--pengecekan job id apakah ada di tbl_jobs
	IF NOT EXISTS(SELECT 1
				  FROM tbl_jobs
				  WHERE id = @id)
	BEGIN
		PRINT 'Job ID not found!'
		RETURN;
	END
--melakukan update data jika id ditemukan di tbl_jobs
	UPDATE tbl_jobs
	SET title = @title, min_salary = @min_salary, max_salary = @max_salary
	WHERE id = @id

	PRINT 'Data with ID ' + @id + ' has been successfully updated.'
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_edit_ajob @id = 'J004', @title = 'DevOps', @min_salary = 7000000, @max_salary = 12500000

SELECT * FROM vw_job_page

--jika diperlukan
ROLLBACK