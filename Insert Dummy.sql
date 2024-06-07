-- USE Employee_Management_System;

-- tbl_jobs
INSERT INTO tbl_jobs (id, title, min_salary, max_salary) VALUES
('J001', 'Software Engineer', 5000000, 10000000),
('J002', 'Data Analyst', 4000000, 8000000);

-- tbl_permissions
INSERT INTO tbl_permissions (id, name_permission) VALUES
(1, 'Add Employee'),
(2, 'Edit Employee'),
(3, 'Delete Employee'),
(4, 'Detail Employee'),
(5, 'Add Job'),
(6, 'Edit Job'),
(7, 'Delete Job'),
(8, 'Add Department'),
(9, 'Edit Department'),
(10, 'Delete Department'),
(11, 'Add Location'),
(12, 'Edit Location'),
(13, 'Delete Location'),
(14, 'Add Country'),
(15, 'Edit Country'),
(16, 'Delete Country'),
(17, 'Add Region'),
(18, 'Edit Region'),
(19, 'Delete Region'),
(20, 'Add Role'),
(21, 'Edit Role'),
(22, 'Delete Role'),
(23, 'Add Permission'),
(24, 'Edit Permission'),
(25, 'Delete Permission'),
(26, 'Edit Profile');

-- tbl_roles
INSERT INTO tbl_roles (id, name_role) VALUES
(1, 'Super Admin'),
(2, 'Admin'),
(3, 'Manager'),
(4, 'Employee');

-- tbl_regions
INSERT INTO tbl_regions (id, name_region) VALUES
(1, 'Jakarta'),
(2, 'Bandung'),
(3, 'Yogyakarta');

-- tbl_role_permissions
INSERT INTO tbl_role_permissions (id, role_id, permission_id) VALUES
(1, 1, 1);

-- tbl_countries
INSERT INTO tbl_countries (id, name_country, region_id) VALUES
('INA', 'Indonesia', 1);

-- tbl_locations
INSERT INTO tbl_locations (id, street_address, postal_code, city, state_province, country_id) VALUES
(1, '123 Main St', '12345', 'Jakarta', 'Jakarta Selatan', 'INA');

-- tbl_departments
INSERT INTO tbl_departments (id, name_department, location_id) VALUES
(1, 'Human Resources Department', 1),
(2, 'Marketing', 1);

INSERT INTO tbl_employees (id, first_name, last_name, gender, email, phone, hire_date, salary, manager_id, job_id, department_id) VALUES
(1, 'John', 'Doe', 'Male', 'john@example.com', '555-1234', '2021-01-01', 60000, NULL, 'J001', 1),
(2, 'Jane', 'Smith', 'Female', 'jane@example.com', '555-5678', '2021-02-01', 65000, 1, 'J001', 1),
(3, 'Robert', 'Brown', 'Male', 'robert@example.com', '555-8765', '2021-03-01', 55000, 1, 'J002', 2),
(4, 'Emily', 'Davis', 'Female', 'emily@example.com', '555-4321', '2021-04-01', 50000, 1, 'J002', 2),
(5, 'Michael', 'Johnson', 'Male', 'michael@example.com', '555-6789', '2021-05-01', 70000, 2, 'J001', 1),
(6, 'Sarah', 'Williams', 'Female', 'sarah@example.com', '555-1239', '2021-06-01', 62000, 2, 'J002', 2),
(7, 'David', 'Jones', 'Male', 'david@example.com', '555-9876', '2021-07-01', 64000, 3, 'J001', 1),
(8, 'Laura', 'Wilson', 'Female', 'laura@example.com', '555-6543', '2021-08-01', 68000, 3, 'J002', 2),
(9, 'James', 'Taylor', 'Male', 'james@example.com', '555-3210', '2021-09-01', 66000, 4, 'J001', 1),
(10, 'Olivia', 'Martinez', 'Female', 'olivia@example.com', '555-7890', '2021-10-01', 63000, 4, 'J002', 2),
(11, 'Kevin', 'Miller', 'Male', 'kevin@example.com', '555-1111', '2021-11-01', 62000, 5, 'J001', 1),
(12, 'Lisa', 'Garcia', 'Female', 'lisa@example.com', '555-2222', '2021-12-01', 63000, 5, 'J002', 2),
(13, 'Brian', 'Rodriguez', 'Male', 'brian@example.com', '555-3333', '2022-01-01', 61000, 6, 'J001', 1),
(14, 'Karen', 'Martinez', 'Female', 'karen@example.com', '555-4444', '2022-02-01', 64000, 6, 'J002', 2),
(15, 'Edward', 'Hernandez', 'Male', 'edward@example.com', '555-5555', '2022-03-01', 67000, 7, 'J001', 1),
(16, 'Susan', 'Lopez', 'Female', 'susan@example.com', '555-6666', '2022-04-01', 69000, 7, 'J002', 2),
(17, 'Charles', 'Gonzales', 'Male', 'charles@example.com', '555-7777', '2022-05-01', 71000, 8, 'J001', 1),
(18, 'Nancy', 'Wilson', 'Female', 'nancy@example.com', '555-8888', '2022-06-01', 73000, 8, 'J002', 2),
(19, 'Paul', 'Anderson', 'Male', 'paul@example.com', '555-9999', '2022-07-01', 65000, 9, 'J001', 1),
(20, 'Jessica', 'Thomas', 'Female', 'jessica@example.com', '555-1010', '2022-08-01', 66000, 9, 'J002', 2);

-- tbl_accounts
INSERT INTO tbl_accounts (id,employee_id, username, password, otp, is_expired, is_used) VALUES
(1,1, 'johnDoe', 'JoHn_D01e', 340893, '2024-05-20 10:30:00.000', 1),
(2,2, 'MarkDrew', 'MaRk_DrEw', 127912, '2024-05-24 12:30:00.000', 0),
(3, 3, 'RobertB', 'RoBeRt@789', 876543, '2024-06-01 14:00:00.000', 0),
(4, 4, 'EmilyD', 'EmiLyD@1234', 987654, '2024-06-02 16:00:00.000', 0),
(5, 5, 'MichaelJ', 'MiChAeL_5678!', 567890, '2024-06-03 18:00:00.000', 0),
(6, 6, 'SarahW', 'SaRaHw#123!', 678901, '2024-06-04 20:00:00.000', 0),
(7, 7, 'DavidJ', 'DaVidJ@890!', 789012, '2024-06-05 22:00:00.000', 0),
(8, 8, 'LauraW', 'LaUraW#0123!', 890123, '2024-06-06 09:00:00.000', 0),
(9, 9, 'JamesT', 'JaMeST@345!', 901234, '2024-06-07 11:00:00.000', 0),
(10, 10, 'OliviaM', 'OLiViaM#5678!', 123456, '2024-06-08 13:00:00.000', 0);

-- tbl_account_roles
INSERT INTO tbl_account_roles (id, account_id, role_id) VALUES
(1, 1, 1),
(2, 2, 2);

-- tbl_job_histories
INSERT INTO tbl_job_histories (employee_id, start_date, end_date, status, job_id, department_id) VALUES
(1, '2021-01-01', '2022-01-01', 'Active', 'J001', 1),
(2, '2021-02-01', '2022-02-01', 'Active', 'J001', 2);
