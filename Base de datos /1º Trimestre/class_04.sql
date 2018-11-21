SELECT title,special_features,rating FROM film where rating = "PG-13";
SELECT title,`length` from film;
SELECT title, rental_rate,replacement_cost from film where replacement_cost > 20.00 and replacement_cost < 24.00;
SELECT film.title, category.name, film.rating from film,category,film_category WHERE film.film_id =film_category.film_id AND film_category.category_id AND film.special_features LIKE '%Behind the Scenes%';
SELECT actor.first_name,actor.last_name from actor,film where film.title LIKE '%ZOOLANDER FICTION%';
SELECT a.address, c.city, co.country, s.store_id FROM address a, city c, country co, store s WHERE s.address_id = a.address_id AND a.city_id=c.city_id AND c.country_id = co.country_id AND s.store_id = 1;
SELECT f1.title, f2.title, f1.rating from film f1, film f2 where f1.rating <> f2.rating ;
SELECT DISTINCT film.title, staff.first_name, staff.last_name FROM film, inventory, store, staff WHERE film.film_id = inventory.film_id AND store.store_id = inventory.store_id AND store.store_id = 2 AND staff.staff_id = store.manager_staff_id;
