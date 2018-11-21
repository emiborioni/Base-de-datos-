SELECT title,special_features,rating FROM film where rating = "PG-13";
SELECT title,`length` from film;
SELECT title, rental_rate,replacement_cost from film where replacement_cost > 20.00 and replacement_cost < 24.00;
SELECT film.title, category.name, film.rating from film,category,film_category WHERE film.film_id =film_category.film_id AND film_category.category_id AND film.special_features LIKE '%Behind the Scenes%';
SELECT actor.first_name,actor.last_name from actor,film where film.title LIKE '%ZOOLANDER FICTION%';

