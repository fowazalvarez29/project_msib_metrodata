USE Employee_Management_System
GO

IF OBJECT_ID('sp_total_attendance_employee') IS NOT NULL
    DROP PROCEDURE sp_total_attendance_employee;
GO

CREATE PROCEDURE sp_total_attendance_employee
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        employee_id,
        COUNT(*) AS 'Total Attendance Employee',
        SUM(CASE WHEN check_in_status = 'Late' THEN 1 ELSE 0 END) AS 'Total Late',
        SUM(CASE WHEN check_in_status = 'On Time' THEN 1 ELSE 0 END) AS 'Total On Time',
		SUM(CASE WHEN check_out_status = 'Regular' THEN 1 ELSE 0 END) AS 'Regular',
        SUM(CASE WHEN check_out_status = 'Left Early' THEN 1 ELSE 0 END) AS 'Total Left Early',
        SUM(CASE WHEN check_out_status = 'Overtime' THEN 1 ELSE 0 END) AS 'Total Overtime'
    FROM 
        tbl_attendance
    GROUP BY 
        employee_id;
END;
GO

-- Memanggil SP
EXEC [dbo].[sp_total_attendance_employee];
