USE Employee_Management_System
GO

--STORED PROCEDURE INSERT REGION
CREATE PROCEDURE sp_insert_region 
    @id INT,
    @region_name VARCHAR(25)
AS
BEGIN
    INSERT INTO [dbo].[tbl_regions] ([id], [region_name])
    VALUES (@id, @region_name);
END
GO

-- Jalankan procedure
EXEC sp_insert_region @id = 5, @region_name = 'Eropa';

SELECT * FROM tbl_regions;






