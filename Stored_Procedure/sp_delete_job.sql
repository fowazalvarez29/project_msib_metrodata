CREATE PROCEDURE sp_delete_ajob
	@id VARCHAR(10)
AS
BEGIN
	DELETE FROM tbl_jobs
	WHERE id = @id
END


-- eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_ajob @id = 'J004'

SELECT * FROM vw_job_page

--jika diperlukan
ROLLBACK