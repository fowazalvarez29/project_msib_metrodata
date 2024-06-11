USE Employee_Management_System
GO

-- STORED PROCEDURE UPDATE ROLE
CREATE PROCEDURE sp_update_role 
    @id INT,
    @role_name VARCHAR(50)
AS
BEGIN
	
	DECLARE @count INT;
   
    SELECT @count = COUNT(*) 
    FROM [dbo].[tbl_roles]
    WHERE id = @id;

    IF @count = 0
    BEGIN
        PRINT ('Role ID not found');
        RETURN;
    END

    UPDATE [dbo].[tbl_roles]
    SET [role_name] = @role_name
    WHERE id = @id;
END
GO

-- Jalankan procedure
EXEC sp_update_role @id = 5, @role_name = 'Customer Service';

SELECT * FROM tbl_roles;