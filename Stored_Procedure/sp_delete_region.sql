USE Employee_Management_System
GO

-- STORED PROCEDURE DELETE REGION
CREATE PROCEDURE sp_delete_region 
    @id INT,
    @region_name VARCHAR(25)
AS
BEGIN

	DECLARE @count INT;
   
    SELECT @count = COUNT(*) 
    FROM [dbo].[tbl_regions]
    WHERE id = @id;

    IF @count = 0
    BEGIN
        PRINT ('Region ID not found');
        RETURN;
    END

    DELETE FROM [dbo].[tbl_regions]
    WHERE id = @id;

	PRINT 'Region dengan ID ' + CAST(@id AS VARCHAR) + ' dan nama ' + @region_name + ' berhasil dihapus.';
END
GO

-- Jalankan procedure
EXEC sp_delete_region @id = 4, @region_name = 'Amerika';

SELECT * FROM tbl_regions;