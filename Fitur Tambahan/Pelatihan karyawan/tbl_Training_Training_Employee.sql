CREATE TABLE tbl_trainings (
	id VARCHAR(10) PRIMARY KEY NOT NULL,
	training_name VARCHAR(50) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	criteria INT NOT NULL,
	department_id INT NOT NULL,
	FOREIGN KEY (department_id) REFERENCES tbl_departments (id)
);

CREATE TABLE tbl_employee_trainings (
	id INT identity(1,1) PRIMARY KEY NOT NULL,
	employee_id INT NOT NULL,
	training_id VARCHAR(10) NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES tbl_employees (id),
	FOREIGN KEY (training_id) REFERENCES tbl_trainings (id)
);



DROP TABLE tbl_trainings


SELECT * FROM tbl_employees

SELECT DATEDIFF(MONTH, hire_date, GETDATE())
FROM tbl_employees
WHERE DATEDIFF(MONTH, hire_date, GETDATE()) >= 30 AND DATEDIFF(MONTH, hire_date, GETDATE()) <=35

