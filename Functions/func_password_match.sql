--Fungsi untuk cek apakah password yang baru di masukkan sesuai
CREATE OR ALTER FUNCTION func_password_match(@newpass varchar(255), @confirmpass varchar(255))
RETURNS INT
AS
BEGIN
	DECLARE @return INT;
	
	--logic password_match
	IF @newpass = @confirmpass
	BEGIN
		SET @return = 1
	END
	ELSE
	BEGIN
		SET @return = 2
	END
	
	RETURN @return
END;

--test function
SELECT dbo.func_password_match('passw','passw') AS password_match;