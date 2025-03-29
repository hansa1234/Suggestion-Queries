Create DATABASE EPSILON_BOT;


USE EPSILON_BOT;

Create Table Users( 
	UserPSNo varchar(50) primary KEY ,
    UserName varchar(100) NOT NULL,
    Department varchar(100)
);

Insert into users (UserPSNO , UserName , Department) values
('20353191' , 'Jaya Chandra' , 'GROUP INFORMATION TECHNOLOGY') ,
('20371226' , 'Meghna Singh' , 'IT & SYSTEMS') ,
('20370744' , 'Hansa Saini' , 'GROUP INFORMATION TECHNOLOGY') , 
('20114582' , 'Vivek Chaudhary' , 'GROUP INFORMATION TECHNOLOGY') , 
('20045748' , 'Rachit Parikh' , 'GROUP INFORMATION TECHNOLOGY') , 
('725368' , 'Neerav Mehta' , 'GROUP INFORMATION TECHNOLOGY');

SELECT * FROM USERS;

Create Table Bots(
	BotCode varchar(50) primary KEY,
    BotName varchar(100) not null ,
    BotType varchar(50) not null
);

INSERT INTO bots (BotCode , BotName , BotTYpe) values
('LOGOV001' , 'Logistics Bot' , 'Overall') , 
('PPPW002' , 'Punch Points Bot (Specific Projects only)' , 'Project-Wise') , 
('COMPW003' , 'Commissioning-Centenary DB Bot' , 'Project-Wise') ,
('INVOV004' , 'Invoice - SIM GRN Bot' , 'Overall') ;

select * from bots;

Create Table Projects (
	ProjectCode varchar(50) primary key , 
    ProjectName varchar(100) not null
);

INSERT INTO projects (ProjectCode , ProjectName) values
('HRRL-DFCU' , 'HPCL Rajasthan Refinery Limiteds Dual Feed Cracker Unit') , 
('HRRL-PFCCU' , 'HPCL Rajasthan Refinery Limiteds Precast Civil Works Project') ,
('IOCL-DHDT' , 'Indian Oil Corporation Limiteds Diesel Hdro-treater Unit') , 
('IOCL-O&U' , 'Indian Oil Corporation Limiteds O&U Project') ,
('HPCL-RUF' , 'HPCL Residue Upgradation Facility');

select * from projects;

Create Table applicable_projects_bot_wise (
	BotCode varchar(50) , 
    ProjectCode varchar(50) , 
    primary key (BotCode  , ProjectCode) ,
    foreign key (BotCode) references bots(BotCode) on delete cascade , 
    foreign key (ProjectCode) references projects(ProjectCode) on delete cascade
);

Insert into applicable_projects_bot_wise (BotCode , ProjectCode) values
('PPPW002' , 'HRRL-DFCU') , 
('COMPW003' , 'IOCL-DHDT') , 
('COMPW003' , 'IOCL-O&U') , 
('COMPW003' , 'HPCL-RUF');

SELECT * FROM applicable_projects_bot_wise;

Create Table access_matrix(
	UserPSNo varchar(50) , 
    UserRole varchar(50),
    ProjectCode varchar(50) DEFAULT NULL,
    BotCode varchar(50) DEFAULT NULL,
    foreign key (UserPSNo) references users(UserPSNo),
    foreign key (ProjectCode) references projects(ProjectCode) ,
    foreign key (BotCode) references bots(BotCode)
);

Insert into access_matrix (UserPSNo , UserRole , ProjectCode , BotCode) values
('20353191' , 'Admin' , NULL , NULL) ,
('20371226' , 'Admin' , NULL , NULL) ,
('20370744' , 'Bot-Owner' , NULL , 'COMPW003');

select * from access_matrix;

Insert into users (UserPSNO , UserName , Department) values
('20370743' , 'Kavyasri Bollina' , 'GROUP INFORMATION TECHNOLOGY');

select * from users;

Insert into access_matrix (UserPSNo , UserRole , ProjectCode , BotCode) values
('20370743' , 'Project-Member' , 'HPCL-RUF' , NULL),
('20370743' , 'Project-Member' , 'HRRL-DFCU' , NULL),
('20114582' , 'Bot-Owner' , NULL , 'PPPW002') , 
('20114582' , 'Project-Member' , 'HPCL-RUF' , NULL);

select * from access_matrix;

Create Table cost_tracking(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    ServerType varchar(50) not null,
    UserPSNo varchar(50),
    Date_ Date not null,
    BotCode varchar(50) ,
    ProjectCode varchar(50) NULL,
    UnitsConsumed Decimal(10,2),
    FOREIGN KEY (UserPSNo) references users(UserPSNo) on delete cascade,
    FOREIGN KEY (BotCode) references bots(BotCode) on delete set null,
    FOREIGN KEY (ProjectCode) references projects(ProjectCode) on delete set null
);

selecr * from cost_tracking;
SELECT CONSTRAINT_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'access_matrix' 
AND TABLE_SCHEMA = DATABASE();

ALTER TABLE access_matrix DROP FOREIGN KEY fk_old_UserPSNo;
ALTER TABLE access_matrix DROP FOREIGN KEY fk_old_ProjectCode;
ALTER TABLE access_matrix DROP FOREIGN KEY fk_old_BotCode;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_UserPSNo 
FOREIGN KEY (UserPSNo) REFERENCES users(UserPSNo) ON DELETE CASCADE;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_ProjectCode 
FOREIGN KEY (ProjectCode) REFERENCES projects(ProjectCode) ON DELETE CASCADE;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_BotCode 
FOREIGN KEY (BotCode) REFERENCES bots(BotCode) ON DELETE CASCADE;

