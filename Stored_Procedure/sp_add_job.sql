CREATE PROCEDURE sp_add_ajob 
	@id VARCHAR(10),
	@title VARCHAR(35),
	@min_salary INT,
	@max_salary INT
AS
BEGIN
	INSERT INTO tbl_jobs(id, title, min_salary, max_salary) VALUES
	(@id, @title, @min_salary, @max_salary)
END


-- eksekusi stored procedure
BEGIN TRANSACTION;
EXEC sp_add_ajob @id = 'J005', @title = 'Ops', @min_salary = 6000000, @max_salary = 11000000

SELECT * FROM vw_job_page

--jika diperlukan
ROLLBACK

