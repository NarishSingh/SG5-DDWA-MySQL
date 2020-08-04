DROP DATABASE IF EXISTS Hotel;
CREATE DATABASE Hotel;
USE Hotel;

--  room children
CREATE TABLE RoomType(
	TypeId INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(6) NOT NULL,
    BasePrice DECIMAL(5,2) NOT NULL,
    ExtraPersonFee DECIMAL(4,2) NOT NULL,
    StandardOccupany INT,
    MaxOccupancy INT NOT NULL
);

CREATE TABLE RoomAmenity(
	AmenityId INT PRIMARY KEY AUTO_INCREMENT,
	AdaAccessible BOOLEAN NOT NULL,
    HasMicrowave BOOLEAN NOT NULL,
    HasJacuzzi BOOLEAN NOT NULL,
    HasOven BOOLEAN NOT NULL,
    HasRefrigerator BOOLEAN NOT NULL
);

-- guest child
CREATE TABLE GuestAddress(
	AddressId INT PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    ZipCode CHAR(5) NOT NULL
);

-- parent tables 
CREATE TABLE Room(
	RoomNum INT PRIMARY KEY,
    TypeId INT NOT NULL,
    AmenityId INT NOT NULL,
    CONSTRAINT `fk_Room_RoomType` FOREIGN KEY (TypeId)
		REFERENCES RoomType(TypeId),
	CONSTRAINT `fk_Room_RoomAmenity` FOREIGN KEY (AmenityId)
		REFERENCES RoomAmenity(AmenityId)
);

CREATE TABLE Guest(
	NameId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber CHAR(12) NOT NULL,
    AddressId INT NOT NULL,
    CONSTRAINT `fk_Room_Guest` FOREIGN KEY (AddressId)
		REFERENCES GuestAddress(AddressId)
);

CREATE TABLE Reservation(
	ReservationId INT PRIMARY KEY AUTO_INCREMENT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    AdultCount INT NOT NULL,
    ChildCount INT NOT NULL,
    TotalRoomCost DECIMAL(6,2) NOT NULL,
    NameId INT NOT NULL,
    RoomNum INT NOT NULL,
    CONSTRAINT `fk_Reservation_Guest` FOREIGN KEY (NameId)
		REFERENCES Guest(NameId),
	CONSTRAINT `fk_Reservation_Room` FOREIGN KEY(RoomNum)
		REFERENCES Room(RoomNum)
);