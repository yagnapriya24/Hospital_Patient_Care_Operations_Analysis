-- Creating DataBase

CREATE DATABASE careplus_hospital;

USE careplus_hospital;

-- Table Dependency Order
/*
patients ───────┐
                ↓
            appointments
                ↓
            treatments
                ↑
doctors ────────┘
                ↑
rooms ──────────┘
*/

-- Creating Tables

-- 1. Patients

CREATE TABLE patients (
    patient_id VARCHAR(10) NOT NULL,
    patient_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    patient_type VARCHAR(20) NOT NULL,
    preferred_time_slot VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL,

    PRIMARY KEY (patient_id)
);

-- 2.Doctors

CREATE TABLE doctors (
    doctor_id VARCHAR(10) NOT NULL,
    doctor_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    employment_type VARCHAR(20) NOT NULL,
    is_active VARCHAR(5) NOT NULL,

    PRIMARY KEY (doctor_id)
);

-- 3.Rooms

CREATE TABLE rooms (
    room_id VARCHAR(10) NOT NULL,
    room_type VARCHAR(30) NOT NULL,
    floor INT NOT NULL,
    equipment_type VARCHAR(30) NOT NULL,
    capacity INT NOT NULL,
    last_maintenance_date DATE NOT NULL,
    is_available VARCHAR(5) NOT NULL,

    PRIMARY KEY (room_id)
);

-- 4.Appointments

CREATE TABLE appointments (
    appointment_id VARCHAR(10) NOT NULL,
    patient_id VARCHAR(10) NOT NULL,
    appointment_date DATE NOT NULL,
    doctor_id VARCHAR(10) NOT NULL,
    service_type VARCHAR(30) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    estimated_cost DECIMAL(10,2) NOT NULL,
    booking_channel VARCHAR(20) NOT NULL,

    PRIMARY KEY (appointment_id),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

-- 5.Treatments

CREATE TABLE treatments (
    treatment_id VARCHAR(10) NOT NULL,
    appointment_id VARCHAR(10) NOT NULL,
    doctor_id VARCHAR(10) NOT NULL,
    room_id VARCHAR(10) NOT NULL,
    actual_treatment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    treatment_attempt INT NOT NULL,
    treatment_duration_min INT NOT NULL,
    waiting_time_min INT NOT NULL,
    treatment_cost DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (treatment_id),

    FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),

    FOREIGN KEY (room_id)
        REFERENCES rooms(room_id)
);

-- Verify That ALL Data Was Imported

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_doctors
FROM doctors;

SELECT COUNT(*) AS total_rooms
FROM rooms;

SELECT COUNT(*) AS total_appointments
FROM appointments;

SELECT COUNT(*) AS total_treatments
FROM treatments;

-- Sprint 3 : Basic Analysis / Data Exploration

-- Q1: What is the total number of patients?
SELECT COUNT(*) AS total_patients
FROM patients;

-- Q2: What is the total number of appointments?
SELECT COUNT(*) AS total_appointments
FROM appointments;

-- Q3: What is the total number of treatment records?
SELECT COUNT(*) AS total_treatments
FROM treatments;

-- Q4:  What are the different medical service types?
SELECT DISTINCT service_type
FROM appointments
ORDER BY service_type;


-- Q5: How many doctors are currently active?
SELECT COUNT(*) AS active_doctors
FROM doctors
WHERE is_active = 'Yes';


-- Q6: What are the different room types?
SELECT DISTINCT room_type
FROM rooms
ORDER BY room_type;


-- Q7: What is the total estimated appointment value?
SELECT ROUND(SUM(estimated_cost), 2) AS total_estimated_appointment_value
FROM appointments;


-- Q8: What is the average treatment duration?
SELECT ROUND(AVG(treatment_duration_min), 2)
       AS average_treatment_duration_minutes
FROM treatments;

-- Sprint 4: Objective-Based Analysis
-- 4.1 Understand Patient and Appointment Demand
--  Compare appointment volume across cities.
SELECT
    p.city,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY total_appointments DESC;

SELECT
    service_type,
    COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY service_type
ORDER BY total_appointments DESC;

SELECT
    priority,
    COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY priority
ORDER BY total_appointments DESC;

