USE Employee_Management_System
GO

IF OBJECT_ID('sp_insert_role') IS NOT NULL
DROP PROC sp_insert_role;
GO

-- STORED PROCEDURE INSERT ROLE
CREATE PROCEDURE sp_insert_role 
    @role_name VARCHAR(50)
AS
BEGIN
    INSERT INTO [dbo].[tbl_roles] ([role_name])
    VALUES (@role_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_role @role_name  = 'CS';

SELECT * FROM tbl_roles;



