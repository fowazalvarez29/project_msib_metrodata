IF OBJECT_ID('sp_register_employee') IS NOT NULL
DROP PROC sp_register_employee;
GO
CREATE PROCEDURE sp_register_employee
    @FirstName VARCHAR(25),
    @LastName VARCHAR(25),
    @Gender VARCHAR(10),
    @Email VARCHAR(25),
    @Phone VARCHAR(20),
    @HireDate DATE,
    @Salary INT,
    @ManagerId INT,
    @JobId VARCHAR(10),
    @DepartmentId INT,
    @Username VARCHAR(25),
    @Password VARCHAR(225),
    @ConfirmPassword VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EmployeeId INT;
    DECLARE @OTP INT;
    DECLARE @IsExpired DATETIME;
    DECLARE @MinSalary INT;
    DECLARE @MaxSalary INT;

    -- Validasi Gender
    IF @Gender NOT IN ('Male', 'Female')
    BEGIN
        SELECT 'Gender Input Should be ''Male'' or ''Female''!' AS message;
        RETURN;
    END

    -- Validasi Email dengan format
    IF @Email NOT LIKE '%_@__%.__%'
    BEGIN
        SELECT 'Email Should be in the Correct Format!' AS message;
        RETURN;
    END

    -- Validasi Phone hanya angka
    IF @Phone LIKE '%[^0-9]%'
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
    ELSE
	-- Rentang gaji
    BEGIN
        SELECT @MinSalary = min_salary, @MaxSalary = max_salary FROM tbl_jobs WHERE id = @JobId;
    END

    -- Validasi Salary dalam rentang yang sesuai
    IF @Salary < @MinSalary OR @Salary > @MaxSalary
    BEGIN
        SELECT 'Salary cannot be higher than ' + CAST(@MaxSalary AS VARCHAR) + ' and lower than ' + CAST(@MinSalary AS VARCHAR) + '!' AS message;
        RETURN;
    END

	-- Validasi Password dan Confirm Password
    IF @Password != @ConfirmPassword
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
DECLARE @FirstName VARCHAR(25) = 'Fowaz';
DECLARE @LastName VARCHAR(25) = 'Amran';
DECLARE @Gender VARCHAR(10) = 'Male'; -- Male atau Female saja
DECLARE @Email VARCHAR(25) = 'fowazamran@alvarez.com'; -- Format email harus sesuai
DECLARE @Phone VARCHAR(20) = '5551010'; -- Pastikan hanya angka saja
DECLARE @HireDate DATE = '2024-06-11';
DECLARE @Salary INT = 7000000;
DECLARE @ManagerId INT = 1;
DECLARE @JobId VARCHAR(10) = 'J001';
DECLARE @DepartmentId INT = 2;
DECLARE @Username VARCHAR(25) = 'fowazalvarez';
DECLARE @Password VARCHAR(225) = 'password123';
DECLARE @ConfirmPassword VARCHAR(225) = 'password123'; -- Harus sama dengan password

-- Eksekusi Declare register
EXEC sp_register_employee
    @FirstName, 
    @LastName, 
    @Gender, 
    @Email, 
    @Phone, 
    @HireDate, 
    @Salary, 
    @ManagerId, 
    @JobId, 
    @DepartmentId, 
    @Username, 
    @Password,
    @ConfirmPassword;