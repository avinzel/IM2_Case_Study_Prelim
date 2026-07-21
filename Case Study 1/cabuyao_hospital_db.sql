-- Create the Cabuyao Hospital database
CREATE DATABASE cabuyao_hospital_db; 
USE cabuyao_hospital_db;

-- --------------------------------------------------------
-- TABLE CREATION
-- --------------------------------------------------------

-- Stores patient personal details
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, 
    patient_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL, 
    email VARCHAR(255) NOT NULL UNIQUE,
    sex CHAR(1) NOT NULL,
    registered_at DATE DEFAULT (CURDATE()),
    phone_number VARCHAR(20) NOT NULL UNIQUE
);

-- Stores hospital departments
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Stores doctor information and links them to a department
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY, 
    doctor_name VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Records appointment consultations between doctors and patients
CREATE TABLE consultations (
    consultation_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    consultation_date DATE NOT NULL,
    consultation_fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) 
);

-- Stores pharmacy inventory details
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(255) NOT NULL,
    stock INT(10) NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL,
    expiry_date DATE NOT NULL,
    batch_number VARCHAR(50)
);

-- Links prescribed medicines to consultations, doctors, and patients
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY, 
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    consultation_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    prescribed_at DATE DEFAULT (CURRENT_DATE()),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (consultation_id) REFERENCES consultations(consultation_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id) 
);

-- Tracks payment records for consultations
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    consultation_id INT NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    paid_at DATE NULL,
    FOREIGN KEY (consultation_id) REFERENCES consultations(consultation_id) 
);

-- --------------------------------------------------------
-- DATA INSERTION (SEEDING MOCK DATA)
-- --------------------------------------------------------

-- Insert 5 medical departments
INSERT INTO departments (department_name) VALUES
('General Medicine'),
('Pediatrics'),
('Obstetrics and Gynecology'),
('Cardiology'),
('Orthopedics');

-- Insert 20 patient records
INSERT INTO patients (patient_name, birth_date, email, sex, registered_at, phone_number) VALUES
('Mark Anthony Bautista', '1995-04-12', 'mark.bautista@gmail.com', 'M', '2026-01-10', '09180001111'),
('Sarah Mae Mendoza', '1998-08-23', 'sarah.mendoza@yahoo.com', 'F', '2026-01-12', '09180002222'),
('Joseph Alcantara', '1985-11-05', 'joseph.alcantara@gmail.com', 'M', '2026-01-15', '09180003333'),
('Luningning Ramos', '1990-02-18', 'luningning.ramos@gmail.com', 'F', '2026-01-20', '09180004444'),
('Christian Paul Navarro', '2001-09-30', 'cp.navarro@outlook.com', 'M', '2026-02-01', '09180005555'),
('Grace Villareal', '1988-06-14', 'grace.v@yahoo.com', 'F', '2026-02-05', '09180006666'),
('Ricardo Dalisay', '1979-12-01', 'carding.dalisay@gmail.com', 'M', '2026-02-10', '09180007777'),
('Beatriz Alonzo', '1993-03-22', 'bea.alonzo@gmail.com', 'F', '2026-02-14', '09180008888'),
('Gabriel Mercado', '2003-07-11', 'gab.mercado@yahoo.com', 'M', '2026-02-18', '09180009999'),
('Patricia Aquino', '1996-05-19', 'patty.aquino@gmail.com', 'F', '2026-02-22', '09180000000'),
('John Lloyd Cruz', '1983-06-24', 'jl.cruz@gmail.com', 'M', '2026-02-25', '09180001122'),
('Angel Locsin', '1985-04-23', 'angel.locsin@yahoo.com', 'F', '2026-02-26', '09180002233'),
('Dingdong Dantes', '1980-08-02', 'dingdong.dantes@gmail.com', 'M', '2026-02-27', '09180003344'),
('Marian Rivera', '1984-08-12', 'marian.rivera@gmail.com', 'F', '2026-02-28', '09180004455'),
('Alden Richards', '1992-01-02', 'alden.richards@outlook.com', 'M', '2026-03-01', '09180005566'),
('Maine Mendoza', '1995-03-03', 'maine.mendoza@gmail.com', 'F', '2026-03-02', '09180006677'),
('Daniel Padilla', '1995-04-26', 'daniel.padilla@yahoo.com', 'M', '2026-03-03', '09180007788'),
('Kathryn Bernardo', '1996-03-26', 'kath.bernardo@gmail.com', 'F', '2026-03-04', '09180008899'),
('Enrique Gil', '1992-03-30', 'enrique.gil@gmail.com', 'M', '2026-03-05', '09180009900'),
('Liza Soberano', '1998-01-04', 'liza.soberano@outlook.com', 'F', '2026-03-06', '09180000011');

