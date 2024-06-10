CREATE PROCEDURE sp_edit_ajob
	@id VARCHAR(10),
	@title VARCHAR(35),
	@min_salary INT,
	@max_salary INT
AS
BEGIN
	UPDATE tbl_jobs
	SET title = @title, min_salary = @min_salary, max_salary = @max_salary
	WHERE id = @id
END


--eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_edit_ajob @id = 'J004', @title = 'DevOps', @min_salary = 7000000, @max_salary = 12500000

SELECT * FROM vw_job_page

--jika diperlukan
ROLLBACK