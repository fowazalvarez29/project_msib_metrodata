CREATE OR ALTER VIEW vw_location_page AS
SELECT l.id, street_address, postal_code, city, state_province, country_name
FROM tbl_locations l
JOIN tbl_countries c ON l.country_id = c.id 