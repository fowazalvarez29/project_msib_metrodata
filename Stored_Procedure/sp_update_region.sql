USE Employee_Management_System
GO

-- STORED PROCEDURE UPDATE REGION
CREATE PROCEDURE sp_update_region 
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

    UPDATE [dbo].[tbl_regions]
    SET region_name = @region_name
    WHERE id = @id;
END
GO

-- Jalankan procedure
EXEC sp_update_region @id = 4, @region_name = 'Amerika';

SELECT * FROM tbl_regions;

