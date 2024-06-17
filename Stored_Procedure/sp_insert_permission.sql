USE Employee_Management_System
GO

IF OBJECT_ID('sp_insert_permission') IS NOT NULL
DROP PROC sp_insert_permission;
GO

--STORED PROCEDURE INSERT PERMISSION
CREATE PROCEDURE sp_insert_permission
    @permission_name VARCHAR(100)
AS
BEGIN
    INSERT INTO  [dbo].[tbl_permissions] ([permissions_name])
    VALUES (@permission_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_permission @permission_name = 'Add Profile';
SELECT * FROM tbl_permissions;







