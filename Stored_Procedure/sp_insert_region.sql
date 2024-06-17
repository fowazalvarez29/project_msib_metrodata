USE Employee_Management_System
GO

IF OBJECT_ID('sp_insert_region') IS NOT NULL
DROP PROC sp_insert_region;
GO

--STORED PROCEDURE INSERT REGION
CREATE PROCEDURE sp_insert_region 
    @region_name VARCHAR(25)
AS
BEGIN
    INSERT INTO [dbo].[tbl_regions] ([region_name])
    VALUES (@region_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_region @region_name = 'Eropa';

SELECT * FROM tbl_regions;






