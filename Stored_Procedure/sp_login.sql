IF OBJECT_ID('sp_login') IS NOT NULL
DROP PROC sp_login;
GO
CREATE PROCEDURE sp_login
    @username VARCHAR(25),
    @password VARCHAR(255)
AS
BEGIN
    DECLARE @count INT;

    -- Mengecek apakah username dan password cocok
    SELECT @count = COUNT(*)
    FROM tbl_accounts
    WHERE username = @username AND password = @password;

    IF @count = 1
    BEGIN
        SELECT 'Login success!' AS message;
    END
    ELSE
    BEGIN
        SELECT 'Account not Registered!' AS message;
    END
END;

-- Contoh pemanggilan untuk login
EXEC sp_login 'johnDoe', 'JoHn_D01e';
EXEC sp_login 'johnDoe', '1234asd';
