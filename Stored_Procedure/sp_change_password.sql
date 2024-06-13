CREATE OR ALTER PROCEDURE sp_change_password
	@email VARCHAR(25),
	@old_pass VARCHAR(255),
	@new_pass VARCHAR(255)
AS
BEGIN
-- Pengecekan apakah new_pass sesuai dengan ketentuan func_password_policy
	IF(SELECT dbo.func_password_policy(@new_pass)) = 2
	BEGIN
		PRINT 'Password must contain at least 8 characters and include A-Z,a-z,$-#,0-9'
		RETURN;
	END
-- Pengecekan apakah @email dan @old_pass sesuai dengan data email di tbl_employees dan password di tbl_accounts
	IF NOT EXISTS(SELECT email, password
				  FROM tbl_employees e
				  INNER JOIN tbl_accounts a
				  ON e.id = a.employee_id
				  WHERE e.email = @email AND a.password = @old_pass)
	BEGIN
		PRINT 'Account not found or Password is wrong'
		RETURN;
	END
-- melakukan update data jika semua data dan policy sudah sesuai
	UPDATE tbl_accounts
	SET password = @new_pass
	FROM tbl_employees e
	INNER JOIN tbl_accounts a
	ON e.id = a.employee_id
	WHERE e.email = @email

	PRINT 'Password has been successfully changed!'
END

-- TEST SP 

-- data awal
SELECT email, password
FROM tbl_employees e
INNER JOIN tbl_accounts a
ON e.id = a.employee_id


BEGIN TRANSACTION;
ROLLBACK;

-- jika password tidak sesuai policy
EXEC sp_change_password @email = 'john@example.com', @old_pass = 'JoHn_D01e', @new_pass = '1234165'

-- Jika password sesuai dan data sesuai
EXEC sp_change_password @email = 'john@example.com', @old_pass = 'JoHn_D01e', @new_pass = 'Abcd1234$'

-- Jika password sesuai policy, namun data tidak sesuai
EXEC sp_change_password @email = 'john@example.com', @old_pass = 'JoHn_pass', @new_pass = 'Abcd1234$'

