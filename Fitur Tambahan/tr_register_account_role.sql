IF OBJECT_ID('tr_register_account_role', 'TR') IS NOT NULL
    DROP TRIGGER tr_register_account_role;
GO

CREATE TRIGGER tr_register_account_role
ON tbl_accounts
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Menambahkan role 'employee' (role_id = 4) untuk akun baru
    INSERT INTO tbl_account_roles (account_id, role_id)
    SELECT id, 4
    FROM inserted;
END;
GO