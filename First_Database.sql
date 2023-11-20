/*
By typing my name below, I certify I completed this assignment without 
any assistance from any other person and that I wrote all the code in this
document. Any honor code violation on this homework will result in failure 
of the course.   

Type your name here:
Christian Martinez
SQL Code: 70%
Creating Tables = 40 pts
Inserting Data = 20 pts
Creating a View = 10 pts

NOTE: The database diagram required to complete the assignment is found 
in the Microsoft Word document listed in the assignment in Canvas. 


////// Section 1: Create Tables \\\\\\\\\\
*/
/*
1.	Using the database diagram in the posted Word document: Write a SQL statement to create 
the SPECIALTY table.  For full credit, your table must include a primary 
key constraint and attributes with corresponding data types that match 
the diagram. Be sure to execute your statement while using the “zz” 
database assigned to you. (5 pts)
*/
-- Start code:
USE zzDEmart

CREATE TABLE SPECIALTY_CM (
	SpecialtyId			int			NOT NULL,
	SpecialtyName		varchar(30)	NOT NULL,
	SpecialtyCategory	varchar(30) NULL,
	CONSTRAINT SPECIALTY_CM_PK PRIMARY KEY (SpecialtyId)
	);


-- End code 

/*
2.	Using the database diagram in the posted Word document: Write a SQL statement to create 
INSURANCE table.  For full credit, your table must include primary and 
foreign key constraints, when necessary, that match the diagram and all 
attributes with corresponding data types that match the diagram. Be sure 
to execute your statement while using the “zz” database assigned to you. 
(5 pts)
*/
-- Start code:
USE zzDEmart

CREATE TABLE INSURANCE_CM(
	InsuranceID		int			NOT NULL,
	InsuranceName	Varchar(30) NOT NULL,
	InsuranceAddr	Varchar(30) NULL,
	InsuranceCity	VarChar(30) NULL,
	InsuranceState  Char(2)		NULL,
	CONSTRAINT INSURANCE_CM_PK PRIMARY KEY (InsuranceID),
	CONSTRAINT InsuranceName_UNIQUE_Constraint_CM UNIQUE (InsuranceName)
	);
-- End code 

/*
3.	Using the database diagram in the posted Word document: Write a SQL statement to create 
DOCTOR table.  Use a SURROGATE key for DoctorID. For full credit, your 
table must include primary and foreign key constraints, when necessary, 
that match the diagram and all attributes with corresponding data types 
that match the diagram. Be sure to execute your statement while using the 
“zz” database assigned to you. (10 pts)
*/
-- Start code:
USE zzDEmart

CREATE TABLE DOCTOR_CM(
	DoctorID		int			NOT NULL IDENTITY(1,1),
	DoctorFirstName Varchar(30) NOT NULL,
	DoctorLastName  Varchar(30) NOT NULL,
	Office			Varchar(30) NULL,
	SpecialtyId		int			NOT NULL,
	CONSTRAINT DOCTOR_CM_PK PRIMARY KEY (DoctorID),
	CONSTRAINT SPECIALTY_CM_FK FOREIGN KEY (SpecialtyId)
								REFERENCES SPECIALTY_CM (SpecialtyId)
	);
-- End code 

/*
4.	Using the database diagram in the posted Word document: Write a SQL statement to create 
PATIENT table.  Use a SURROGATE key for PatientID. For full credit, your 
table must include primary and foreign key constraints, when necessary, 
that match the diagram and all attributes with corresponding data types 
that match the diagram. Be sure to execute your statement while using the 
“zz” database assigned to you. (10 pts)
*/
-- Start code:
USE zzDEmart
CREATE TABLE PATIENT_CM(
	PatientId		  int			NOT NULL IDENTITY(1,1),
	PatientFirstName  Varchar(30)	NOT NULL,
	PatientLastName   Varchar(30)	NOT NULL,
	PatientStreetAddr Varchar(30)	NOT NULL,
	PatientCity		  Varchar(30)	Not NULL,
	PatientState	  Char(2)		NOT NULL,
	PatientZip		  VarChar(30)   NOT NULL,
	PantinsId		  int			NOT NULL,
	CONSTRAINT PATIENT_CM_PK PRIMARY KEY (PatientId),
	CONSTRAINT INSURANCE_CM_FK FOREIGN KEY (PantinsId)
								REFERENCES INSURANCE_CM (InsuranceID)
	);


-- End code 

