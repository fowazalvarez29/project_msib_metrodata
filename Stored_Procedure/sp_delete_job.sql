CREATE OR ALTER PROCEDURE sp_delete_ajob
	@id VARCHAR(10)
AS
BEGIN
--pengecekan job id apakah ada di tbl_jobs
	IF NOT EXISTS(SELECT 1
				  FROM tbl_jobs
				  WHERE id = @id)
	BEGIN
		PRINT 'Job ID not found!.'
		RETURN;
	END
--melakukan delete data jika id ditemukan di tbl_jobs
	DELETE FROM tbl_jobs
	WHERE id = @id

	PRINT 'Data with ID ' + @id + ' has been successfully deleted.'
END


-- eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_delete_ajob @id = 'J003'

SELECT * FROM vw_job_page

--jika diperlukan
ROLLBACK