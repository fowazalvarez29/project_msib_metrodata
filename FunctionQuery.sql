-- Function Bagian F-03 func_gender

IF OBJECT_ID('dbo.func_gender') IS NOT NULL 
    DROP FUNCTION dbo.func_gender;
GO

CREATE FUNCTION dbo.func_gender
(
    @gender VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    RETURN 
    CASE 
        WHEN @gender = 'Male' OR @gender = 'Female' THEN 1 
        ELSE 2
    END;
END;
GO

SELECT dbo.func_gender('Male') AS 'Return_Gender'; 
SELECT dbo.func_gender('Female') AS 'Return_Gender'; 
SELECT dbo.func_gender('Banci') AS 'Return_Gender'; 
SELECT dbo.func_gender('Female') AS 'Return_Gender'; 

-- Pemanggilan cara lain

DECLARE @gender VARCHAR(10) = 'Banci';
DECLARE @Return_Gender INT

SET @Return_Gender = dbo.func_gender(@gender)

PRINT @Return_Gender

DECLARE @gender VARCHAR(10) = 'Female';
DECLARE @Return_Gender INT

SET @Return_Gender = dbo.func_gender(@gender)

PRINT @Return_Gender


-- Function Bagian F-04 func_phone_number

IF OBJECT_ID('dbo.func_phone_number') IS NOT NULL 
    DROP FUNCTION dbo.func_phone_number;
GO

CREATE FUNCTION dbo.func_phone_number
(
    @phone VARCHAR(20)
)
RETURNS INT
AS
BEGIN
    RETURN 
    CASE 
        WHEN @phone LIKE '%[^0-9]%' THEN 2
        ELSE 1
    END;
END;
GO


SELECT dbo.func_phone_number('082567362817') AS 'Return Phone'; 
SELECT dbo.func_phone_number('0825-6736-2817') AS 'Return Phone';
SELECT dbo.func_phone_number('0825-6736-4o5b') AS 'Return Phone';
SELECT dbo.func_phone_number('0825673654637') AS 'Return Phone'; 


-- Pemanggilan cara lain

DECLARE @phone VARCHAR(20) = '082567362817';
DECLARE @Return_Phone INT

SET @Return_Phone = dbo.func_phone_number(@phone)

PRINT @Return_Phone

DECLARE @phone VARCHAR(20) = '0825-6736-2817';
DECLARE @Return_Phone INT

SET @Return_Phone = dbo.func_phone_number(@phone)

PRINT @Return_Phone

