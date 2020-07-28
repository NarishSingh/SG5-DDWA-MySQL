USE sakila;

-- inner joins 
SELECT a.address, c.city, a.postal_code FROM Address a
INNER JOIN City c
ON a.city_id = c.city_id

INNER JOIN Country t
ON c.country_id = t.country_id;

-- counting countries
SELECT t.country_id, t.country, COUNT(*) from Address a
INNER JOIN City c
ON a.city_id = c.city_id
INNER JOIN Country t
ON c.country_id = t.country_id
GROUP BY t.country
ORDER BY COUNT(*) DESC;