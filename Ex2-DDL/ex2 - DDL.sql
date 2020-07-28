DROP DATABASE IF EXISTS MovieCatalogue;

CREATE DATABASE MovieCatalogue;

USE MovieCatalogue;

CREATE TABLE Genre(
	GenreId INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(30) NOT NULL
);

CREATE TABLE Director(
	DirectorId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate CHAR(10) NULL
);

CREATE TABLE Rating(
	RatingId INT PRIMARY KEY AUTO_INCREMENT,
    RatingName CHAR(5) NOT NULL
);

CREATE TABLE Actor(
	ActorId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate CHAR(10) NULL
);

-- below tables contain fk's
CREATE TABLE Movie(
	MovieId INT PRIMARY KEY AUTO_INCREMENT,
    GenreId INT NOT NULL,
    DirectorId INT NULL,
    RatingId INT NOT NULL,
    Title VARCHAR(128) NOT NULL,
    ReleaseDate CHAR(10) NULL,
    CONSTRAINT `fk_Movie_Genre` FOREIGN KEY (GenreId)
		REFERENCES Genre (GenreId),
	CONSTRAINT `fk_Movie_Director` FOREIGN KEY (DirectorId)
		REFERENCES Director (DirectorId),
	CONSTRAINT `fk_Movie_Rating` FOREIGN KEY (RatingId)
		REFERENCES Rating (RatingId)
);

CREATE TABLE CastMember(
	CastMemberId INT PRIMARY KEY AUTO_INCREMENT,
    `Role` VARCHAR(50) NOT NULL,
    ActorId INT NOT NULL,
    MovieId INT NOT NULL,
    CONSTRAINT `fk_CastMembers_Actor` FOREIGN KEY (ActorId)
		REFERENCES Actor (ActorId),
	CONSTRAINT `fk_CastMembers_Movie` FOREIGN KEY (MovieId)
		REFERENCES Movie (MovieId)
);