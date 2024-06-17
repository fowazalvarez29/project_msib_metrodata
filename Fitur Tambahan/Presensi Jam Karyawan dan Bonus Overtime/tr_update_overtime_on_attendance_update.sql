IF OBJECT_ID('tr_update_overtime_on_attendance_update') IS NOT NULL
    DROP TRIGGER tr_update_overtime_on_attendance_update;
GO

CREATE TRIGGER tr_update_overtime_on_attendance_update
ON tbl_attendance
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Hapus data overtime jika check_out_status diupdate menjadi selain 'Overtime'
    DELETE FROM tbl_overtime
    WHERE employee_id IN (
        SELECT employee_id
        FROM INSERTED
        WHERE check_out_status != 'Overtime'
    )
    AND overtime_date IN (
        SELECT CONVERT(DATE, check_in)
        FROM INSERTED
        WHERE check_out_status != 'Overtime'
    );

    -- Tambahkan data overtime jika check_out_status diupdate menjadi 'Overtime'
    INSERT INTO tbl_overtime (employee_id, overtime_date)
    SELECT employee_id, CONVERT(DATE, check_in)
    FROM INSERTED
    WHERE check_out_status = 'Overtime'
    AND NOT EXISTS (
        SELECT 1
        FROM tbl_overtime
        WHERE employee_id = INSERTED.employee_id
        AND overtime_date = CONVERT(DATE, INSERTED.check_in)
    );
END;
GO