-- -- Compare appointments across service types and priorities.
SELECT
    service_type,
    priority,
    COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY
    service_type,
    priority
ORDER BY
    service_type,
    total_appointments DESC;
    
-- Examine appointment volume over time.
SELECT
    DATE_FORMAT(appointment_date, '%Y-%m') AS appointment_month,
    COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY DATE_FORMAT(appointment_date, '%Y-%m')
ORDER BY appointment_month;

-- Compare estimated appointment value across patient types.
SELECT
    p.patient_type,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(a.estimated_cost), 2) AS total_estimated_value,
    ROUND(AVG(a.estimated_cost), 2) AS average_estimated_value
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type
ORDER BY total_estimated_value DESC;

-- Examine booking channels and their contribution to demand.
SELECT
    booking_channel,
    COUNT(appointment_id) AS total_appointments,
    ROUND(
        COUNT(appointment_id) * 100.0 /
        (SELECT COUNT(*) FROM appointments),
        2
    ) AS percentage_contribution
FROM appointments
GROUP BY booking_channel
ORDER BY total_appointments DESC;
 
-- 4.2 Understand Patient Appointment Behaviour

-- Which patients have the highest number of appointments?
SELECT
    p.patient_id,
    p.patient_name,
    p.city,
    p.patient_type,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.patient_name,
    p.city,
    p.patient_type
ORDER BY total_appointments DESC;

-- Compare patients by number of appointments.
SELECT
    patient_id,
    COUNT(appointment_id) AS appointment_count
FROM appointments
GROUP BY patient_id
ORDER BY appointment_count DESC;

-- Identify patients with higher cumulative estimated appointment value.
SELECT
    p.patient_id,
    p.patient_name,
    p.city,
    p.patient_type,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(a.estimated_cost), 2) AS cumulative_estimated_value
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.patient_name,
    p.city,
    p.patient_type
ORDER BY cumulative_estimated_value DESC;

-- Compare patient activity across cities.

SELECT
    p.city,
    COUNT(DISTINCT p.patient_id) AS active_patients,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY total_appointments DESC;

-- Compare General, Corporate, and Insurance patients.

SELECT
    p.patient_type,
    COUNT(DISTINCT p.patient_id) AS total_patients,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type
ORDER BY total_appointments DESC;

-- Examine patient booking patterns over time.

SELECT
    DATE_FORMAT(appointment_date, '%Y-%m') AS appointment_month,
    COUNT(DISTINCT patient_id) AS active_patients,
    COUNT(appointment_id) AS total_appointments
FROM appointments 
GROUP BY DATE_FORMAT(appointment_date, '%Y-%m')
ORDER BY appointment_month;

-- 4.3 Evaluate Treatment Performance
-- Compare treatment outcomes across cities.

SELECT
    p.city,
    t.status,
    COUNT(t.treatment_id) AS total_treatments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY
    p.city,
    t.status
ORDER BY
    p.city,
    total_treatments DESC;

-- Examine treatment duration and waiting time.

SELECT
    status,
    COUNT(*) AS total_treatments,
    ROUND(AVG(treatment_duration_min), 2) AS avg_treatment_duration,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments
GROUP BY status
ORDER BY avg_waiting_time DESC;

-- Compare Completed, Cancelled, No-Show, Rescheduled, and In Progress outcomes.

SELECT
    status,
    COUNT(*) AS total_treatments
FROM treatments
GROUP BY status
ORDER BY total_treatments DESC;

-- Identify areas with higher treatment activity or poorer outcomes.

SELECT
    p.city,
    COUNT(t.treatment_id) AS total_treatments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY p.city
ORDER BY total_treatments DESC;

-- Which cities have the highest rate of problematic outcomes?

SELECT
    p.city,
    t.status,
    COUNT(*) AS total
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
WHERE t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY p.city, t.status
ORDER BY total DESC;

-- Compare treatment performance over time.

SELECT
    DATE_FORMAT(actual_treatment_date, '%Y-%m') AS treatment_month,
    status,
    COUNT(treatment_id) AS total_treatments
FROM treatments
GROUP BY
    DATE_FORMAT(actual_treatment_date, '%Y-%m'),
    status
