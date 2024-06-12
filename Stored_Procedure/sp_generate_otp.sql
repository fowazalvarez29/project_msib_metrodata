IF OBJECT_ID('sp_generate_otp') IS NOT NULL
DROP PROC sp_generate_otp;
GO
CREATE PROCEDURE sp_generate_otp
    @email VARCHAR(25)
AS
BEGIN
    DECLARE @count INT;
    DECLARE @otp INT;

    -- Mengecek apakah username ada di database
    SELECT @Count = COUNT(*)
    FROM tbl_accounts a
    JOIN tbl_employees e ON a.employee_id = e.id
    WHERE e.email = @Email;

    IF @count = 1
    BEGIN
        -- Generate OTP baru
        SET @otp = FLOOR(RAND() * 1000000);

        -- Update OTP di tabel accounts dengan expirednya 10 menit
        UPDATE a
        SET otp = @OTP, is_expired = DATEADD(MINUTE, 10, GETDATE()), is_used = 0
        FROM tbl_accounts a
        JOIN tbl_employees e ON a.employee_id = e.id
        WHERE e.email = @Email;

        -- Menampilkan OTP baru
        SELECT 'Your OTP is: ' + CAST(@otp AS VARCHAR(6)) AS message;
    END
    ELSE
    BEGIN
        SELECT 'Account not Registered!' AS message;
    END
END;

-- Contoh pemanggilan untuk generate OTP
EXEC sp_generate_otp 'john@example.com';
