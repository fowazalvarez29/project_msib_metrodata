USE Employee_Management_System
GO

-- STORED PROCEDURE DELETE ROLES
CREATE PROCEDURE sp_delete_role
    @id INT,
    @role_name VARCHAR(25)
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

    DELETE FROM [dbo].[tbl_roles]
    WHERE id = @id;

	PRINT 'Role dengan ID ' + CAST(@id AS VARCHAR) + ' dan nama role ' + @role_name + ' berhasil dihapus.';
END
GO

-- Jalankan procedure
EXEC sp_delete_role @id = 5, @role_name = 'Customer Service';

SELECT * FROM tbl_roles;
