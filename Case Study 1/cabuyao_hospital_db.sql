-- Creates the hospital database and sets it as the active schema
create database cabuyao_hospital_db; 
use cabuyao_hospital_db;

-- --------------------------------------------------------
-- TABLE CREATION
-- --------------------------------------------------------

-- Patient information and sign-up dates
create table patients(
    patient_id int auto_increment primary key, 
    patient_name varchar(255) not null,
    birth_date date not null, 
    email varchar(255) not null unique,
    sex char(1) not null ,
    registered_at date default (curdate()) ,
    phone_number varchar (20)not null unique
);

-- List of hospital departments
create table departments(
    department_id int auto_increment primary key,
    department_name varchar(50) not null
);

-- Doctor records linked to their departments
create table doctors(
    doctor_id int auto_increment primary key, 
    doctor_name varchar(255) not null,
    department_id int not null ,
    email varchar(255) not null unique,
    phone_number varchar (20)not null unique,
    foreign key (department_id) references departments(department_id )
);

-- Records of patient checkups and fees
create table consultations(
    consultation_id int auto_increment primary key,
    doctor_id  int not null ,
    patient_id  int not null ,
    consultation_date date not null,
    consultation_fee decimal(10,2) not null ,
    foreign key(doctor_id) references doctors(doctor_id),
    foreign key(patient_id) references patients(patient_id) 
);

-- Pharmacy inventory, stock, and prices
create table medicines(
    medicine_id int auto_increment primary key,
    medicine_name varchar(255) not null,
    stock int(10) not null default 0,
    price decimal(10,2) not null,
    expiry_date date not null,
    batch_number VARCHAR(50)
);

-- Prescriptions given to patients during consultations
create table prescriptions(
    prescription_id int auto_increment primary key, 
    doctor_id int not null,
    patient_id int not null,
    consultation_id int not null,
    medicine_id int not null,
    quantity int not null default 1,
    prescribed_at date default (current_date()) ,
    foreign key(doctor_id) references doctors(doctor_id),
    foreign key(patient_id) references patients(patient_id) ,
    foreign key(consultation_id) references consultations(consultation_id) ,
    foreign key(medicine_id) references medicines(medicine_id) 
);

-- Cashier records showing who paid and who still owes money
create table payments(
    payment_id int auto_increment primary key,
    consultation_id int not null,
    amount_paid decimal(10,2) not null ,
    amount_due decimal(10,2) not null ,
    payment_status varchar(50) not null,
    payment_method varchar(50) not null,
    foreign key(consultation_id) references consultations(consultation_id) 
);
 
-- --------------------------------------------------------
-- INSERTING DATA
-- --------------------------------------------------------

-- Puts in fake data to check if it breaks
INSERT INTO departments (department_name) VALUES 
("TestData1"),
("TestData2"),
("TestData3");

-- Wipes out the fake test data completely
truncate departments;
 
-- Inserts the real hospital departments
INSERT INTO departments (department_name) VALUES 
('General Medicine'),
('Pediatrics'),
('Cardiology'),
('OB-GYN'),
('Orthopedics');

-- Inserts 20 patient records
INSERT INTO patients (patient_name, birth_date, email, sex, registered_at, phone_number) VALUES
('Juan Dela Cruz', '1990-05-15', 'juan.delacruz@email.com', 'M', '2026-01-10', '09171234561'),
('Maria Clara Santos', '1995-10-22', 'maria.clara@email.com', 'F', '2026-01-11', '09182345672'),
('Jose Rizal Mercado', '1985-06-19', 'jose.rizal@email.com', 'M', '2026-01-12', '09193456783'),
('Ana Marie Almeda', '2000-02-14', 'ana.almeda@email.com', 'F', '2026-01-14', '09204567894'),
('Pedro Penduko', '1998-12-25', 'pedro.p@email.com', 'M', '2026-01-15', '09215678905'),
('Elena Banzon', '1975-08-30', 'elena.b@email.com', 'F', '2026-01-15', '09226789016'),
('Manuel Quezon', '1968-08-19', 'mquezon@email.com', 'M', '2026-01-16', '09237890127'),
('Corazon Aquino', '1955-01-25', 'cory.a@email.com', 'F', '2026-01-18', '09248901238'),
('Andres Bonifacio', '1993-11-30', 'andres.b@email.com', 'M', '2026-01-20', '09259012349'),
('Grace Poe Llamanzares', '1970-09-03', 'grace.poe@email.com', 'F', '2026-01-22', '09260123450'),
('Antonio Luna', '1988-10-29', 'general.luna@email.com', 'M', '2026-01-25', '09271234562'),
('Gabriela Silang', '1992-03-19', 'gabriela@email.com', 'F', '2026-01-26', '09282345673'),
('Emilio Aguinaldo', '1979-03-22', 'emilio.a@email.com', 'M', '2026-01-28', '09293456784'),
('Melchora Aquino', '1945-01-06', 'tandang.sora@email.com', 'F', '2026-02-01', '09304567895'),
('Apolinario Mabini', '1982-07-23', 'mabini.sublime@email.com', 'M', '2026-02-02', '09315678906'),
('Leonor Rivera', '1996-04-11', 'leonor.r@email.com', 'F', '2026-02-03', '09326789017'),
('Marcelo Del Pilar', '1972-08-30', 'plaridel@email.com', 'M', '2026-02-05', '09337890128'),
('Teresa Magbanua', '1984-10-13', 'teresa.m@email.com', 'F', '2026-02-05', '09348901239'),
('Juan Luna', '1965-10-24', 'jluna.spoliarium@email.com', 'M', '2026-02-06', '09359012350'),
('Gregoria De Jesus', '1994-05-09', 'gregoria.dj@email.com', 'F', '2026-02-07', '09360123451');

