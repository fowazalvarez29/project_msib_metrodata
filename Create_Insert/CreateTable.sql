CREATE DATABASE Employee_Management_System;

USE Employee_Management_System;


CREATE TABLE tbl_jobs (
    id VARCHAR (10) PRIMARY KEY NOT NULL,
    title VARCHAR (35) NOT NULL,
    min_salary INT NULL,
    max_salary INT NULL
);

CREATE TABLE tbl_permissions (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    permissions_name VARCHAR (100) NOT NULL
);

CREATE TABLE tbl_roles (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    role_name VARCHAR (50) NOT NULL
);

CREATE TABLE tbl_regions (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    region_name VARCHAR (25) NOT NULL
);

CREATE TABLE tbl_role_permissions (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES tbl_roles (id),
    FOREIGN KEY (permission_id) REFERENCES tbl_permissions (id)
);

CREATE TABLE tbl_countries (
    id CHAR (3) PRIMARY KEY NOT NULL,
    country_name VARCHAR (40) NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES tbl_regions (id) 
);

CREATE TABLE tbl_locations (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    street_address VARCHAR (40),
    postal_code VARCHAR (12),
    city VARCHAR (30) NOT NULL,
    state_province VARCHAR (25),
    country_id CHAR (3) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES tbl_countries (id) 
);

CREATE TABLE tbl_departments (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    department_name VARCHAR (30) NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES tbl_locations (id) 
);

CREATE TABLE tbl_employees (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
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
    FOREIGN KEY (manager_id) REFERENCES tbl_employees (id),
    FOREIGN KEY (job_id) REFERENCES tbl_jobs (id),
    FOREIGN KEY (department_id) REFERENCES tbl_departments (id) 
);

CREATE TABLE tbl_accounts (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    employee_id INT NOT NULL,
    username VARCHAR (25) UNIQUE ,
    password VARCHAR (225) NOT NULL,
    otp INT NOT NULL,
    is_expired DATETIME NOT NULL,
    is_used BIT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES tbl_employees (id) 
);

CREATE TABLE tbl_account_roles (
    id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    account_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (account_id) REFERENCES tbl_accounts (id),
    FOREIGN KEY (role_id) REFERENCES tbl_roles (id)
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
    FOREIGN KEY (job_id) REFERENCES tbl_jobs (id),
    FOREIGN KEY (department_id) REFERENCES tbl_departments (id)
);




