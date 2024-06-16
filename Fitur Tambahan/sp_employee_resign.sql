IF OBJECT_ID('sp_employee_resign') IS NOT NULL
    DROP PROCEDURE sp_employee_resign;
GO

CREATE PROCEDURE sp_employee_resign
    @EmployeeId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check Employee Id
    IF NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @EmployeeId)
    BEGIN
        SELECT 'Employee not Registered!' AS message;
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update employee to set job_id ke 'Resign', salary ke 0, dan manager_id ke NULL
        UPDATE tbl_employees
        SET job_id = 'J000',
            salary = 0,
            manager_id = NULL
        WHERE id = @EmployeeId;

        COMMIT TRANSACTION;

        SELECT 'Employee updated to Resign status successfully!' AS message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS message;
    END CATCH
END;
GO

-- Contoh Pemanggilan (HARUS MENJALANKAN TRIGGER UPDATE TERBARU!!!)
EXEC sp_employee_resign @EmployeeId = 1;

-- Penambahan Job Resign bila belum ada (Dari sp_add_ajob)
EXEC sp_add_ajob @id = 'J000', @title = 'Resign', @min_salary = 0, @max_salary = 0