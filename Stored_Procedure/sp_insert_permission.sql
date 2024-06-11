USE Employee_Management_System
GO

--STORED PROCEDURE INSERT PERMISSION
CREATE PROCEDURE sp_insert_permission
    @id INT,
    @permission_name VARCHAR(100)
AS
BEGIN
    INSERT INTO  [dbo].[tbl_permissions] ([id], [permissions_name])
    VALUES (@id, @permission_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_permission @id = 27, @permission_name = 'Add Profile';

SELECT * FROM tbl_permissions;







