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
    FOREIGN KEY fk_Movie_Genre(GenreId)
		REFERENCES Genre(GenreId),
	FOREIGN KEY fk_Movie_Director(DirectorId)
		REFERENCES Director(DirectorId),
	FOREIGN KEY fk_Movie_Rating(RatingId)
		REFERENCES Rating(RatingId),
	Title VARCHAR(128) NOT NULL,
    ReleaseDate CHAR(10) NULL
);

CREATE TABLE CastMembers(
	CastMemberId INT PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY fk_CastMembers_Actor(ActorId)
		REFERENCES Actor(ActorId),
	FOREIGN KEY fk_CastMembers_Movie(MovieId)
		REFERENCES Movie(MovieId),
	Role VARCHAR(50) NOT NULL
);