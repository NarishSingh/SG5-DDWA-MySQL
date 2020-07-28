USE sakila;

SELECT a.* FROM Actor a
-- WHERE a.last_name = "Chase"; -- quality
-- WHERE a.last_name LIKE "Chase"; -- disregards casing
-- WHERE a.last_name LIKE "Ch%"; -- wildcard, any amount of letters
-- WHERE a.last_name LIKE "Ch___"; -- wildcard, one _ = 1 letter at a time

WHERE a.last_name LIKE "%CH%"
-- ORDER BY a.last_name DESC; -- descending sort
GROUP BY a.last_name; -- get a single last name at a time

-- aggregate functions w grouping
SELECT COUNT(*) FROM Actor a
WHERE a.last_name LIKE "%CH%"
GROUP BY a.last_name;

SELECT a.first_name, a.last_Name, COUNT(*) FROM Actor a
INNER JOIN film_actor b
ON a.actor_id = b.actor_id
INNER JOIN film f
GROUP BY a.actor_id
ORDER BY COUNT(*) DESC;

SELECT a.first_name, a.last_Name, c.name as "Category", COUNT(c.name) FROM Actor a
INNER JOIN film_actor b
ON a.actor_id = b.actor_id
INNER JOIN film f
ON b.film_id = f.film_id
INNER JOIN film_category b2
on f.film_id = b2.film_id
INNER JOIN category c
ON b2.category_id = c.category_id
GROUP BY a.actor_id, c.category_id
ORDER BY COUNT(c.name) DESC;

-- find films w woman in description 
SELECT f.title FROM film f
INNER JOIN film_text b
ON f.film_id = b.film_id
WHERE b.description LIKE "%woman%";

-- find count of films in each language
SELECT f.language_id, l.name, COUNT(f.language_id) FROM film f
INNER JOIN language l
ON f.language_id = l.language_id
GROUP BY l.name;

-- find number of customers for each store
SELECT c.store_id, COUNT(c.customer_id) FROM Customer c
INNER JOIN Store s
ON s.store_id = c.store_id
GROUP BY s.store_id;

-- same as above but only 1 table used, no join needed
SELECT c.store_id, COUNT(*) FROM Customer c
GROUP BY c.store_id;

-- find staff member w most processed payments
SELECT s.first_name, s.last_name, COUNT(p.payment_id), SUM(p.amount) FROM Staff s
INNER JOIN Payment p
ON s.staff_id = p.staff_id
GROUP BY s.staff_id
-- ORDER BY COUNT(p.payment_id) DESC
ORDER BY SUM(p.amount) DESC
LIMIT 5;