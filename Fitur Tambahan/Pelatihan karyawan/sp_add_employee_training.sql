CREATE OR ALTER PROCEDURE sp_add_employee_training
    @training_id VARCHAR(10)
AS
BEGIN
    DECLARE @training_department INT;
	DECLARE @training_criteria INT;

    -- mengambil department_id dan criteria dari tbl_trainings
    SELECT  @training_department = department_id,
			@training_criteria = criteria
    FROM tbl_trainings
    WHERE id = @training_id;

    -- Insert employee yang memenuhi syarat langsung ke tbl_employee_trainings
    INSERT INTO tbl_employee_trainings (employee_id, training_id)
    SELECT e.id, @training_id
    FROM tbl_employees e
	-- Pengecekan apakah employee di department yang sama dengan training
    WHERE e.department_id = @training_department
	-- Pengecekan apakah employee dapat mengikuti training sesuai criteria training
	-- criteria merupakan lama waktu(bulan) employee bekerja di perusahaan
    AND DATEDIFF(MONTH, e.hire_date, GETDATE()) >= @training_criteria
    -- Pengecekan apakah employee sudah enrolled training
	AND NOT EXISTS (
        SELECT 1
        FROM tbl_employee_trainings et
        WHERE et.employee_id = e.id
        AND et.training_id = @training_id
    );
    PRINT CAST(@@ROWCOUNT AS VARCHAR) + ' Employees have been enrolled in the training.';
END;

-- Eksekusi sp
EXEC sp_add_employee_training @training_id = 'FI102'

-- tabel yang datanya akan ditambahkan
SELECT * FROM tbl_employee_trainings



