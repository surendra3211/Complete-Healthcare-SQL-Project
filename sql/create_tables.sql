-- =======================================================
--   HEALTHCARE SQL PROJECT - TABLE CREATION SCRIPT
--   DATABASE: healthcare_db
-- =======================================================

-- Create database (run only once)
CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

-- =======================================================
-- 1. PATIENTS TABLE
-- =======================================================

DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    age INT,
    city VARCHAR(50),
    phone VARCHAR(15)
);

-- =======================================================
-- 2. DOCTORS TABLE
-- =======================================================

DROP TABLE IF EXISTS doctors;

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(50),
    experience_years INT,
    city VARCHAR(50)
);

-- =======================================================
-- 3. APPOINTMENTS TABLE
-- =======================================================

DROP TABLE IF EXISTS appointments;

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    department VARCHAR(50),
    visit_type VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- =======================================================
-- 4. DIAGNOSIS TABLE
-- =======================================================

DROP TABLE IF EXISTS diagnosis;

CREATE TABLE diagnosis (
    diagnosis_id INT PRIMARY KEY,
    appointment_id INT,
    patient_id INT,
    diagnosis_code VARCHAR(10),
    diagnosis_description VARCHAR(255),
    severity VARCHAR(20),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- =======================================================
-- 5. TREATMENTS TABLE
-- =======================================================

DROP TABLE IF EXISTS treatments;

CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    appointment_id INT,
    patient_id INT,
    treatment_type VARCHAR(50),
    medicine_prescribed VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- =======================================================
-- 6. BILLING TABLE
-- =======================================================

DROP TABLE IF EXISTS billing;

CREATE TABLE billing (
    billing_id INT PRIMARY KEY,
    appointment_id INT,
    patient_id INT,
    treatment_id INT,
    bill_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- =======================================================
-- ALL TABLES CREATED SUCCESSFULLY
-- =======================================================
