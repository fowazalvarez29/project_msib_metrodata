IF OBJECT_ID('sp_update_employee') IS NOT NULL
    DROP PROCEDURE sp_update_employee;
GO

CREATE PROCEDURE sp_update_employee
    @EmployeeId INT,
    @FirstName VARCHAR(25),
    @LastName VARCHAR(25),
    @Gender VARCHAR(10),
    @Email VARCHAR(255),
    @Phone VARCHAR(20),
    @HireDate DATE,
    @Salary INT,
    @ManagerId INT,
    @JobId VARCHAR(10),
    @DepartmentId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @MinSalary INT;
    DECLARE @MaxSalary INT;

    -- Validasi Gender
    IF dbo.func_gender(@Gender) = 2
    BEGIN
        SELECT 'Gender Input Should be ''Male'' or ''Female''' AS message;
        RETURN;
    END

    -- Validasi Email dengan format
    IF dbo.func_email_format(@Email) = 2
    BEGIN
        SELECT 'Email Should be in the Correct Format!' AS message;
        RETURN;
    END

    -- Validasi Phone hanya angka
    IF dbo.func_phone_number(@Phone) = 2
    BEGIN
        SELECT 'Phone Number Cannot Contain Text!' AS message;
        RETURN;
    END

    -- Mengecek apakah email sudah terdaftar oleh karyawan lain
    IF EXISTS (SELECT 1 FROM tbl_employees WHERE email = @Email AND id != @EmployeeId)
    BEGIN
        SELECT 'Email already registered!' AS message;
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
    BEGIN
        -- Rentang gaji
        SELECT @MinSalary = min_salary, @MaxSalary = max_salary FROM tbl_jobs WHERE id = @JobId;
    END

    -- Validasi Salary dalam rentang yang sesuai
    IF dbo.func_salary(@JobId, @Salary) = 2
    BEGIN
        SELECT 'Salary cannot be higher than ' + CAST(@MaxSalary AS VARCHAR) + ' and lower than ' + CAST(@MinSalary AS VARCHAR) + '!' AS message;
        RETURN;
    END

	-- Mengecek apakah Department ID ditemukan
    IF NOT EXISTS (SELECT 1 FROM tbl_departments WHERE id = @DepartmentId)
    BEGIN
        SELECT 'Department ID is not found!' AS message;
        RETURN;
    END

    -- Update data karyawan di tbl_employees
    UPDATE tbl_employees
    SET first_name = @FirstName,
        last_name = @LastName,
        gender = @Gender,
        email = @Email,
        phone = @Phone,
        hire_date = @HireDate,
        salary = @Salary,
        manager_id = @ManagerId,
        job_id = @JobId,
        department_id = @DepartmentId
    WHERE id = @EmployeeId;

    SELECT 'Employee data updated successfully!' AS Message;
END;
GO

-- Contoh Menjalankan UPDATE
BEGIN TRAN
EXEC sp_update_employee
    @EmployeeId = 1,
    @FirstName = 'John',
    @LastName = 'Doe',
    @Gender = 'Male',
    @Email = 'john.doe@example.com',
    @Phone = '1234567890',
    @HireDate = '2023-01-15',
    @Salary = 5000000,
    @ManagerId = 2,
    @JobId = 'J001',
    @DepartmentId = 1;

SELECT * FROM [dbo].[tbl_employees]
ROLLBACK