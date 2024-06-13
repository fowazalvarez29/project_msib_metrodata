CREATE TRIGGER tr_update_employee_job
ON tbl_employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(job_id)
    BEGIN
        INSERT INTO tbl_job_histories (employee_id, start_date, end_date, status, job_id, department_id)
        SELECT 
            i.id,
            GETDATE(),
            NULL, -- end_date (isi sesuai kebutuhan, Default NULL)
            'Hand Over',
            i.job_id,
            i.department_id
        FROM inserted i
        INNER JOIN deleted d
            ON i.id = d.id
        WHERE i.job_id <> d.job_id;
    END
END;
GO

-- Untuk men-nonaktifkan Trigger
DISABLE TRIGGER tr_update_employee_job ON tbl_employees;

-- Mengaktifkan kembali Trigger
ENABLE TRIGGER tr_update_employee_job ON tbl_employees;

-- Coba
BEGIN TRAN
UPDATE tbl_employees
SET job_id = 'J002' -- Ubah antara J001/J00X
WHERE id = 1;

SELECT *
FROM tbl_job_histories
ROLLBACK;

-- Kalau gak sengaja ke Commit
DELETE FROM tbl_job_histories
WHERE employee_id = 1 AND status = 'Hand Over';
