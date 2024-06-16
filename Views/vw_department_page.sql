CREATE OR ALTER VIEW vw_department_page AS
SELECT d.id, department_name, city
FROM tbl_departments d
JOIN tbl_locations l ON d.location_id = l.id