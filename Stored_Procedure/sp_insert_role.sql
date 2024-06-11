USE Employee_Management_System;

-- STORED PROCEDURE INSERT ROLE
CREATE PROCEDURE sp_insert_role 
    @id INT,
    @role_name VARCHAR(50)
AS
BEGIN
    INSERT INTO [dbo].[tbl_roles] ([id],[role_name])
    VALUES (@id, @role_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_role @id = 5, @role_name  = 'CS';

SELECT * FROM tbl_roles;