('20342184','Aditi Arora','GROUP INFORMATION TECHNOLOGY'),
('20333353','Madhav', 'GROUP INFORMATION TECHNOLOGY'),
('20362202','Himanshu Patel', 'GROUP INFORMATION TECHNOLOGY'),
('20330459','Priyanka Prashar', 'GROUP INFORMATION TECHNOLOGY'),
('998133','Dhruvang Soni', 'GROUP INFORMATION TECHNOLOGY');

project code: HRRL-PFCCU
Project: Petrochemical fluidized catalytic cracking unit(HRRL-PFCCU)
Client: Hindustan Petroleum Corporation Limited (HPCL)
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: Barmer, Rajasthan, India
lat: 26.772163, lon: 72.405757,
 
project code: HRRL-DFCU
Project: Development Finance Company of Uganda Limited(HRRL-DFCU)
Client: Hindustan Petroleum Corporation Limited (HPCL)
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: Barmer, Rajasthan, India
lat: 25.746092, lon: 71.397454,
 
project code: HPCL-RUF
Project: Hindustan Petroleum Corporation Limited - Residue Upgradation Facility (HPCL-RUF)
Client: Hindustan Petroleum Corporation Limited (HPCL)
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: Visakhapatnam, Andhra Pradesh, India
lat: 17.68858, lon: 83.251943,
 
project code: IOCL-DHDT
Project: Diesel Hydrotreating (IOCL-DHDT)
Client:</strong> Indian Oil Corporation (IOCL)
Contractor:</strong> L&T Hydrocarbon Engineering (LTHE)
Location:</strong> Panipat, India
lat: 29.4676433, lon: 76.8754072,
 
project code: IOCL-O&U
Project: Diesel Hydrotreating (IOCL-DHDT)
Client: Indian Oil Corporation (IOCL)
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: Panipat, India
lat: 21.5431241, lon: 84.6897321,
 
 
project code: JGP-21
Project: Jharsuguda Gas Pipeline (JGP-21)
Client: 
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: 
lat: 23.885942, lon: 45.079162,
 
 
project code: JGCP-31
Project: Jafurah Gas Compression Project(JGP-21)
Client: SEJIN Plant Engineering/Hyundai Engineering & Construction(South Korea) 
Contractor: L&T Hydrocarbon Engineering (LTHE)
Location: Al Jouf Province, Saudi Arabia
lat: 23.885942, lon: 45.079162

INSERT INTO cost_tracking (ID, ServerType, UserPSNo, Date_, BotCode, ProjectCode, UnitsConsumed)
VALUES 
(1, 'AWS', 'U101', '2025-03-29', 'BOT_A', 'PROJ_1', 500),
(2, 'Azure', 'U102', '2025-03-29', 'BOT_B', 'PROJ_2', 600),
(3, 'GCP', 'U103', '2025-03-29', 'BOT_C', 'PROJ_3', 700),
(4, 'AWS', 'U101', '2025-03-28', 'BOT_A', 'PROJ_1', 550),
(5, 'Azure', 'U102', '2025-03-28', 'BOT_B', 'PROJ_2', 750),
(6, 'GCP', 'U103', '2025-03-28', 'BOT_C', 'PROJ_3', 650),
(7, 'AWS', 'U104', '2025-03-27', 'BOT_A', 'PROJ_1', 520),
(8, 'Azure', 'U105', '2025-03-27', 'BOT_D', 'PROJ_4', 620),
(9, 'GCP', 'U106', '2025-03-27', 'BOT_E', 'PROJ_5', 800),
(10, 'AWS', 'U101', '2025-03-26', 'BOT_B', 'PROJ_2', 580),
(11, 'Azure', 'U102', '2025-03-26', 'BOT_C', 'PROJ_3', 720),
(12, 'GCP', 'U103', '2025-03-26', 'BOT_A', 'PROJ_1', 500),
(13, 'AWS', 'U107', '2025-03-25', 'BOT_D', 'PROJ_4', 650),
(14, 'Azure', 'U108', '2025-03-25', 'BOT_E', 'PROJ_5', 700),
(15, 'GCP', 'U109', '2025-03-25', 'BOT_B', 'PROJ_2', 600),
(16, 'AWS', 'U110', '2025-03-29', 'BOT_F', 'PROJ_6', 900),
(17, 'Azure', 'U101', '2025-03-28', 'BOT_G', 'PROJ_7', 450),
(18, 'GCP', 'U102', '2025-03-27', 'BOT_H', 'PROJ_8', 670),
(19, 'AWS', 'U103', '2025-03-26', 'BOT_I', 'PROJ_9', 720),
(20, 'Azure', 'U104', '2025-03-25', 'BOT_J', 'PROJ_10', 580),
(21, 'GCP', 'U105', '2025-03-29', 'BOT_A', 'PROJ_2', 630),
(22, 'AWS', 'U106', '2025-03-28', 'BOT_B', 'PROJ_3', 700),
(23, 'Azure', 'U107', '2025-03-27', 'BOT_C', 'PROJ_4', 590),
(24, 'GCP', 'U108', '2025-03-26', 'BOT_D', 'PROJ_5', 860),
(25, 'AWS', 'U109', '2025-03-25', 'BOT_E', 'PROJ_6', 730);

