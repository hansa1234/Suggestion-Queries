use epsilon_bot;

select * from access_matrix;

show processlist;
kill 3561;
kill 3567;
kill 3569;
kill 2944;
kill 2941;
Create Table cost_tracking(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    ServerType varchar(50) not null,
    UserPSNo varchar(50),
    Date_ Date not null,
    BotCode varchar(50) ,
    ProjectCode varchar(50) NULL,
    UnitsConsumed Decimal(10,2),
    FOREIGN KEY (UserPSNo) references users(UserPSNo) on delete set null,
    FOREIGN KEY (BotCode) references bots(BotCode) on delete set null,
    FOREIGN KEY (ProjectCode) references projects(ProjectCode) on delete set null
);
select * from cost_tracking;
describe access_management_request;

SELECT CONSTRAINT_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'access_matrix' 
AND TABLE_SCHEMA = DATABASE();

ALTER TABLE access_matrix DROP FOREIGN KEY access_matrix_ibfk_1; 
ALTER TABLE access_matrix DROP FOREIGN KEY access_matrix_ibfk_2; 
ALTER TABLE access_matrix DROP FOREIGN KEY access_matrix_ibfk_3;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_UserPSNo 
FOREIGN KEY (UserPSNo) REFERENCES users(UserPSNo) ON DELETE CASCADE;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_ProjectCode 
FOREIGN KEY (ProjectCode) REFERENCES projects(ProjectCode) ON DELETE CASCADE;

ALTER TABLE access_matrix 
ADD CONSTRAINT fk_access_matrix_BotCode 
FOREIGN KEY (BotCode) REFERENCES bots(BotCode) ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'access_management_request' 
AND TABLE_SCHEMA = DATABASE();

ALTER TABLE access_management_request DROP FOREIGN KEY access_management_request_ibfk_2; 
ALTER TABLE access_management_request DROP FOREIGN KEY access_management_request_ibfk_3; 

ALTER TABLE access_management_request 
ADD CONSTRAINT fk_access_management_request_BotCode 
FOREIGN KEY (BotCode) REFERENCES bots(BotCode) ON DELETE CASCADE;

ALTER TABLE access_management_request 
ADD CONSTRAINT fk_access_management_request_ProjectCode 
FOREIGN KEY (ProjectCode) REFERENCES projects(ProjectCode) ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'suggestion_queries' 
AND TABLE_SCHEMA = DATABASE();

ALTER TABLE suggestion_queries DROP FOREIGN KEY fk_suggestion_queries_request_BotCode;

ALTER TABLE suggestion_queries
ADD CONSTRAINT fk_suggestion_queries_request_BotCode 
FOREIGN KEY (BotCode) REFERENCES bots(BotCode) ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'improvement_queries' 
AND TABLE_SCHEMA = DATABASE();

ALTER TABLE improvement_queries DROP FOREIGN KEY improvement_queries_ibfk_1; 
ALTER TABLE improvement_queries DROP FOREIGN KEY improvement_queries_ibfk_2; 

ALTER TABLE improvement_queries
ADD CONSTRAINT fk_improvementt_queries_request_BotCode 
FOREIGN KEY (BotCode) REFERENCES bots(BotCode) ON DELETE CASCADE;

ALTER TABLE improvement_queries 
ADD CONSTRAINT fk_improvement_queries_request_ProjectCode 
FOREIGN KEY (ProjectCode) REFERENCES projects(ProjectCode) ON DELETE CASCADE;

#entries 

select * from users;

Insert into users(UserPSNo, UserName, Department) values
('20342184','Aditi Arora','GROUP INFORMATION TECHNOLOGY'), 
('20333353','Madhav', 'GROUP INFORMATION TECHNOLOGY'), 
('20362202','Himanshu Patel', 'GROUP INFORMATION TECHNOLOGY'), 
('20330459','Priyanka Prashar', 'GROUP INFORMATION TECHNOLOGY'), 
('998133','Dhruvang Soni', 'GROUP INFORMATION TECHNOLOGY');

select * from projects;
describe projects;

Alter table projects
add column Project_Description TEXT,
add column Project_latitude_longitude varchar(100),
add column Project_location varchar(50);