ORDER BY
    treatment_month,
    status;


-- 4.4 Understand Doctor and Room Performance

-- Compare the number of treatments handled by doctors.

SELECT
    d.doctor_id,
    d.doctor_name,
    d.specialty,
    COUNT(t.treatment_id) AS total_treatments
FROM doctors d
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name,
    d.specialty
ORDER BY total_treatments DESC;

-- Compare doctor performance across treatment outcomes.

SELECT
    d.doctor_id,
    d.doctor_name,
    t.status,
    COUNT(t.treatment_id) AS total_treatments
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name,
    t.status
ORDER BY
    d.doctor_name,
    total_treatments DESC;
    
-- What is each doctor's treatment completion rate?
SELECT
    d.doctor_id,
    d.doctor_name,
    COUNT(t.treatment_id) AS total_treatments,

    SUM(
        CASE
            WHEN t.status = 'Completed'
            THEN 1
            ELSE 0
        END
    ) AS completed_treatments,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN t.status = 'Completed'
                THEN 1
                ELSE 0
            END
        ) /
        COUNT(t.treatment_id),
        2
    ) AS completion_rate

FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id

GROUP BY
    d.doctor_id,
    d.doctor_name

ORDER BY completion_rate DESC;

-- Examine treatment duration across doctors.

SELECT
    d.doctor_id,
    d.doctor_name,
    d.specialty,
    COUNT(t.treatment_id) AS total_treatments,
    ROUND(AVG(t.treatment_duration_min), 2)
        AS avg_treatment_duration
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name,
    d.specialty
ORDER BY avg_treatment_duration DESC;

-- Compare room usage across room types and equipment types.

SELECT
    r.room_type,
    COUNT(t.treatment_id) AS total_treatments
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_type
ORDER BY total_treatments DESC;


-- How is equipment utilized?

SELECT
    r.equipment_type,
    COUNT(t.treatment_id) AS total_treatments
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.equipment_type
ORDER BY total_treatments DESC;

-- -- Evaluate treatment performance across rooms.

SELECT
    r.room_type,
    COUNT(*) AS total_treatments,
    ROUND(AVG(t.treatment_duration_min), 2) AS avg_duration,
    ROUND(AVG(t.waiting_time_min), 2) AS avg_waiting_time
FROM rooms r
JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_type
ORDER BY avg_waiting_time DESC;



-- 4.5 Identify Treatment and Appointment Problems

-- Identify appointments requiring multiple treatment attempts.

SELECT
    appointment_id,
    MAX(treatment_attempt) AS highest_attempt
FROM treatments
GROUP BY appointment_id
HAVING MAX(treatment_attempt) > 1
ORDER BY highest_attempt DESC;

-- How many appointments required multiple treatment attempts?

SELECT
    COUNT(DISTINCT appointment_id)
        AS appointments_with_multiple_attempts
FROM treatments
WHERE treatment_attempt > 1;

-- Find common problem statuses and patterns.
	-- Which treatment statuses occur most frequently?
SELECT
    status,
    COUNT(treatment_id) AS total_occurrences
FROM treatments
GROUP BY status
ORDER BY total_occurrences DESC;

   -- What patterns exist among problematic treatment statuses?
   
SELECT
    status,
    COUNT(treatment_id) AS total_treatments,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time,
    ROUND(AVG(treatment_duration_min), 2) AS avg_treatment_duration
FROM treatments
WHERE status IN
(
    'Cancelled',
    'No-Show',
    'Rescheduled'
)
GROUP BY status
ORDER BY total_treatments DESC;

-- Compare waiting time for appointments with multiple attempts.

SELECT
    treatment_attempt,
    ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments
GROUP BY treatment_attempt
ORDER BY treatment_attempt;

-- Identify cities or service types with more cancellations, no-shows, or rescheduling.

SELECT
    p.city,
    COUNT(*) AS total_problems
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
WHERE t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY p.city
ORDER BY total_problems DESC;

-- Investigate whether priority level is associated with waiting time or treatment outcomes.

SELECT
    a.priority,
    t.status,
    COUNT(t.treatment_id) AS total_treatments
FROM appointments a
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY
    a.priority,
    t.status
ORDER BY
    a.priority,
    total_treatments DESC;