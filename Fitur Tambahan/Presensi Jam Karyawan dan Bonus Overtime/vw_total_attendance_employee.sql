USE Employee_Management_System
GO

IF OBJECT_ID('vw_total_attendance_employee') IS NOT NULL
    DROP VIEW vw_total_attendance_employee;
GO

CREATE VIEW vw_total_attendance_employee
AS
    SELECT 
        employee_id,
        COUNT(*) AS 'Total Attendance Employee',
        SUM(CASE WHEN check_in_status = 'Late' THEN 1 ELSE 0 END) AS 'Total Late',
        SUM(CASE WHEN check_in_status = 'On Time' THEN 1 ELSE 0 END) AS 'Total On Time',
        SUM(CASE WHEN check_out_status = 'Regular' THEN 1 ELSE 0 END) AS 'Total Regular',
        SUM(CASE WHEN check_out_status = 'Left Early' THEN 1 ELSE 0 END) AS 'Total Left Early',
        SUM(CASE WHEN check_out_status = 'Overtime' THEN 1 ELSE 0 END) AS 'Total Overtime'
    FROM 
        tbl_attendance
    GROUP BY 
        employee_id;
GO

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_total_attendance_employee];