/*5.	Using the database diagram in the posted Word document: Write a SQL statement to 
create EXAM table.  NOTE: It is best to use the 'YYYYMMDD' format to 
insert dates into a datetime attribute. For full credit, your table must 
include primary and foreign key constraints, when necessary, that match 
the diagram and all attributes with corresponding data types that match 
the diagram. 
Be sure to execute your statement while using the “zz” database assigned 
to you. (10 pts)

*/
-- Start code:
USE zzDEmart

CREATE TABLE EXAM_CM(
	PatientId	int				NOT NULL,
	DoctorId	int				NOT NULL,
	ExamDate	datetime		NOT NULL,
	CONSTRAINT EXAM_CM_PK PRIMARY KEY (PatientId, DoctorId),
	CONSTRAINT PATIENT_CM_FK FOREIGN KEY (PatientId)
							REFERENCES PATIENT_CM (PatientId),
	CONSTRAINT DOCTOR_CM_FK FOREIGN KEY (DoctorId)
							REFERENCES DOCTOR_CM (DoctorID)
	);


-- End code 

/*
////// Section 2: Add Data to Tables \\\\\\

6.	Write a SQL statement to INSERT at least 2 records into EACH table. 
Make up the data, but you will obviously need to ensure the inserted data 
is of the an appropriate type. Be sure to execute your statements while 
using the “zz” database assigned to you. HINT: The order of the tables that 
you add data to matters due to foreign key constraints. (20 pts because 
there are 5 tables)
*/
-- Start code:
USE zzDEmart
INSERT INTO SPECIALTY_CM
(SpecialtyId,SpecialtyName, SpecialtyCategory)
VALUES
(1, 'Primary Care','Regular'),
(2, 'Urgent Care', 'Speacial');

INSERT INTO INSURANCE_CM
(InsuranceID, InsuranceName, InsuranceAddr, InsuranceCity, InsuranceState)
VALUES
(23, 'Metlife', '23 Forest Dr.', 'Orange', 'LA'),
(95, 'Blue Cross', '1 Corp Rd.', 'Asheville', 'NC')

INSERT INTO DOCTOR_CM
(DoctorFirstName, DoctorLastName, Office, SpecialtyId)
VALUES
('John', 'Doe', 'Green 30', 1),
('Mike', 'Smith', 'Blue 1', 2)

INSERT INTO PATIENT_CM
(PatientFirstName, PatientLastName, PatientStreetAddr, PatientCity,PatientState, PatientZip, PantinsId)
VALUES
('Jane', 'Deer', '2 Heart Pl.', 'Raleigh', 'NC', '27616', 23),
('Tom', 'Johnson', '41 Knight Pkwy', 'Cary', 'NC', '27439', 95)

INSERT INTO EXAM_CM
(PatientId, DoctorId, ExamDate)
VALUES
(1,2, '2023-9-1 11:15:00'),
(2,1, '2023-9-2 12:30:00')


-- End code 

/*
//////// Section 3: Create a VIEW \\\\\\\
7.	Write a SQL statement to create a view that lists the following 
information:  

PatientFirstName, PatientLastName, DoctorLastName, InsuranceName, ExamDate 
 
Be sure to execute your statements while using the “zz” database assigned 
to you. (5 pts)
*/
-- Start code:
CREATE VIEW view_1
AS
SELECT PatientFirstName, PatientLastName, DoctorLastName, InsuranceName, ExamDate
FROM PATIENT_CM JOIN INSURANCE_CM ON PATIENT_CM.PantinsId = INSURANCE_CM.InsuranceID
JOIN EXAM_CM ON PATIENT_CM.PatientId = EXAM_CM.PatientId
JOIN DOCTOR_CM ON EXAM_CM.DoctorId = DOCTOR_CM.DoctorID
-- End code 

/*
8.	Use a select statement to show the results of your view.  Execute the 
statement while using the “zz” database assigned to you. (5 pts)
*/
-- Start code:
USE zzDEmart
SELECT *
FROM view_1
-- End code 

/*
////// EXTRA CREDIT \\\\\\

1.	Write a SQL statement to drop “Office” attribute from the DOCTOR 
table. Execute the statement while using the “zz” database assigned 
to you. (2 pts)
*/
-- Start code:
ALTER TABLE DOCTOR_CM
	DROP COLUMN Office;
-- End code 

/*
2.	Write a SQL statement to add the “Office” attribute back into the 
table with a VARCHAR(30) datatype.  Execute the statement while 
using the “zz” database assigned to you. (3 pts)
*/
-- Start code:
ALTER TABLE DOCTOR_CM
	ADD Office Varchar(30) NULL;
-- End code 

/*  You're done! 

Copyright, R.Moloney 2023
This content is protected and may not be shared, uploaded, or distributed.
*/
-- 