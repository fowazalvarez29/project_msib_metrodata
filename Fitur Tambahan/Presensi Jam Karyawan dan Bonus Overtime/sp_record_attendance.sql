IF OBJECT_ID('sp_add_attendance') IS NOT NULL
    DROP PROCEDURE sp_add_attendance;
GO

CREATE PROCEDURE sp_add_attendance
    @EmployeeId INT,
    @CheckIn DATETIME,
    @CheckOut TIME
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CheckInStatus VARCHAR(10);
    DECLARE @CheckOutStatus VARCHAR(10);
    DECLARE @CheckOutDateTime DATETIME;

    -- Menghitung status kehadiran berdasarkan waktu check-in
    IF CAST(@CheckIn AS TIME) > '09:00'
        SET @CheckInStatus = 'Late';
    ELSE
        SET @CheckInStatus = 'On Time';

    -- Menghitung status kepulangan berdasarkan waktu check-out
    SET @CheckOutDateTime = CAST(CAST(@CheckIn AS DATE) AS DATETIME) + CAST(@CheckOut AS DATETIME);

    IF CAST(@CheckOut AS TIME) >= '19:00'
        SET @CheckOutStatus = 'Overtime';
    ELSE IF CAST(@CheckOut AS TIME) < '17:00'
        SET @CheckOutStatus = 'Left Early';
    ELSE
        SET @CheckOutStatus = 'Regular';

    -- Menambahkan data ke tabel attendance (kehadiran)
    INSERT INTO tbl_attendance (	employee_id, 
									check_in, 
									check_out, 
									check_in_status, 
									check_out_status)
    VALUES (	@EmployeeId, 
				@CheckIn, 
				@CheckOut, 
				@CheckInStatus, 
				@CheckOutStatus);

    -- Jika status kepulangan adalah 'Overtime', tambahkan data ke tabel overtime
    --IF @CheckOutStatus = 'Overtime'
    --BEGIN
    --    INSERT INTO tbl_overtime (	employee_id, 
				--					overtime_date)
    --    VALUES (@EmployeeId, CAST(@CheckIn AS DATE));
    --END
END;
GO

-- Contoh memasukkan data (HARUS MEMASUKKAN TANGGAL YANG BERBEDA UNTUK SETIAP EMPLOYEE ID)
EXEC sp_record_attendance @EmployeeId = 1, @CheckIn = '2024-06-13 08:45', @CheckOut = '17:15';
EXEC sp_record_attendance @EmployeeId = 1, @CheckIn = '2024-06-14 09:05', @CheckOut = '19:30';
EXEC sp_record_attendance @EmployeeId = 2, @CheckIn = '2024-06-14 08:55', @CheckOut = '16:45';
EXEC sp_record_attendance @EmployeeId = 2, @CheckIn = '2024-06-15 09:00', @CheckOut = '17:00';
EXEC sp_record_attendance @EmployeeId = 2, @CheckIn = '2024-06-16 09:00', @CheckOut = '20:00';
EXEC sp_record_attendance @EmployeeId = 2, @CheckIn = '2024-06-17 09:00', @CheckOut = '20:00';

TRUNCATE TABLE [dbo].[tbl_attendance]
TRUNCATE TABLE [dbo].[tbl_overtime]