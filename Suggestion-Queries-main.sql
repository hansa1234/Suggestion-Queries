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

insert into access_matrix (UserPSNo,UserRole, ProjectCode, BotCode) values
('20370743','Project Member','IOCL-DHDT',NULL),
('20370743','Project Member','IOCL-O&U',NULL);
select * from users;

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

select * from users;
select * from access_matrix;
select * from access_management_request;
select * from applicable_projects_bot_wise;
select * from bots;
delete from bots where BotCode ='BGCUSTOMER007';
delete from access_matrix where UserPSNo ='20370743';
insert into access_matrix (UserPSNo, UserRole, ProjectCode, BotCode) value
('20370743','Bot-Owner',NULL,'PPPW002'),
('20370743','Project Member','HPCL-RUF',NULL);

update bots
SET BotType = 'Overall Bot'
where BotCode = 'LOGOV001';

select * from access_matrix;

update projects
SET Project_location = 'Al Jouf Province, Saudi Arabia'
where ProjectCode = 'JGCP-31';
select * from positive_feedback;

update projects
SET Project_location = 'Panipat, India'
where ProjectCode = 'IOCL-O&U';

delete from access_management_request where ID=9;
select * from access_management_request;

ALTER TABLE access_management_request
ADD COLUMN UserName varchar(100) not null;

ALTER TABLE access_management_request DROP FOREIGN KEY access_management_request_ibfk_1;

ALTER TABLE access_management_request
ADD COLUMN Department varchar(100);
describe users;
select * from suggestion_queries;

									


