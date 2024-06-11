USE Employee_Management_System
GO

--STORED PROCEDURE UPDATE PERMISSION
CREATE PROCEDURE sp_update_permission
    @id INT,
    @permission_name VARCHAR(100)
AS
BEGIN
   
    DECLARE @count INT;
   
    SELECT @count = COUNT(*) 
    FROM [dbo].[tbl_permissions] 
    WHERE id = @id;

    IF @count = 0
    BEGIN
        PRINT ('Permission ID not found');
        RETURN;
    END

    UPDATE [dbo].[tbl_permissions]
    SET permissions_name = @permission_name
    WHERE id = @id;
END
GO


-- Jalankan procedure
EXEC sp_update_permission @id = 27, @permission_name = 'Delete Profile';

SELECT * FROM tbl_permissions;