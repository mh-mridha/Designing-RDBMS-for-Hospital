DROP TABLE IF EXISTS `Administrator`;

CREATE TABLE `Administrator` (
  `dept_name` varchar(16) NOT NULL,
  `budget` decimal(10,2) NOT NULL,
  `capacity` int DEFAULT NULL,
  
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Administrator` VALUES ('Cardiology',1000000.00,80),('Oncology',1000000.00,40),('Diabetes',1500000.00,50),('ENT',900000.00,30),('Orthopedic',1000000.00,80) ;



DROP TABLE IF EXISTS `Doctor`;

CREATE TABLE `Doctor` (
	`D_ID` char(5)  NOT NULL,
	`D_name` varchar(32) NOT NULL,
	`dept_name`  varchar(16) NOT NULL,
	`salary` decimal(8,2) DEFAULT NULL,
	
	PRIMARY KEY (`D_ID`),
	FOREIGN KEY (`dept_name`) references `Administrator`(`dept_name`) on delete RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Doctor` VALUES ('10101','John','Cardiology',90000.00),('12121','Mike','Oncology',90000.00),('13131','Kelly','Diabetes',70000.00),('14141','Shane','ENT',70000.00),('16161','Curl','Orthopedic',80000.00);



DROP TABLE IF EXISTS `Ward_Boys`;

CREATE TABLE `Ward_Boys` (
  `WB_ID` varchar(5) NOT NULL,
  `WB_name` varchar(32) NOT NULL,
  `dept_name` varchar(16) NOT NULL,

  PRIMARY KEY (`WB_ID`)
  FOREIGN KEY (`dept_name`) references `Administrator`(`dept_name`) on delete RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Ward_Boys` VALUES ('W1000','Finn','Cardiology'),('W1001','Ron','Oncology'),('W1002','Henry','Diabetes'),('W1003','Will','ENT'),('W1004','Bill','Orthopedic');



DROP TABLE IF EXISTS `Patient`;
CREATE TABLE `Patient` (
  `P_ID` varchar(5) NOT NULL,
  `P_name` varchar(32) NOT NULL,
  `age` int NOT NULL,
  `sex` varchar(8) NOT NULL,
  `disease` varchar(32) NOT NULL,
  `treatment` varchar(32) NOT NULL,
  `house` varchar(16) NOT NULL,
  `road` int NOT NULL,
  `city` varchar(16) NOT NULL,
  
  `D_ID` char(5)  NOT NULL,
  `dept_name` varchar(16) NOT NULL,
  `room_no` int NOT NULL,

  PRIMARY KEY (`P_ID`),
  FOREIGN KEY (`D_ID`) references `Doctor`(`D_ID`) on delete RESTRICT,
  FOREIGN KEY (`dept_name`) references `Administrator`(`dept_name`) on delete RESTRICT,
  FOREIGN KEY (`room_no`) references `Room`(`room_no`) on delete RESTRICT,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Patient` VALUES ('32321', 'Kim', 32, 'male', 'Cancer','Chemotherapy','Minic',45,'Seatle','12121','Oncology' ), ('32324', 'Karen', 32, 'female', 'Cardiac arrest','Emergency','Mineo',12,'New Jersy','10101','Cardiology' ),('32325', 'Ness', 44, 'male', 'Bone Fracture','Rehab','Merco',10,'Seatle','16161','Orthopedic' );



DROP TABLE IF EXISTS `Bill`;
CREATE TABLE `Bill` (
  `treatment` varchar(32) NOT NULL,
  `days` int NOT NULL,
  `P_ID` varchar(5) NOT NULL,
  
  PRIMARY KEY (`P_ID`),
  FOREIGN KEY (`P_ID`) references `Patient`(`P_ID`) on delete RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Bill` VALUES ('Chemotherapy', 4,'32321'), ('Emergency', 1,'32324') ('Rehab', 3,'32325');



DROP TABLE IF EXISTS `Nurses`;

CREATE TABLE `Nurses` (
  `N_ID` varchar(5) NOT NULL,
  `N_name` varchar(20) NOT NULL,
  
  PRIMARY KEY (`N_ID`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Nurses` VALUES ('N1201', 'Jenifer'),('N1202', 'Olivia'),('N1203', 'Emy'),('N1204', 'Suzan');



DROP TABLE IF EXISTS `Room`;

CREATE TABLE `Room` (
  `room_no` int NOT NULL,
  `room_type` varchar(16) NOT NULL,
  `capacity` int NOT NULL,
  
  PRIMARY KEY (`room_no`, `room_type`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Room` VALUES (101, 'ICU', 1), (102, 'ICU', 1), (103, 'CCU', 1), (201, 'Emergency', 10), (405, 'General', 100);




DROP TABLE IF EXISTS `room_nurse`;

CREATE TABLE `room_nurse` (
  `room_no` int NOT NULL,
  `N_ID` varchar(5) NOT NULL,
  
  PRIMARY KEY (`room_no`, `N_ID`),
  FOREIGN KEY (`room_no`) references `Room`(`room_no`) on delete RESTRICT,
  FOREIGN KEY (`N_ID`) references `Nurses`(`N_ID`) on delete RESTRICT,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `room_nurse` VALUES (405, 'N1201'), (201, 'N1202'), (405, 'N1203');



DROP TABLE IF EXISTS `Patient_phone_no`;

CREATE TABLE `Patient_phone_no` (
  `phone_no` varchar(10) NOT NULL,
  `P_ID` varchar(5) NOT NULL,
  
  PRIMARY KEY (`phone_no`, `P_ID`),
  FOREIGN KEY (`P_ID`) references `Patient`(`P_ID`) on delete RESTRICT,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Patient_phone_no` VALUES ('32321', '0123456789'), ('32324', '0213456789'), ('32325', '0321456789');


