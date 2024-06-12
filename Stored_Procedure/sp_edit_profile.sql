USE Employee_Management_System
GO

IF OBJECT_ID('sp_edit_profile ', 'P') IS NOT NULL
DROP PROC sp_edit_profile ;
GO

CREATE PROCEDURE sp_edit_profile 
    @employee_id INT,
    @new_first_name VARCHAR(25),
    @new_last_name VARCHAR(25),
    @new_gender VARCHAR(10),
    @new_email VARCHAR(255),
    @new_phone VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @gender_valid INT;
    DECLARE @email_valid BIT;
    DECLARE @phone_valid INT;

    SET @gender_valid = dbo.func_gender(@new_gender);
    IF @gender_valid <> 1
    BEGIN
        PRINT ('Gender input should "Male" or "Female"');
        RETURN;
    END
    
    SET @email_valid = dbo.func_email_format(@new_email);
    IF @email_valid <> 1
    BEGIN
        PRINT ('Email should in the correct format!');
        RETURN;
    END

    SET @phone_valid = dbo.func_phone_number(@new_phone);
    IF @phone_valid <> 1
    BEGIN
        PRINT('Phone number cannot contain text');
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM tbl_employees WHERE id = @employee_id)
    BEGIN
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM tbl_employees WHERE email = @new_email AND id <> @employee_id)
    BEGIN
        RETURN;
    END

    UPDATE tbl_employees
    SET 
        first_name = @new_first_name,
        last_name = @new_last_name,
        gender = @new_gender,
        email = @new_email,
        phone = @new_phone
    WHERE id = @employee_id;

   
    IF NOT EXISTS (SELECT 1 FROM tbl_accounts WHERE employee_id = @employee_id)
    BEGIN
        RETURN;
    END

    UPDATE tbl_accounts
    SET 
        username = @new_first_name + LEFT(@new_last_name, 1),
        is_used = 1
    WHERE employee_id = @employee_id;

END;
GO

DECLARE @employee_id INT = 2; 
DECLARE @new_first_name VARCHAR(25) = 'Josh';
DECLARE @new_last_name VARCHAR(25) = 'Smith'; 
DECLARE @new_gender VARCHAR(10) = 'Male'; 
DECLARE @new_email VARCHAR(25) = 'josh.smith@example.com';
DECLARE @new_phone VARCHAR(20) = '444897';



-- Pemanggilan SP
EXEC sp_edit_profile
    @employee_id,
    @new_first_name,
    @new_last_name,
    @new_gender,
    @new_email,
    @new_phone;


SELECT * FROM tbl_employees;
SELECT * FROM tbl_accounts;
