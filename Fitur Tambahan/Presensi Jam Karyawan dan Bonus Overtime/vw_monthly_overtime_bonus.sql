IF OBJECT_ID('vw_monthly_overtime_bonus') IS NOT NULL
    DROP VIEW vw_monthly_overtime_bonus;
GO
-- Membuat View Bonus Bulanan untuk Overtime
CREATE VIEW vw_monthly_overtime_bonus AS
SELECT 
    e.id AS employee_id,
    e.first_name + ' ' + e.last_name AS name,
    YEAR(o.overtime_date) AS year,
    MONTH(o.overtime_date) AS month,
    COUNT(o.employee_id) AS total_overtime_days,
    COUNT(o.employee_id) * 100000 AS overtime_bonus
FROM 
    tbl_employees e
LEFT JOIN 
    tbl_overtime o ON e.id = o.employee_id
GROUP BY 
    e.id, e.first_name, e.last_name, YEAR(o.overtime_date), MONTH(o.overtime_date);


-- Contoh Untuk Melihat Bonus Bulanan pada Tahun dan bulan Tertentu
DECLARE @Year INT = 2024;
DECLARE @Month INT = 6;

SELECT * 
FROM vw_monthly_overtime_bonus
WHERE year = @Year AND month = @Month;
