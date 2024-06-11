USE Employee_Management_System
GO

-- STORED PROCEDURE DELETE ROLES
CREATE PROCEDURE sp_delete_permission
    @id INT,
    @permission_name VARCHAR(25)
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

    DELETE FROM [dbo].[tbl_permissions]
    WHERE id = @id;

	PRINT 'Permission dengan ID ' + CAST(@id AS VARCHAR) + ' dan nama permission ' + @permission_name + ' berhasil dihapus.';
END
GO

-- Jalankan procedure
EXEC sp_delete_permission @id = 27, @permission_name = 'Delete Profile';

SELECT * FROM tbl_permissions;
