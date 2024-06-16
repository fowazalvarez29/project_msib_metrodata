IF OBJECT_ID('sp_delete_employee') IS NOT NULL
    DROP PROCEDURE sp_delete_employee;
GO

CREATE PROCEDURE sp_delete_employee
    @EmployeeId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Mengecek apakah Employee ID ditemukan
    IF NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @EmployeeId)
    BEGIN
        SELECT 'Employee not Registered!' AS message;
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Mengupdate manager_id yang mereferensikan EmployeeId yang akan dihapus
        UPDATE tbl_employees
        SET manager_id = NULL
        WHERE manager_id = @EmployeeId;

        -- Menghapus referensi dari tbl_account_roles yang terkait dengan akun
        DELETE FROM tbl_account_roles
        WHERE account_id IN (SELECT id FROM tbl_accounts WHERE employee_id = @EmployeeId);

        -- Menghapus data akun dari tbl_accounts yang terkait dengan Employee ID
        DELETE FROM tbl_accounts
        WHERE employee_id = @EmployeeId;

        -- Menghapus referensi dari tbl_job_histories yang terkait dengan Employee ID
        DELETE FROM tbl_job_histories
        WHERE employee_id = @EmployeeId;

		-- Menghapus data kehadiran dari tabel attendance yang terkait dengan Employee ID
        DELETE FROM tbl_attendance
        WHERE employee_id = @EmployeeId;

        -- Menghapus data lembur dari tabel overtime yang terkait dengan Employee ID
        DELETE FROM tbl_overtime
        WHERE employee_id = @EmployeeId;

        -- Menghapus data karyawan dari tbl_employees
        DELETE FROM tbl_employees
        WHERE id = @EmployeeId;

        COMMIT TRANSACTION;

        SELECT 'Employee data deleted successfully!' AS message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS message;
    END CATCH
END;
GO

-- Contoh
BEGIN TRAN
EXEC sp_delete_employee
    @EmployeeId = 1;
ROLLBACK