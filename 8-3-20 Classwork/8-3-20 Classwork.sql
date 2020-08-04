USE Sakila;
-- DML 

-- insertion
-- one
INSERT INTO Actor(first_name, last_name, last_update)
	VALUES ('Shazena', 'K', NOW()); -- now() inserts current date date

-- multiple
INSERT INTO Actor(first_name, last_name, last_update)
	VALUES 
		('Chelsea', 'M', NOW()),
		('Karma', 'D', NOW());

INSERT INTO Actor(Actor_id, first_name, last_name, last_update)
	VALUES (205, 'Narish', 'S', NOW()); -- not recommended, let it auto++ generate the id

INSERT INTO Actor(first_name, last_name, last_update)
	VALUES ('Kristine', 'Z', NOW()); -- since we skipped 204, it will NOT go back and fill that place
    
-- into a foreign key
SELECT * FROM film; 
SELECT * FROM film_actor; 

-- Chelsea in African Egg 
INSERT INTO film_actor (actor_id, film_id, last_update)
	VALUES (202, 5, NOW());
    
SELECT * FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
WHERE f.film_id = 5;

-- all in Baby Hall 
INSERT INTO film_actor (actor_id, film_id, last_update)
	VALUES 
		(201, 47, NOW()),
		(202, 47, NOW()),
        (203, 47, NOW()),
        (205, 47, NOW()),
        (206, 47, NOW());

SELECT * FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
WHERE f.film_id = 47;

-- updates
-- update at 201
UPDATE actor SET
	first_name = 'Chelsea',
    last_name = 'M',
    last_update = NOW()
WHERE actor_id = 201;

UPDATE actor SET
	first_name = 'Karma',
    last_name = 'D',
    last_update = NOW()
WHERE actor_id = 203;

-- deletion
-- no orphan data - MUST remove the constraints/child data first
-- take Khristina out of film_actor bridge table before taking out of actor table
DELETE FROM film_actor
WHERE actor_id = 206;
DELETE FROM actor
WHERE actor_id = 206;

-- delete all
DELETE FROM film_actor
WHERE actor_id > 200;
DELETE FROM actor
WHERE actor_id > 200;

SELECT * FROM Actor ORDER BY actor_id DESC;