IF OBJECT_ID('sp_update_attendance') IS NOT NULL
    DROP PROCEDURE sp_update_attendance;
GO

CREATE PROCEDURE sp_update_attendance
    @EmployeeId INT,
    @CheckIn DATETIME,
    @NewCheckOut TIME = NULL,
    @NewCheckInStatus VARCHAR(10) = NULL,
    @NewCheckOutStatus VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Memperbarui data kehadiran pada tabel attendance dengan pengkondisian status
        UPDATE tbl_attendance
        SET 
            check_out = CASE WHEN @NewCheckOut IS NOT NULL THEN @NewCheckOut ELSE check_out END,
            check_in_status = CASE WHEN @NewCheckInStatus IS NOT NULL THEN @NewCheckInStatus ELSE check_in_status END,
            check_out_status = CASE WHEN @NewCheckOutStatus IS NOT NULL THEN @NewCheckOutStatus ELSE check_out_status END
        WHERE employee_id = @EmployeeId AND check_in = @CheckIn;

        COMMIT TRANSACTION;

        SELECT 'Attendance record updated successfully!' AS message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS message;
    END CATCH
END;
GO


-- Contoh Pengupdetan Data
BEGIN TRAN
EXEC sp_update_attendance
	@EmployeeId = 2,
    @CheckIn = '2024-06-17 09:00',
    @NewCheckOut = '2024-06-17 20:00',
    @NewCheckOutStatus = 'Overtime';

SELECT * FROM [dbo].[tbl_attendance]
SELECT * FROM [dbo].[tbl_overtime]
ROLLBACK