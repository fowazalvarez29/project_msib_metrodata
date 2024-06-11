USE Employee_Management_System
GO


CREATE VIEW vw_employee_details AS
SELECT
    emp.id,
    acc.username AS 'Username',
    CONCAT(emp.first_name, ' ', emp.last_name) AS 'Full Name',
    emp.gender AS 'Gender',
    emp.email AS 'Email',
    emp.hire_date AS 'Hire Date',
    emp.salary AS 'Salary',
    emp.manager_id AS 'ID Manager',
    CASE 
        WHEN mn.id IS NULL THEN NULL
        ELSE CONCAT(mn.first_name, ' ', mn.last_name)
    END AS 'Manager Name',
    jb.title AS 'Job Name',
    d.department_name AS 'Department Name',
    COALESCE(
	(SELECT TOP 1 r.role_name 
       FROM tbl_account_roles ar 
       JOIN tbl_roles r ON ar.role_id = r.id 
       WHERE ar.account_id = acc.id
       ORDER BY 
        CASE 
            WHEN r.role_name = 'Super Admin' THEN 1
            WHEN r.role_name = 'Admin' THEN 2
            WHEN r.role_name = 'Manager' THEN 3
            ELSE 4
            END), 'Employee') AS 'Role',
    l.city AS 'City',
    jh.status AS 'Status'
FROM
    tbl_employees emp
	LEFT JOIN
	tbl_employees mn ON emp.manager_id = mn.id
	LEFT JOIN
    tbl_accounts acc ON emp.id = acc.employee_id
	LEFT JOIN
    tbl_jobs jb ON emp.job_id = jb.id
	LEFT JOIN
    tbl_departments d ON emp.department_id = d.id
	LEFT JOIN
    tbl_locations l ON d.location_id = l.id
	OUTER APPLY
		(SELECT TOP 1 
		   status 
		   FROM tbl_job_histories 
		   WHERE tbl_job_histories.employee_id = emp.id 
		   ORDER BY end_date DESC) jh;

-- PEMANGGILAN VIEW

SELECT * FROM [dbo].[vw_employee_details];

