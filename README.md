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




