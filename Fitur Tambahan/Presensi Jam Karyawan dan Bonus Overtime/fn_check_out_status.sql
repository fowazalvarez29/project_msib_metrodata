-- Fungsi untuk memvalidasi status check-out
IF OBJECT_ID('fn_check_out_status') IS NOT NULL
    DROP FUNCTION fn_check_out_status;
GO

CREATE FUNCTION fn_check_out_status(@Status VARCHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT;

    IF @Status IN ('Left Early', 'Regular', 'Overtime')
        SET @IsValid = 1;
    ELSE
        SET @IsValid = 0;

    RETURN @IsValid;
END;
GO