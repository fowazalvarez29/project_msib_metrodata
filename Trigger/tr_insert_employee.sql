CREATE TRIGGER tr_insert_employee
ON tbl_employees
AFTER INSERT
AS
BEGIN
    BEGIN
        INSERT INTO tbl_job_histories 
		(
		employee_id,
		start_date,
		end_date,
		status,
		job_id,
		department_id
		)
        SELECT 
            i.id,
            GETDATE(),
            NULL,
            'Active',
            i.job_id,
            i.department_id
        FROM inserted i;
	END
END;



BEGIN TRANSACTION;

--test function (data contoh)
INSERT INTO tbl_employees (id, first_name, last_name, gender, email, phone, hire_date, salary, manager_id, job_id, department_id) VALUES
(23, 'Joni', 'Cage', 'Male', 'joncag11@example.com', '555-1251', '2021-11-01', 7000000, NULL, 'J002', 2);

ROLLBACK

-- Cek data yang ke trigger
SELECT * FROM tbl_job_histories
ORDER BY start_date asc;


UPDATE tbl_employees
SET job_id = 'J003' -- Ubah antara J001/J00X
WHERE id = 21;


DELETE FROM tbl_employees WHERE id = 22
DELETE FROM tbl_employees WHERE id = 22

UPDATE tbl_job_histories
SET status = 'Hand Over' 
WHERE job_id = 'J001';



