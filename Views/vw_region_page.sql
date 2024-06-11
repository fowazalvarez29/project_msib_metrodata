USE Employee_Management_System
GO

-- VIEW TBL_REGION

CREATE VIEW vw_region_page AS
SELECT [id], [region_name]
FROM [dbo].[tbl_regions]
GO

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_region_page];





