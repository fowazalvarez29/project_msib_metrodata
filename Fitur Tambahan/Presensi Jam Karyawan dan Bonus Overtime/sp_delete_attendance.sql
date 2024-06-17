IF OBJECT_ID('sp_delete_attendance') IS NOT NULL
    DROP PROCEDURE sp_delete_attendance;
GO

CREATE PROCEDURE sp_delete_attendance
    @EmployeeId INT,
    @CheckIn DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Menghapus data kehadiran dari tabel attendance
        DELETE FROM tbl_attendance
        WHERE employee_id = @EmployeeId AND check_in = @CheckIn;

        COMMIT TRANSACTION;

        SELECT 'Attendance record deleted successfully!' AS message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS message;
    END CATCH
END;
GO


-- Contoh Penghapusan Data
BEGIN TRAN
EXEC sp_delete_attendance @EmployeeId = 2, @CheckIn = '2024-06-17 09:00';
SELECT * FROM [dbo].[tbl_attendance]
SELECT * FROM [dbo].[tbl_overtime]
ROLLBACK