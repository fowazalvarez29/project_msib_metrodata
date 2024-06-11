-- VIEW TBL_PERMISSSIONS

CREATE VIEW vw_permission_page AS
SELECT [id], [permissions_name]
FROM [dbo].[tbl_permissions]
GO

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_permission_page];