-- Insert 10 doctor records
INSERT INTO doctors (doctor_name, department_id, email, phone_number) VALUES
('Dr. Maria Santos', 1, 'maria.santos@cabuyaohospital.ph', '09171112233'),
('Dr. Juan Dela Cruz', 2, 'juan.delacruz@cabuyaohospital.ph', '09172223344'),
('Dr. Ana Reyes', 3, 'ana.reyes@cabuyaohospital.ph', '09173334455'),
('Dr. Ramon Garcia', 4, 'ramon.garcia@cabuyaohospital.ph', '09174445566'),
('Dr. Elena Torralba', 5, 'elena.torralba@cabuyaohospital.ph', '09175556677'),
('Dr. Jose Rizal', 1, 'jose.rizal@cabuyaohospital.ph', '09176667788'),
('Dr. Clara Asuncion', 2, 'clara.asuncion@cabuyaohospital.ph', '09177778899'),
('Dr. Fernando Poe', 3, 'fernando.poe@cabuyaohospital.ph', '09178889900'),
('Dr. Gloria Romero', 4, 'gloria.romero@cabuyaohospital.ph', '09179990011'),
('Dr. Manuel Quezon', 5, 'manuel.quezon@cabuyaohospital.ph', '09170001122');

-- Insert 8 medicine items into inventory
INSERT INTO medicines (medicine_name, stock, price, expiry_date, batch_number) VALUES
('Paracetamol 500mg', 500, 15.00, '2027-12-31', 'BATCH-001'),
('Amoxicillin 500mg', 300, 25.50, '2027-08-15', 'BATCH-002'),
('Mefenamic Acid 500mg', 250, 18.00, '2026-11-20', 'BATCH-003'),
('Losartan 50mg', 400, 22.00, '2028-01-10', 'BATCH-004'),
('Metformin 500mg', 350, 12.00, '2027-05-30', 'BATCH-005'),
('Cetirizine 10mg', 600, 10.00, '2027-09-12', 'BATCH-006'),
('Omeprazole 20mg', 200, 35.00, '2026-12-01', 'BATCH-007'),
('Azithromycin 500mg', 150, 85.00, '2027-03-18', 'BATCH-008');

-- Insert 40 consultation records
INSERT INTO consultations (doctor_id, patient_id, consultation_date, consultation_fee) VALUES
(1, 1, '2026-02-10', 350.00), (2, 2, '2026-02-10', 500.00),
(3, 3, '2026-02-11', 1800.00), (4, 4, '2026-02-11', 600.00),
(5, 5, '2026-02-12', 800.00), (6, 6, '2026-02-12', 450.00),
(7, 7, '2026-02-13', 2100.00), (8, 8, '2026-02-13', 700.00),
(9, 9, '2026-02-14', 250.00), (10, 10, '2026-02-14', 750.00),
(1, 11, '2026-02-15', 1600.00), (2, 12, '2026-02-15', 500.00),
(3, 13, '2026-02-16', 300.00), (4, 14, '2026-02-16', 600.00),
(5, 15, '2026-02-17', 1250.00), (6, 16, '2026-02-17', 2500.00),
(7, 17, '2026-02-18', 700.00), (8, 18, '2026-02-18', 400.00),
(9, 19, '2026-02-19', 750.00), (10, 20, '2026-02-19', 1950.00),
(1, 2, '2026-02-20', 500.00), (2, 4, '2026-02-20', 280.00),
(3, 6, '2026-02-21', 600.00), (4, 8, '2026-02-21', 1750.00),
(5, 10, '2026-02-22', 800.00), (6, 12, '2026-02-22', 450.00),
(7, 14, '2026-02-23', 2200.00), (8, 16, '2026-02-23', 700.00),
(9, 18, '2026-02-24', 1100.00), (10, 20, '2026-02-24', 1850.00),
(1, 5, '2026-02-25', 350.00), (2, 10, '2026-02-25', 500.00),
(3, 15, '2026-02-26', 1650.00), (4, 20, '2026-02-26', 600.00),
(5, 1, '2026-02-27', 800.00), (6, 7, '2026-02-27', 420.00),
(7, 11, '2026-02-28', 700.00), (8, 14, '2026-02-28', 2400.00),
(9, 3, '2026-03-01', 950.00), (10, 9, '2026-03-01', 750.00);

