-- Fungsi untuk memvalidasi status check-in
IF OBJECT_ID('fn_check_in_status') IS NOT NULL
    DROP FUNCTION fn_check_in_status;
GO

CREATE FUNCTION fn_check_in_status(@Status VARCHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT;

    IF @Status IN ('On Time', 'Late')
        SET @IsValid = 1;
    ELSE
        SET @IsValid = 0;

    RETURN @IsValid;
END;
GO