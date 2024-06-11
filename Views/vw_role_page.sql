-- VIEW TBL_ROLE

CREATE VIEW vw_role_page AS
SELECT [id], [role_name]
FROM [dbo].[tbl_roles]
GO

-- PEMANGGILAN VIEW
SELECT * FROM [dbo].[vw_role_page];