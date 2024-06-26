IF OBJECT_ID('dbo.func_email_format') IS NOT NULL 
    DROP FUNCTION dbo.func_email_format;
GO

CREATE FUNCTION dbo.func_email_format
(
    @email VARCHAR(255)
)
RETURNS INT
AS
BEGIN
    DECLARE @isValid INT;

    IF @email LIKE '%_@__%.__%'
        AND @email NOT LIKE '%[^a-zA-Z0-9@._-]%'
    BEGIN
        SET @isValid = 1;
    END
    ELSE
    BEGIN
        SET @isValid = 2;
    END

    RETURN @isValid;
END;
GO

-- Pengecekan Validitas Format Email
SELECT dbo.func_email_format('coba@coba.com');  -- Untuk mengecek apakah format email valid
SELECT dbo.func_email_format('coba-email');  -- Untuk mengecek apakah format email tidak valid

-- Statement SELECT
SELECT id, first_name, last_name, email, dbo.func_email_format(email) AS [Email Valid]
FROM tbl_employees;

-- Dengan WHERE
SELECT id, first_name, last_name, email
FROM tbl_employees
WHERE dbo.func_email_format(email) = 1;