use epsilon_bot;
select * from projects;
select * from users;

delete from projects where ProjectCode ='HRRL-PFCCU';
delete from projects where ProjectCode ='HPCL-RUF';
delete from projects where ProjectCode ='HRRL-DFCU';
delete from projects where ProjectCode ='IOCL-DHDT';
delete from projects where ProjectCode ='IOCL-O&U';

insert into projects (ProjectCode, ProjectName, Project_Description, Project_latitude_longitude,Project_location) values
('HRRL-DFCU', 'HPCL Rajasthan Refinery Limited_Dual feed Cracker Unit (HRRL-DFCU)', 'Client: Hindustan Petroleum Corporation Limited (HPCL)','lat: 25.746092, lon: 71.397454', 'Barmer, Rajasthan, India'),
('HPCL-RUF', 'Hindustan Petroleum Corporation Limited - Residue Upgradation Facility (HPCL-RUF)', 'Client: Hindustan Petroleum Corporation Limited (HPCL)', 'lat: 17.68858, lon: 83.251943', 'Visakhapatnam, Andhra Pradesh, India'),
('IOCL-DHDT','Diesel Hydrotreating (IOCL-DHDT)', 'Client: Indian Oil Corporation (IOCL)','lat: 29.4676433, lon: 76.8754072' ,'Location: Panipat, India' ),
('IOCL-O&U', 'Diesel Hydrotreating (IOCL-O&U)',' Client: Indian Oil Corporation (IOCL)','lat: 21.5431241, lon: 84.6897321', 'Location: Panipat, India'),
('JGP-21', 'Jharsuguda Gas Pipeline (JGP-21)',' Client:','lat: 23.885942, lon: 45.079162',''),
('JGCP-31','Jafurah Gas Compression Project(JGP-21)','Client: SEJIN Plant Engineering/Hyundai Engineering & Construction(South Korea)','lat: 23.885942, lon: 45.079162','Location: Al Jouf Province, Saudi Arabia');

select * from access_matrix;
select * from bots;
delete from bots where BotCode ='INVOV004';

insert into bots(BotCode, BotName, BotType) values
('SPTRACKPW004','SP Track','Project-Wise'),
('SIMGRNOV005','F&A SIM GRN Chat Bot','Overall Bot'),
('BGVENDOROV006','F&A BG Vendor wise Chat Bot','Overall Bot'),
('BGCUSTOMER007','F&A BG CLIENT/CUSTOMER wise Chat Bot', 'Overall Bot');

select * from applicable_projects_bot_wise;
Insert into applicable_projects_bot_wise (BotCode , ProjectCode) values 
('PPPW002' , 'HRRL-DFCU') , 
('SPTRACKPW004','JGP-21'),
('SPTRACKPW004','JGCP-31'),
('COMPW003' , 'IOCL-DHDT') , 
('COMPW003' , 'IOCL-O&U') , 
('COMPW003' , 'HPCL-RUF');

insert into access_matrix (UserPSNo,UserRole, ProjectCode, BotCode) values
('20342184','Project Member','JGCP-31',NULL),
('20333353','Project Member', 'IOCL-DHDT',NULL),
('20362202','Bot-Owner',NULL,'SPTRACKPW004'),
('20330459','Project Member','HRRL-DFCU',NULL),
('998133','Admin', NULL, NULL);

insert into access_matrix (UserPSNo,UserRole, ProjectCode, BotCode) values
('20114582','Project Member','HPCL-RUF',NULL),
('20114582','Project Member','JGCP-31',NULL),
('20045748','Admin', NULL, NULL),
('725368','Bot-Owner',NULL, 'COMPW003');


select * from access_matrix;

Create Table positive_feedback(
    ID INT PRIMARY KEY AUTO_INCREMENT,
	UserPSNo varchar(50),
    BotCode varchar(50),
    Question TEXT not null ,
    ModelResponse TEXT not null,
    foreign key (UserPSNo) references users(UserPSNo) on delete cascade,
    foreign key (BotCode) references bots(BotCode) on delete cascade
);

select * from positive_feedback;

select * from projects;
