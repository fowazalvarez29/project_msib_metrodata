CREATE TRIGGER tr_update_employee_job
ON tbl_employees
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(job_id)
    BEGIN
        -- Status Job Histories "Hand Over" atau Resign
        INSERT INTO tbl_job_histories (employee_id, start_date, end_date, status, job_id, department_id)
        SELECT 
            i.id,
            GETDATE(),
            NULL, -- end_date (isi sesuai kebutuhan, Default NULL)
            CASE 
                WHEN i.job_id = 'J000' THEN 'Resign' 
                ELSE 'Hand Over' 
            END,
            i.job_id,
            i.department_id
        FROM inserted i
        INNER JOIN deleted d
            ON i.id = d.id
        WHERE i.job_id <> d.job_id;
    END
END;
GO
