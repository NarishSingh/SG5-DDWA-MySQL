DROP DATABASE IF EXISTS Hotel;
CREATE DATABASE Hotel;
USE Hotel;

--  room children
CREATE TABLE RoomType (
    RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(6) NOT NULL,
    BasePrice DECIMAL(5, 2) NOT NULL,
    ExtraPersonFee DECIMAL(4, 2) NOT NULL,
    StandardOccupany INT,
    MaxOccupancy INT NOT NULL
);

CREATE TABLE Amenity (
	AmenityId INT PRIMARY KEY AUTO_INCREMENT,
    AmenityName VARCHAR(15) NOT NULL,
    AmenityCost DECIMAL(4, 2) NOT NULL
);

-- guest child
CREATE TABLE GuestAddress (
    GuestAddressId INT PRIMARY KEY,
    Address VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    ZipCode CHAR(5) NOT NULL
);

-- parent tables 
CREATE TABLE Room (
    RoomNum INT PRIMARY KEY,
    RoomTypeId INT NOT NULL,
    AdaAccessible BOOLEAN NOT NULL,
    CONSTRAINT `fk_Room_RoomType` FOREIGN KEY (RoomTypeId)
        REFERENCES RoomType (RoomTypeId)
); 

-- -- RoomAmenity bridge table
CREATE TABLE RoomAmenity (
    RoomNum INT NOT NULL,
    AmenityId INT NOT NULL,
    PRIMARY KEY (RoomNum, AmenityId),
    CONSTRAINT `fk_RoomAmenity_AmenityId` FOREIGN KEY (AmenityId)
		REFERENCES Amenity (AmenityId),
	CONSTRAINT `fk_RoomAmenity_RoomNum` FOREIGN KEY (RoomNum)
		REFERENCES Room (RoomNum)
);

CREATE TABLE Guest (
    GuestID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber CHAR(12) NOT NULL,
    GuestAddressId INT NOT NULL,
    CONSTRAINT `fk_Guest_GuestAddress` FOREIGN KEY (GuestAddressId)
        REFERENCES GuestAddress (GuestAddressId)
);

CREATE TABLE Reservation (
    ReservationId INT PRIMARY KEY AUTO_INCREMENT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    AdultCount INT NOT NULL,
    ChildCount INT NOT NULL,
    TotalRoomCost DECIMAL(6, 2) NOT NULL,
    GuestID INT NOT NULL,
    RoomNum INT NOT NULL,
    CONSTRAINT `fk_Reservation_Guest` FOREIGN KEY (GuestID)
        REFERENCES Guest (GuestID),
    CONSTRAINT `fk_Reservation_Room` FOREIGN KEY (RoomNum)
        REFERENCES Room (RoomNum)
); 