IF OBJECT_ID('sp_register_employee') IS NOT NULL
DROP PROC sp_register_employee;
GO
CREATE PROCEDURE sp_register_employee
    @FirstName VARCHAR(25),
    @LastName VARCHAR(25),
    @Gender VARCHAR(10),
    @Email VARCHAR(255),
    @Phone VARCHAR(20),
    @HireDate DATE,
    @Salary INT,
    @ManagerId INT,
    @JobId VARCHAR(10),
    @DepartmentId INT,
    @Username VARCHAR(25),
    @Password VARCHAR(255),
    @ConfirmPassword VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EmployeeId INT;
    DECLARE @OTP INT;
    DECLARE @IsExpired DATETIME;

    -- Validasi Gender menggunakan fungsi
    IF dbo.func_gender(@Gender) = 2
    BEGIN
        SELECT 'Gender Input Should be ''Male'' or ''Female''' AS message;
        RETURN;
    END

    -- Validasi Email menggunakan fungsi
    IF dbo.func_email_format(@Email) = 2
    BEGIN
        SELECT 'Email Should be in the Correct Format!' AS message;
        RETURN;
    END

    -- Validasi Phone menggunakan fungsi
    IF dbo.func_phone_number(@Phone) = 2
    BEGIN
        SELECT 'Phone Number Cannot Contain Text!' AS message;
        RETURN;
    END

    -- Mengecek apakah email sudah terdaftar
    IF EXISTS (SELECT 1 FROM tbl_employees WHERE email = @Email)
    BEGIN
        SELECT 'Email already registered!' AS message;
        RETURN;
    END
    
    -- Mengecek apakah username sudah terdaftar
    IF EXISTS (SELECT 1 FROM tbl_accounts WHERE username = @Username)
    BEGIN
        SELECT 'Username already taken!' AS message;
        RETURN;
    END
    
    -- Mengecek apakah Manager ID ditemukan
    IF @ManagerId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @ManagerId)
    BEGIN
        SELECT 'Manager ID is not found!' AS message;
        RETURN;
    END
    
    -- Mengecek apakah Job ID ditemukan
    IF NOT EXISTS (SELECT 1 FROM tbl_jobs WHERE id = @JobId)
    BEGIN
        SELECT 'Job ID is not found!' AS message;
        RETURN;
    END

    -- Validasi Salary dalam rentang yang sesuai menggunakan fungsi
    IF dbo.func_salary(@JobId, @Salary) = 2
    BEGIN
        SELECT 'Salary cannot be higher than ' + CAST((SELECT max_salary FROM tbl_jobs WHERE id = @JobId) AS VARCHAR) + ' and lower than ' + CAST((SELECT min_salary FROM tbl_jobs WHERE id = @JobId) AS VARCHAR) + '!' AS message;
        RETURN;
    END

    -- Validasi Password dan Confirm Password menggunakan fungsi
    IF dbo.func_password_match(@Password, @ConfirmPassword) = 2
    BEGIN
        SELECT 'Password didn''t Match!' AS message;
        RETURN;
    END
	   
    -- SET 6 digit angka OTP secara random
    SET @OTP = CAST((RAND() * 900000 + 100000) AS INT);
    
    -- Set Expire selama 10 menit
    SET @IsExpired = DATEADD(MINUTE, 10, GETDATE());
    
    -- Menambahkan data karyawan baru ke tbl_employees
    INSERT INTO tbl_employees (	first_name, 
								last_name, 
								gender, 
								email, 
								phone, 
								hire_date, 
								salary, 
								manager_id, 
								job_id, 
								department_id)
    VALUES (	@FirstName, 
				@LastName, 
				@Gender, 
				@Email, 
				@Phone, 
				@HireDate, 
				@Salary, 
				@ManagerId, 
				@JobId, 
				@DepartmentId	);
    
    -- Mengambil Employee ID terbaru
    SELECT @EmployeeId = SCOPE_IDENTITY();
    
    -- Menambahkan akun baru ke tbl_accounts dengan nilai default untuk is_used dan OTP
    INSERT INTO tbl_accounts (	employee_id, 
								username, 
								password, 
								otp, 
								is_expired, 
								is_used	)
    VALUES (	@EmployeeId, 
				@Username, 
				@Password, 
				@OTP, 
				@IsExpired, 
				0);
    
    SELECT 'Employee registered successfully!' AS Message;
END;

-- Perintah untuk Register Employee Baru
EXEC sp_register_employee
    @FirstName = 'Fowaz',
    @LastName = 'Amran',
    @Gender = 'Male',
    @Email = 'fowazalvarez@amran.com',
    @Phone = '1234567890',
    @HireDate = '2024-06-14',
    @Salary = 5000000,
    @ManagerId = 1,
    @JobId = 'J001',
    @DepartmentId = 1,
    @Username = 'amranalvarez',
    @Password = 'password123',
    @ConfirmPassword = 'password123';