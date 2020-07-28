DROP DATABASE IF EXISTS MovieCatalogue;

CREATE DATABASE MovieCatalogue;

USE MovieCatalogue;

CREATE TABLE Genre (
    GenreId INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(30) NOT NULL
);

CREATE TABLE Director (
    DirectorId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate CHAR(10) NULL
);

CREATE TABLE Rating (
    RatingId INT PRIMARY KEY AUTO_INCREMENT,
    RatingName CHAR(5) NOT NULL
);

CREATE TABLE Actor (
    ActorId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate CHAR(10) NULL
);

-- below tables contain fk's
CREATE TABLE Movie (
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

CREATE TABLE CastMember (
    CastMemberId INT PRIMARY KEY AUTO_INCREMENT,
    `Role` VARCHAR(50) NOT NULL,
    ActorId INT NOT NULL,
    MovieId INT NOT NULL,
    CONSTRAINT `fk_CastMembers_Actor` FOREIGN KEY (ActorId)
        REFERENCES Actor (ActorId),
    CONSTRAINT `fk_CastMembers_Movie` FOREIGN KEY (MovieId)
        REFERENCES Movie (MovieId)
);

-- ex3 manipulations
-- insertions 
INSERT INTO Actor (ActorId, FirstName, LastName, BirthDate)
	VALUES
		(1, 'Bill', 'Murray', '1950-09-21'),
        (2, 'Dan', 'Aykroyd', '1952-07-01'),
        (3, 'John', 'Candy', '1950-10-31'),
        (4, 'Steve', 'Martin', NULL),
        (5, 'Sylvester', 'Stallone', NULL);

INSERT INTO Director(DirectorId, FirstName, LastName, BirthDate)
	VALUES
		(1, 'Ivan', 'Reitman', '1946-10-27'),
        (2, 'Ted', ' Kotcheff', NULL);
        
INSERT INTO Rating (RatingId, RatingName)
	VALUES
		(1, 'G'),
        (2, 'PG'),
        (3, 'PG-13'),
        (4, 'R');

INSERT INTO Genre (GenreId, GenreName)
	VALUES
		(1 , 'Action'),
        (2 , 'Comedy'),
        (3 , 'Drama'),
        (4 , 'Horror');

INSERT INTO Movie (MovieId, GenreId, DirectorId, RatingId, Title, ReleaseDate)
	VALUES
		(1, 1, 2, 4, 'Rambo: First Blood', '1982-10-22'),
        (2, 2, NULL, 4, 'Planes, Trains & Automobiles', '1987-11-25'),
        (3, 2, 1, 2, 'Ghostbusters', NULL),
        (4, 2, NULL, 2, 'The Great Outdoors', '1988-06-17');

INSERT INTO CastMember (CastMemberId, ActorId, MovieId, `Role`)
	VALUES
		(1, 5, 1, 'John Rambo'),
        (2, 4, 2, 'Neil Page'),
        (3, 3, 2, 'Del Griffith'),
        (4, 1, 3, 'Dr. Peter Venkman'),
        (5, 2, 3, 'Dr. Raymond Stanz'),
        (6, 2, 4, 'Roman Craig'),
        (7, 3, 4, 'Chet Ripley');
        
-- checks, turn on to check against the changes made for updates and deletions
-- SELECT * FROM Actor;
-- SELECT * FROM Director;
-- SELECT * FROM Rating;
-- SELECT * FROM Genre;
-- SELECT * FROM Movie;
-- SELECT * FROM CastMember;

UPDATE Movie 
SET 
    Title = 'Ghostbusters (1984)',
    ReleaseDate = '1984-06-08'
WHERE
    MovieId = 3;

-- SELECT * FROM Movie;

UPDATE Genre 
SET 
    GenreName = 'Action/Adventure'
WHERE
    GenreId = 1;

-- SELECT * FROM Genre;

-- Deletions
DELETE FROM CastMember
WHERE MovieId = 1;

DELETE FROM Movie
WHERE MovieId = 1;

DELETE FROM Movie
WHERE MovieId = 1;

-- SELECT * FROM CastMember;
-- SELECT * FROM Movie;

-- Alterations
