CREATE PROCEDURE sp_generate_otp
    @username VARCHAR(25)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @otp INT;

    -- Mengecek apakah username ada di database
    SELECT @count = COUNT(*)
    FROM tbl_accounts
    WHERE username = @username;

    IF @count = 1
    BEGIN
        -- Generate OTP baru
        SET @otp = FLOOR(RAND() * 1000000);

        -- Update OTP di tabel accounts dengan expirednya 10 menit
        UPDATE tbl_accounts
        SET otp = @otp, is_expired = DATEADD(MINUTE, 10, GETDATE()), is_used = 0
        WHERE username = @username;

        -- Menampilkan OTP baru
        SELECT 'Your OTP is: ' + CAST(@otp AS VARCHAR(6)) AS message;
    END
    ELSE
    BEGIN
        SELECT 'Account not Registered!' AS message;
    END
END;

-- Contoh pemanggilan untuk generate OTP
EXEC sp_generate_otp 'johnDoe';
