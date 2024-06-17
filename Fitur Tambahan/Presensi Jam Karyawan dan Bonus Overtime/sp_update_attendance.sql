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

	-- Mengecek apakah Employee ID ditemukan
    IF NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @EmployeeId)
    BEGIN
        SELECT 'Employee not Registered!' AS message;
        RETURN;
    END

    -- Mengecek apakah CheckIn ditemukan untuk EmployeeId
    IF NOT EXISTS (SELECT 1 FROM tbl_attendance WHERE employee_id = @EmployeeId AND check_in = @CheckIn)
    BEGIN
        SELECT 'Attendance record not found!' AS message;
        RETURN;
    END

    -- Memvalidasi status check-in dan check-out
    IF @NewCheckInStatus IS NOT NULL AND dbo.fn_check_in_status(@NewCheckInStatus) = 0
    BEGIN
        SELECT 'Invalid CheckIn Status!' AS message;
        RETURN;
    END

    IF @NewCheckOutStatus IS NOT NULL AND dbo.fn_check_out_status(@NewCheckOutStatus) = 0
    BEGIN
        SELECT 'Invalid CheckOut Status!' AS message;
        RETURN;
    END

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