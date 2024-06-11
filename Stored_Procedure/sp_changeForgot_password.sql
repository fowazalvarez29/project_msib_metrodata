CREATE PROCEDURE sp_changeForgot_password
    @Email VARCHAR(25),
    @NewPassword VARCHAR(255),
    @ConfirmPassword VARCHAR(255),
    @OTP INT
AS
BEGIN
    DECLARE @username VARCHAR(25);
    DECLARE @stored_otp INT;
    DECLARE @otp_expiry DATETIME;
    DECLARE @otp_used BIT;
    DECLARE @current_datetime DATETIME = GETDATE();

    -- Mengecek apakah email ada di database
    IF NOT EXISTS (SELECT 1 
                   FROM tbl_employees e
                   JOIN tbl_accounts a ON e.id = a.employee_id
                   WHERE e.email = @Email)
    BEGIN
        SELECT 'Account not Registered!' AS message;
        RETURN;
    END

    -- Mendapatkan detail akun berdasarkan email (JOIN employee dan Account)
    SELECT TOP 1 
        @username = a.username,
        @stored_otp = a.otp,
        @otp_expiry = a.is_expired,
        @otp_used = a.is_used
    FROM tbl_employees e
    JOIN tbl_accounts a ON e.id = a.employee_id
    WHERE e.email = @Email;

    -- Mengecek apakah password dan confirm password cocok
    IF @NewPassword != @ConfirmPassword
    BEGIN
        SELECT 'Password not match!' AS message;
        RETURN;
    END

    -- Mengecek apakah OTP valid
    IF @OTP != @stored_otp
    BEGIN
        SELECT 'OTP is incorrect!' AS message;
        RETURN;
    END

    -- Mengecek apakah OTP telah digunakan
    IF @otp_used = 1
    BEGIN
        SELECT 'OTP already used!' AS message;
        RETURN;
    END

    -- Mengecek apakah OTP telah expired
    IF @current_datetime > @otp_expiry
    BEGIN
        SELECT 'OTP expired!' AS message;
        RETURN;
    END

    -- Update password baru dan tandai OTP sebagai digunakan (0 belum & 1 sudah)
    UPDATE tbl_accounts
    SET password = @NewPassword, is_used = 1
    WHERE username = @username;

    SELECT 'Password has been changed successfully!' AS message;
END;

-- Contoh akun email yang tidak terdaftar
EXEC sp_changeForgot_password 'nonexistent@example.com', 'newPassword123', 'newPassword123', 123456;

-- Contoh password yang tidak cocok
EXEC sp_changeForgot_password 'john@example.com', 'newPassword123', 'differentPassword123', 123456;

-- Contoh OTP yang tidak valid
EXEC sp_changeForgot_password 'john@example.com', 'newPassword123', 'newPassword123', 654321;

-- Contoh OTP yang telah digunakan (Cek tabel account)
EXEC sp_changeForgot_password 'john@example.com', 'newPassword123', 'newPassword123', 123456;

-- Contoh OTP yang diberikan telah expired (Cek tabel account dan pastikan sudah expired)
EXEC sp_changeForgot_password 'john@example.com', 'newPassword123', 'newPassword123', 281184;

-- Contoh Password dan OTP yang sesuai (!!!JALANKAN DULU sp_generate_otp dan copykan OTP nya!!!)
EXEC sp_changeForgot_password 'john@example.com', 'newPassword123', 'newPassword123', 577869;
