USE healthcare_db;

-- =======================================================
--  BASIC ANALYTICS
-- =======================================================

-- 1. Total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 2. Total number of doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

-- 3. Total appointments per department
SELECT department, COUNT(*) AS total_appointments
FROM appointments
GROUP BY department
ORDER BY total_appointments DESC;

-- 4. Total revenue generated
SELECT SUM(bill_amount) AS total_revenue
FROM billing;

-- 5. Most common diagnosis (Top 5)
SELECT diagnosis_description, COUNT(*) AS frequency
FROM diagnosis
GROUP BY diagnosis_description
ORDER BY frequency DESC
LIMIT 5;

-- =======================================================
--  INTERMEDIATE ANALYTICS
-- =======================================================

-- 6. Doctor with most appointments
SELECT d.doctor_id, d.first_name, d.last_name, COUNT(a.appointment_id) AS total_cases
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY a.doctor_id
ORDER BY total_cases DESC
LIMIT 1;

-- 7. Monthly revenue trend
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(bill_amount) AS monthly_revenue
FROM billing
GROUP BY month
ORDER BY month;

-- 8. Average treatment cost by treatment type
SELECT treatment_type, AVG(treatment_cost) AS avg_cost
FROM treatments
GROUP BY treatment_type;

-- 9. Count of severe diagnosis cases
SELECT COUNT(*) AS severe_cases
FROM diagnosis
WHERE severity = 'Severe';

-- 10. Most frequently visited doctor per department
SELECT 
    department,
    doctor_id,
    COUNT(*) AS visits
FROM appointments
GROUP BY department, doctor_id
ORDER BY department, visits DESC;

-- =======================================================
--  ADVANCED ANALYTICS (JOINS, WINDOW FUNCTIONS)
-- =======================================================

-- 11. Patient total spending
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    SUM(b.bill_amount) AS total_spent
FROM billing b
JOIN patients p ON b.patient_id = p.patient_id
GROUP BY p.patient_id
ORDER BY total_spent DESC;

-- 12. Rank doctors by revenue generated from their appointments
SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    SUM(b.bill_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.bill_amount) DESC) AS revenue_rank
FROM appointments a
JOIN billing b ON a.appointment_id = b.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id;

-- 13. Top 3 most expensive treatments
SELECT *
FROM treatments
ORDER BY treatment_cost DESC
LIMIT 3;

-- 14. Most common diagnosis per severity level
SELECT severity, diagnosis_description, COUNT(*) AS freq
FROM diagnosis
GROUP BY severity, diagnosis_description
ORDER BY severity, freq DESC;

-- 15. Number of appointments handled per doctor per month
SELECT 
    a.doctor_id,
    DATE_FORMAT(a.appointment_date, '%Y-%m') AS month,
    COUNT(*) AS total_cases
FROM appointments a
GROUP BY a.doctor_id, month
ORDER BY month, total_cases DESC;

-- =======================================================
--  COMPLEX BUSINESS QUERIES
-- =======================================================

-- 16. Department-wise revenue
SELECT 
    a.department,
    SUM(b.bill_amount) AS department_revenue
FROM billing b
JOIN appointments a ON b.appointment_id = a.appointment_id
GROUP BY a.department
ORDER BY department_revenue DESC;

-- 17. Identify high-risk patients (3+ severe diagnoses)
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(*) AS severe_count
FROM diagnosis d
JOIN patients p ON d.patient_id = p.patient_id
WHERE d.severity = 'Severe'
GROUP BY p.patient_id
HAVING severe_count >= 3
ORDER BY severe_count DESC;

-- 18. Readmission Rate (patients with 2+ appointments)
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS visits
FROM appointments a
JOIN patients p ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING visits >= 2
ORDER BY visits DESC;

-- 19. Doctor load by specialization
SELECT 
    d.specialization,
    COUNT(a.appointment_id) AS total_cases
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_cases DESC;

-- 20. Percentage of severe vs non-severe diagnosis
SELECT 
    severity,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM diagnosis), 2) AS percentage
FROM diagnosis
GROUP BY severity;

-- =======================================================
--  ADVANCED INSIGHTS
-- =======================================================

-- 21. Highest billing patient per month
WITH monthly_billing AS (
    SELECT 
        patient_id,
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(bill_amount) AS total_monthly_bill
    FROM billing
    GROUP BY patient_id, month
)
SELECT *
FROM (
    SELECT 
        patient_id,
        month,
        total_monthly_bill,
        RANK() OVER (PARTITION BY month ORDER BY total_monthly_bill DESC) AS rnk
    FROM monthly_billing
) ranked
WHERE rnk = 1;

-- 22. Treatment type generating highest revenue
SELECT 
    treatment_type,
    SUM(treatment_cost) AS total_revenue
FROM treatments
GROUP BY treatment_type
ORDER BY total_revenue DESC;

-- 23. Most expensive patient case (appointment-level)
SELECT 
    b.appointment_id,
    b.patient_id,
    b.bill_amount
FROM billing b
ORDER BY b.bill_amount DESC
LIMIT 1;

-- 24. Doctors with zero appointments (if any)
SELECT d.doctor_id, d.first_name, d.last_name
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.doctor_id IS NULL;

-- 25. Average age of patients per city
SELECT city, AVG(age) AS avg_age
FROM patients
GROUP BY city
ORDER BY avg_age DESC;

-- 26. Top 5 highest-earning specializations
SELECT 
    d.specialization,
    SUM(b.bill_amount) AS total_income
FROM billing b
JOIN appointments a ON a.appointment_id = b.appointment_id
JOIN doctors d ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY total_income DESC
LIMIT 5;

-- =======================================================
-- END OF ANALYTICS FILE
-- =======================================================
