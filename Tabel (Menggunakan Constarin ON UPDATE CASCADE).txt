-- CREATE DATABASE Employee_Management_System;

-- USE Employee_Management_System;

CREATE TABLE tbl_jobs (
    id VARCHAR (10) PRIMARY KEY NOT NULL,
    title VARCHAR (35) NOT NULL,
    min_salary INT NULL,
    max_salary INT NULL
);

CREATE TABLE tbl_permissions (
    id INT PRIMARY KEY NOT NULL,
    name_permission VARCHAR (100) NOT NULL
);

CREATE TABLE tbl_roles (
    id INT PRIMARY KEY NOT NULL,
    name_role VARCHAR (50) NOT NULL
);

CREATE TABLE tbl_regions (
    id INT PRIMARY KEY NOT NULL,
    name_region VARCHAR (25) NOT NULL
);

CREATE TABLE tbl_role_permissions (
    id INT PRIMARY KEY NOT NULL,
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES tbl_roles (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES tbl_permissions (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_countries (
    id CHAR (3) PRIMARY KEY NOT NULL,
    name_country VARCHAR (40) NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES tbl_regions (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_locations (
    id INT PRIMARY KEY NOT NULL,
    street_address VARCHAR (40),
    postal_code VARCHAR (12),
    city VARCHAR (30) NOT NULL,
    state_province VARCHAR (25),
    country_id CHAR (3) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES tbl_countries (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_departments (
    id INT PRIMARY KEY NOT NULL,
    name_department VARCHAR (30) NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES tbl_locations (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_employees (
    id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR (25) NOT NULL,
    last_name VARCHAR (25),
    gender VARCHAR (10) NOT NULL,
    email VARCHAR (25) UNIQUE NOT NULL,
    phone VARCHAR (20),
    hire_date DATE NOT NULL,
    salary INT,
    manager_id INT,
    job_id VARCHAR (10) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES tbl_employees (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (job_id) REFERENCES tbl_jobs (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES tbl_departments (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_accounts (
    id INT PRIMARY KEY NOT NULL,
    employee_id INT NOT NULL,
    username VARCHAR (25),
    password VARCHAR (225) NOT NULL,
    otp INT NOT NULL,
    is_expired DATETIME NOT NULL,
    is_used BIT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES tbl_employees (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_account_roles (
    id INT PRIMARY KEY NOT NULL,
    account_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (account_id) REFERENCES tbl_accounts (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES tbl_roles (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_job_histories (
    employee_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR (10),
    job_id VARCHAR (10) NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (employee_id, start_date),
    FOREIGN KEY (employee_id) REFERENCES tbl_employees (id),
    FOREIGN KEY (job_id) REFERENCES tbl_jobs (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES tbl_departments (id) ON UPDATE CASCADE ON DELETE CASCADE
);
