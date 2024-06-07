--Fungsi untuk validasi input salary
CREATE OR ALTER FUNCTION func_salary(@job_id VARCHAR(10), @salary INT)
RETURNS INT
AS
BEGIN
	DECLARE @min_salary INT;
	DECLARE @max_salary INT;
	DECLARE @return INT;

	--pengisian var min/max salary agar value min/max salary menyesuaikan table jobs
	SELECT @min_salary = min_salary, @max_salary = max_salary
	FROM tbl_jobs
	WHERE id = @job_id;

	--logic fungsi
	IF @salary < @min_salary OR @salary > @max_salary
	BEGIN
		SET @return = 2
	END
	ELSE
	BEGIN
		SET @return = 1
	END

	RETURN @return;
END;


--Test function (id,salary)
--J001 min: 5000000 max 10000000
--J002 min: 4000000 max 8000000
SELECT dbo.func_salary ('J001',10000000) AS salary_input; 