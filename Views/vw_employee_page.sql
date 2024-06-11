USE Employee_Management_System
GO

CREATE VIEW vw_employee_page AS
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
    END AS 'Manager Name'
FROM
    tbl_employees emp
LEFT JOIN
    tbl_employees mn ON emp.manager_id = mn.id
LEFT JOIN
    tbl_accounts acc ON emp.id = acc.employee_id;


-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_employee_page];


