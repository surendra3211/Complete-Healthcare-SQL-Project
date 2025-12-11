USE healthcare_db;

LOAD DATA LOCAL INFILE 'data/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(patient_id, first_name, last_name, gender, age, city, phone);

LOAD DATA LOCAL INFILE 'data/doctors.csv'
INTO TABLE doctors
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(doctor_id, first_name, last_name, specialization, experience_years, city);

LOAD DATA LOCAL INFILE 'data/appointments.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(appointment_id, patient_id, doctor_id, appointment_date, department, visit_type, status);

LOAD DATA LOCAL INFILE 'data/diagnosis.csv'
INTO TABLE diagnosis
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(diagnosis_id, appointment_id, patient_id, diagnosis_code, diagnosis_description, severity);

LOAD DATA LOCAL INFILE 'data/treatments.csv'
INTO TABLE treatments
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(treatment_id, appointment_id, patient_id, treatment_type,
 medicine_prescribed, treatment_cost);

LOAD DATA LOCAL INFILE 'data/billing.csv'
INTO TABLE billing
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(billing_id, appointment_id, patient_id, treatment_id,
 bill_amount, payment_status, payment_date);