-- Inserts 11 doctors
INSERT INTO doctors (doctor_name, department_id, email, phone_number) VALUES
('Dr. Ricardo Carandang', 1, 'ricardo.carandang@cabuyaohosp.com', '09991234561'),
('Dr. Maria Theresa Cruz', 1, 'mt.cruz@cabuyaohosp.com', '09991234562'),
('Dr. Jose Emmanuel Lim', 2, 'je.lim@cabuyaohosp.com', '09991234563'),
('Dr. Patricia Reyes', 2, 'pat.reyes@cabuyaohosp.com', '09991234564'),
('Dr. Alan Peter Santos', 3, 'ap.santos@cabuyaohosp.com', '09991234565'),
('Dr. Divina Garcia', 3, 'divina.garcia@cabuyaohosp.com', '09991234566'),
('Dr. Beatrice Villamin', 4, 'b.villamin@cabuyaohosp.com', '09991234567'),
('Dr. Christopher Castillo', 4, 'chris.castillo@cabuyaohosp.com', '09991234568'),
('Dr. Ferdinand Mendoza', 5, 'ferdie.mendoza@cabuyaohosp.com', '09991234569'),
('Dr. Stephanie Alcantara', 5, 'steph.alcantara@cabuyaohosp.com', '09991234570'),
('Dr. Cardo Dalisay', 2, 'cardo.dang@cabuyaohosp.com', '09991454361');

-- Inserts 8 baseline medicines
INSERT INTO medicines (medicine_name, stock, price, expiry_date, batch_number) VALUES
('Paracetamol (Biogesic) 500mg', 500, 5.00, '2028-12-01', 'BATCH-PCM01'),
('Amoxicillin 500mg', 300, 8.50, '2027-06-15', 'BATCH-AMX02'),
('Ibuprofen 400mg', 200, 7.00, '2028-03-20', 'BATCH-IBU03'),
('Metformin 500mg', 400, 6.50, '2028-09-10', 'BATCH-MET04'),
('Amlodipine 5mg', 350, 4.00, '2027-11-22', 'BATCH-AML05'),
('Cetirizine 10mg', 250, 6.00, '2028-01-18', 'BATCH-CET06'),
('Losartan 50mg', 300, 9.00, '2028-05-14', 'BATCH-LOS07'),
('Mefenamic Acid 500mg', 150, 7.50, '2027-08-30', 'BATCH-MEF08');

-- Inserts 40 consultation records
INSERT INTO consultations (doctor_id, patient_id, consultation_date, consultation_fee) VALUES
(1, 1, '2026-02-10', 500.00), (2, 2, '2026-02-10', 500.00),
(3, 3, '2026-02-11', 600.00), (4, 4, '2026-02-11', 600.00),
(5, 5, '2026-02-12', 800.00), (6, 6, '2026-02-12', 800.00),
(7, 7, '2026-02-13', 700.00), (8, 8, '2026-02-13', 700.00),
(9, 9, '2026-02-14', 750.00), (10, 10, '2026-02-14', 750.00),
(1, 11, '2026-02-15', 500.00), (2, 12, '2026-02-15', 500.00),
(3, 13, '2026-02-16', 600.00), (4, 14, '2026-02-16', 600.00),
(5, 15, '2026-02-17', 800.00), (6, 16, '2026-02-17', 800.00),
(7, 17, '2026-02-18', 700.00), (8, 18, '2026-02-18', 700.00),
(9, 19, '2026-02-19', 750.00), (10, 20, '2026-02-19', 750.00),
(1, 2, '2026-02-20', 500.00), (2, 4, '2026-02-20', 500.00),
(3, 6, '2026-02-21', 600.00), (4, 8, '2026-02-21', 600.00),
(5, 10, '2026-02-22', 800.00), (6, 12, '2026-02-22', 800.00),
(7, 14, '2026-02-23', 700.00), (8, 16, '2026-02-23', 700.00),
(9, 18, '2026-02-24', 750.00), (10, 20, '2026-02-24', 750.00),
(1, 5, '2026-02-25', 500.00), (2, 10, '2026-02-25', 500.00),
(3, 15, '2026-02-26', 600.00), (4, 20, '2026-02-26', 600.00),
(5, 1, '2026-02-27', 800.00), (6, 7, '2026-02-27', 800.00),
(7, 11, '2026-02-28', 700.00), (8, 14, '2026-02-28', 700.00),
(9, 3, '2026-03-01', 750.00), (10, 9, '2026-03-01', 750.00);

