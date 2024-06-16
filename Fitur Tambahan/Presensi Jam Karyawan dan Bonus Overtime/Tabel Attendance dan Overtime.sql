-- Membuat tabel kehadiran
CREATE TABLE tbl_attendance (
    employee_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out TIME,
    check_in_status VARCHAR(10),
    check_out_status VARCHAR(10),
    PRIMARY KEY (employee_id, check_in),
    CONSTRAINT FK_employee_attendance FOREIGN KEY (employee_id) REFERENCES tbl_employees (id)
);

-- Membuat tabel lembur
CREATE TABLE tbl_overtime (
    employee_id INT NOT NULL,
    overtime_date DATE NOT NULL,
    PRIMARY KEY (employee_id, overtime_date),
    CONSTRAINT FK_employee_overtime FOREIGN KEY (employee_id) REFERENCES tbl_employees (id)
);