-- Temporary test insertions (Testing functionality)
INSERT INTO payments (consultation_id, amount_paid, payment_status, payment_method, paid_at) VALUES 
(1, 1, "??", '??', "2001-01-01"),
(2, 2, "??", '??', "2002-02-02"),
(3, 3, "??", '??', "2003-03-03");

-- Delete all test rows and reset auto-increment for payments table
TRUNCATE payments;

-- Insert 40 payment records linked to consultations
INSERT INTO payments (consultation_id, amount_paid, payment_status, payment_method, paid_at) VALUES
(1, 350.00, 'Paid', 'Cash', '2026-02-10'),
(2, 500.00, 'Paid', 'GCash', '2026-02-10'),
(3, 1800.00, 'Paid', 'Cash', '2026-02-11'),
(4, 600.00, 'Paid', 'Maya', '2026-02-11'),
(5, 800.00, 'Paid', 'Credit Card', '2026-02-12'),
(6, 0.00, 'Pending', 'Cash', NULL),
(7, 2100.00, 'Paid', 'Insurance', '2026-02-13'),
(8, 700.00, 'Paid', 'Cash', '2026-02-13'),
(9, 250.00, 'Paid', 'GCash', '2026-02-14'),
(10, 750.00, 'Paid', 'Cash', '2026-02-14'),
(11, 1600.00, 'Paid', 'Cash', '2026-02-15'),
(12, 500.00, 'Paid', 'GCash', '2026-02-15'),
(13, 300.00, 'Paid', 'Cash', '2026-02-16'),
(14, 0.00, 'Pending', 'Cash', NULL),
(15, 1250.00, 'Paid', 'Credit Card', '2026-02-17'),
(16, 2500.00, 'Paid', 'Maya', '2026-02-17'),
(17, 700.00, 'Paid', 'Insurance', '2026-02-18'),
(18, 400.00, 'Paid', 'Cash', '2026-02-18'),
(19, 750.00, 'Paid', 'GCash', '2026-02-19'),
(20, 1950.00, 'Paid', 'Cash', '2026-02-19'),
(21, 500.00, 'Paid', 'Cash', '2026-02-20'),
(22, 280.00, 'Paid', 'GCash', '2026-02-20'),
(23, 600.00, 'Paid', 'Cash', '2026-02-21'),
(24, 1750.00, 'Paid', 'Maya', '2026-02-21'),
(25, 800.00, 'Paid', 'Credit Card', '2026-02-22'),
(26, 450.00, 'Paid', 'Cash', '2026-02-22'),
(27, 2200.00, 'Paid', 'Insurance', '2026-02-23'),
(28, 700.00, 'Paid', 'Cash', '2026-02-23'),
(29, 1100.00, 'Paid', 'GCash', '2026-02-24'),
(30, 0.00, 'Pending', 'Cash', NULL),
(31, 350.00, 'Paid', 'Cash', '2026-02-25'),
(32, 500.00, 'Paid', 'GCash', '2026-02-25'),
(33, 1650.00, 'Paid', 'Cash', '2026-02-26'),
(34, 600.00, 'Paid', 'Maya', '2026-02-26'),
(35, 800.00, 'Paid', 'Credit Card', '2026-02-27'),
(36, 420.00, 'Paid', 'Cash', '2026-02-27'),
(37, 700.00, 'Paid', 'Insurance', '2026-02-28'),
(38, 2400.00, 'Paid', 'Cash', '2026-02-28'),
(39, 950.00, 'Paid', 'GCash', '2026-03-01'),
(40, 750.00, 'Paid', 'Cash', '2026-03-01');

-- Insert prescription records given during consultations
INSERT INTO prescriptions (doctor_id, patient_id, consultation_id, medicine_id, quantity, prescribed_at) VALUES
(1, 1, 1, 1, 2, '2026-02-10'),   
(3, 3, 3, 2, 1, '2026-02-11'),    
(5, 5, 5, 4, 3, '2026-02-12'),    
(7, 7, 7, 3, 2, '2026-02-13'),    
(9, 9, 9, 7, 1, '2026-02-14');   

-- --------------------------------------------------------
-- UPDATES & DELETES
-- --------------------------------------------------------

-- Update patient name for ID 7 from 'Ricardo Dalisay' to 'Manuel Cavite'
UPDATE patients 
SET patient_name = 'Manuel Cavite' 
WHERE patient_id = 7; 

-- Delete doctor record with ID 11 (if it exists)
DELETE FROM doctors 
WHERE doctor_id = 11;