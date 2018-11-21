SELECT film.title, film.`length`, actor.first_name, actor.last_name
FROM film, actor
WHERE actor.actor_id IN (SELECT f_a.actor_id FROM film_actor f_a
                WHERE f_a.actor_id = actor.actor_id
                AND film.film_id = f_a.film_id)
AND film.film_id IN (SELECT f1.film_id
                        FROM film f1
                        WHERE NOT EXISTS (SELECT * FROM film f2
                                        WHERE f1.`length` > f2.`length`))



SELECT country.country, city.city, address.address, address.district, address.postal_code
FROM country, city, address
WHERE country.country_id = city.country_id
AND city.city_id = address.city_id
AND country.country LIKE '%a'
AND city.city LIKE 'E%';



SELECT film.title, category.name, film.rental_rate
FROM film, film_category, category
WHERE film.film_id=film_category.film_id
AND film_category.category_id=category.category_id
AND (category.name LIKE ('Comedy') OR category.name LIKE ('Children') OR category.name LIKE ('Animation'))
AND film.rental_rate < 3
ORDER BY category.name, film.rental_rate ASC, film.title;
