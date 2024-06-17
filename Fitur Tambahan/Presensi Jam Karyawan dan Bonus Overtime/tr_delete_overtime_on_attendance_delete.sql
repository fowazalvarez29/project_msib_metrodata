IF OBJECT_ID('tr_delete_overtime_on_attendance_delete') IS NOT NULL
    DROP TRIGGER tr_delete_overtime_on_attendance_delete;
GO
-- Trigger untuk menghapus data overtime ketida data attendance dihapus
CREATE TRIGGER tr_delete_overtime_on_attendance_delete
ON tbl_attendance
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM tbl_overtime
    WHERE employee_id IN (SELECT employee_id FROM DELETED)
      AND overtime_date IN (SELECT CONVERT(DATE, check_in) FROM DELETED);
END;
GO
