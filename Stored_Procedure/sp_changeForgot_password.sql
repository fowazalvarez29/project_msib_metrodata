IF OBJECT_ID('sp_changeForgot_password') IS NOT NULL
DROP PROC sp_changeForgot_password;
GO
CREATE PROCEDURE sp_changeForgot_password
    @Email VARCHAR(255),
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
    DECLARE @password_strength INT;

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
        SELECT 'Password didn''t Match!' AS message;
        RETURN;
    END

    -- Mengecek kekuatan password
    SET @password_strength = dbo.func_password_policy(@NewPassword);
    IF @password_strength = 2
    BEGIN
        SELECT 'Password must contain at least 8 characters, including an uppercase letter, a number, and a special character.' AS message;
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
GO

-- Contoh Password dan OTP yang sesuai (!!!JALANKAN DULU sp_generate_otp dan copykan OTP nya!!!)
EXEC sp_generate_otp 'john@example.com';
BEGIN TRAN
EXEC sp_changeForgot_password
    @Email = 'john@example.com',
    @NewPassword = 'NewPassword123!',
    @ConfirmPassword = 'NewPassword123!',
    @OTP = 779215;
ROLLBACK

-- Cara Exec lainnya URUTAN DECLARENYA (Email, NewPassword, ComfirmPasword, OTP)
EXEC sp_changeForgot_password 'john@example.com','NewPassword123!','NewPassword123!','312475';