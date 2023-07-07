create database hospt1;

CREATE TABLE doctor (
  d_id BIGINT PRIMARY KEY,
  d_fname VARCHAR(20),
  d_lname VARCHAR(20),
  d_field VARCHAR(50) NOT NULL,
  d_age INT,
  d_gender VARCHAR(1),
  d_cont BIGINT NOT NULL,
  d_mail VARCHAR(75),
  INDEX (d_id) -- Add an index on d_id column
);
-- ------- ---------------------------------------------------------------------------------------------- 

CREATE TABLE patient (
  p_id BIGINT PRIMARY KEY,
  p_fname VARCHAR(20) NOT NULL,
  p_lname VARCHAR(20),
  p_age INT NOT NULL,
  p_gender VARCHAR(1) NOT NULL,
  p_symptoms VARCHAR(75),
  p_add VARCHAR(50),
  p_pin BIGINT NOT NULL,
  p_country VARCHAR(15),
  p_cont BIGINT NOT NULL,
  p_mail VARCHAR(75)
);
-- --------------------------------------------------------------------------------------------------------------------------

CREATE TABLE doctor_patient (
  d_id BIGINT,
  p_id BIGINT,
  FOREIGN KEY (d_id) REFERENCES doctor (d_id) ON DELETE CASCADE,
  FOREIGN KEY (p_id) REFERENCES patient (p_id) ON DELETE CASCADE
);
-- ----------------------------------------------------------------------------------------------------------
create table appointment(appt_id int primary key , p_id bigint , appt_date date, appt_time time ,d_id bigint,
foreign key(p_id) references patient(p_id) on delete set null ,
foreign key(d_id) references doctor(d_id) on delete set null);
-- ------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE testprice (
  test_code VARCHAR(5) PRIMARY KEY,
  test_price INT,
  INDEX idx_testcode (test_code)
);

 -- adding index on test code column
-- -----------------------------------------------------------------------------------------------------
CREATE TABLE lab (
  labno INT PRIMARY KEY,
  p_id BIGINT,
  test_code VARCHAR(5),
  p_height_cm INT,
  p_weight_kg INT,
  p_lab_date DATE,
  p_bp INT NOT NULL,
  p_blood_grp VARCHAR(5),
  FOREIGN KEY (p_id) REFERENCES patient (p_id) ON DELETE SET NULL,
  FOREIGN KEY (test_code) REFERENCES testprice (test_code) ON DELETE SET NULL
);

-- -----------------------------------------------------------------------------------------------------
create table lab(labno int primary key , p_id bigint , test_code varchar(5), p_height_cm int, p_weight_kg int,
 p_lab_date date, p_bp int not null , p_blood_grp varchar(5), 
 foreign key(p_id) references patient(p_id)   on delete set null ,
 foreign key (test_code) references testprice(test_code) on delete set null 
  );
  -- --------------------------------------------------------------------------------------
 CREATE TABLE patient_report (
  report_id INT PRIMARY KEY,
  p_id BIGINT,
  diagnose VARCHAR(140),
  FOREIGN KEY (p_id) REFERENCES patient (p_id) ON DELETE SET NULL
);

CREATE INDEX idx_report_id ON patient_report (report_id);

-- -------------------------------------------------------------------------------------------------
create table medicine(med_id bigint primary key, med_name varchar(150), 
med_type varchar(150),med_descrip varchar(150), med_price int);
CREATE INDEX idx_med_id ON medicine (med_id);
-- --------------------------------------------------------------------------------------------------
CREATE TABLE prescribed_med (
  presc_med_id INT PRIMARY KEY,
  p_id BIGINT,
  med_id BIGINT,
  meda_id BIGINT,
  medb_id BIGINT,
  medc_id BIGINT,
  medd_id BIGINT,
  report_id INT,
  FOREIGN KEY (p_id) REFERENCES patient (p_id) ON DELETE SET NULL,
  FOREIGN KEY (meda_id) REFERENCES medicine (med_id) ON DELETE SET NULL,
  FOREIGN KEY (medb_id) REFERENCES medicine (med_id) ON DELETE SET NULL,
  FOREIGN KEY (medc_id) REFERENCES medicine (med_id) ON DELETE SET NULL,
  FOREIGN KEY (medd_id) REFERENCES medicine (med_id) ON DELETE SET NULL,
  FOREIGN KEY (report_id) REFERENCES patient_report (report_id) ON DELETE SET NULL
);

 -- --------------BOUNDARY---------------------BOUNDARY---------------------BOUNDARY-------------------------
create table hospital(hospital_id int primary key , hospital_name varchar(140),hospital_add varchar(250), 
hospital_code bigint, hospital_phone bigint, hospital_country varchar(25));
CREATE INDEX idx_hospital_id ON hospital (hospital_id);
 -- --------------BOUNDARY---------------------BOUNDARY---------------------BOUNDARY-------------------------
create table room(room_no int primary key, room_type varchar(6),p_id bigint , 
hospital_id int, room_status varchar(20),
foreign key (p_id) references patient(p_id) on delete set null ,
foreign key (hospital_id) references hospital(hospital_id) on delete set null );
 -- --------------BOUNDARY---------------------BOUNDARY---------------------BOUNDARY-------------------------
create table insurance(ins_no bigint primary key ,insurance_company varchar(25),
 publish_date date, exp_date date,insurance_plan varchar(50),entry_fee int,cover_pay int,
cover_insurance int,medicine_cover int,
INDEX insurance_idx (ins_no)

 );
-- ------------------------------------------------------------------------
create table insurance_patient(
ins_no bigint,
p_id bigint ,
foreign key (p_id) references patient(p_id) on delete cascade ,
foreign key (ins_no) references insurance(ins_no) on delete cascade);

 -- --------------BOUNDARY---------------------BOUNDARY---------------------BOUNDARY-------------------------
create table bill(bill_no bigint primary key , p_id bigint, doc_charges int,
medicine_charge int , room_charge int , operation_charge bigint ,
nurse_charge int , lab_charge int , adv_charge int , ins_no bigint,total_bill bigint,
foreign key (p_id) references patient(p_id) on delete set null ,
foreign key (ins_no) references insurance(ins_no) on delete set null);


