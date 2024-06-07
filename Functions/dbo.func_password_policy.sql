IF OBJECT_ID('dbo.func_password_policy') IS NOT NULL 
    DROP FUNCTION dbo.func_password_policy;
GO

CREATE FUNCTION dbo.func_password_policy
(
    @password VARCHAR(255)
)
RETURNS INT
AS
BEGIN
    DECLARE @isValid INT;
    SET @isValid = 1;

    -- Panjang Pass
    IF LEN(@password) < 8
    BEGIN
        SET @isValid = 2;
    END

    -- Huruf Kapital
    IF @password NOT LIKE '%[A-Z]%'
    BEGIN
        SET @isValid = 2;
    END

    -- Huruf Kecil
    IF @password NOT LIKE '%[a-z]%'
    BEGIN
        SET @isValid = 2;
    END

    -- Angka
    IF @password NOT LIKE '%[0-9]%'
    BEGIN
        SET @isValid = 2;
    END

    -- Special karakter 
     IF @password NOT LIKE '%[^a-zA-Z0-9]%'
    BEGIN
        RETURN 2;
    END

    RETURN @isValid;
END;
GO


-- Mengecek Validitas Password
SELECT dbo.func_password_policy('Password123!') AS [PASS VALID];  -- Password Valid
SELECT dbo.func_password_policy('pass') AS [PASS INVALID];  -- Password Tidak Valid

-- Statement SELECT sederhana
SELECT id, password, dbo.func_password_policy(password) AS password_validity
FROM tbl_accounts;

-- JOIN Menggunakan Tabel Employee dan Accounts
SELECT tbl_employees.id, tbl_accounts.password, tbl_accounts.username, tbl_employees.first_name, tbl_employees.last_name, dbo.func_password_policy(password) AS password_validity
FROM   tbl_accounts INNER JOIN
             tbl_employees ON tbl_accounts.employee_id = tbl_employees.id
GROUP BY tbl_employees.id, tbl_accounts.password, tbl_accounts.username, tbl_employees.first_name, tbl_employees.last_name

