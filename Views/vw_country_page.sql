CREATE OR ALTER VIEW vw_country_page AS
SELECT c.id, country_name, region_name
FROM tbl_countries c
JOIN tbl_regions r ON c.region_id = r.id