-- Inserts 40 payment status records
INSERT INTO payments (consultation_id, amount_paid, amount_due, payment_status, payment_method) VALUES
(1, 500.00, 500.00, 'Paid', 'Cash'), (2, 500.00, 500.00, 'Paid', 'GCash'),
(3, 600.00, 600.00, 'Paid', 'Cash'), (4, 600.00, 600.00, 'Paid', 'Maya'),
(5, 800.00, 800.00, 'Paid', 'Credit Card'), (6, 0.00, 800.00, 'Pending', 'Cash'),
(7, 700.00, 700.00, 'Paid', 'Insurance'), (8, 700.00, 700.00, 'Paid', 'Cash'),
(9, 750.00, 750.00, 'Paid', 'GCash'), (10, 750.00, 750.00, 'Paid', 'Cash'),
(11, 500.00, 500.00, 'Paid', 'Cash'), (12, 500.00, 500.00, 'Paid', 'GCash'),
(13, 600.00, 600.00, 'Paid', 'Cash'), (14, 0.00, 600.00, 'Pending', 'Cash'),
(15, 800.00, 800.00, 'Paid', 'Credit Card'), (16, 800.00, 800.00, 'Paid', 'Maya'),
(17, 700.00, 700.00, 'Paid', 'Insurance'), (18, 700.00, 700.00, 'Paid', 'Cash'),
(19, 750.00, 750.00, 'Paid', 'GCash'), (20, 750.00, 750.00, 'Paid', 'Cash'),
(21, 500.00, 500.00, 'Paid', 'Cash'), (22, 500.00, 500.00, 'Paid', 'GCash'),
(23, 600.00, 600.00, 'Paid', 'Cash'), (24, 600.00, 600.00, 'Paid', 'Maya'),
(25, 800.00, 800.00, 'Paid', 'Credit Card'), (26, 800.00, 800.00, 'Paid', 'Cash'),
(27, 700.00, 700.00, 'Paid', 'Insurance'), (28, 700.00, 700.00, 'Paid', 'Cash'),
(29, 750.00, 750.00, 'Paid', 'GCash'), (30, 0.00, 750.00, 'Pending', 'Cash'),
(31, 500.00, 500.00, 'Paid', 'Cash'), (32, 500.00, 500.00, 'Paid', 'GCash'),
(33, 600.00, 600.00, 'Paid', 'Cash'), (34, 600.00, 600.00, 'Paid', 'Maya'),
(35, 800.00, 800.00, 'Paid', 'Credit Card'), (36, 800.00, 800.00, 'Paid', 'Cash'),
(37, 700.00, 700.00, 'Paid', 'Insurance'), (38, 700.00, 700.00, 'Paid', 'Cash'),
(39, 750.00, 750.00, 'Paid', 'GCash'), (40, 750.00, 750.00, 'Paid', 'Cash');

-- Fixing a typo in a patient's name
update patients set patient_name = "Manuel Cavite" where patient_id  = 7; 

-- Removing a doctor because they resigned
delete from doctors where doctor_id = 11;

-- --------------------------------------------------------
-- STORED PROCEDURES
-- --------------------------------------------------------

-- Routine structure to easily add new patient sign-ups
delimiter //
    create procedure registerPatient(
        in n_patient_name varchar(255), 
        in n_birth_date date, 
        in n_email varchar(255) , 
        in n_sex char(1) , 
        in n_phone_number  varchar (20)
    )
        begin
            insert into patients(patient_name, birth_date, email, sex, phone_number)
            values
            (n_patient_name,n_birth_date,n_email,n_sex,n_phone_number);
        end //
delimiter ;

-- Runs the procedure to add a new patient to the table
call registerPatient(
    "Vincent Lemuel T. Mandap",
    '2006-10-29',
    'vincent@gmail.com',
    'M',
    "099534554542"
);