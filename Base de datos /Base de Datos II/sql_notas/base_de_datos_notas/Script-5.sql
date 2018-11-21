#date, datetime, TIMESTAMP
#Devuelve el título y el lenguaje de un film, dónde la duración del mismo es mayor a 100 minutos y el lenguaje es inglés.
#Devuelve el título y el lenguaje de un film, siempre y cuando se cumplan todas las condiciones de la clausula WHERE.
#SELECT film.title, language.name FROM film, `language` WHERE film.language_id = language.language_id AND film.`length` > 100 AND language.name = 'English';
#Una tabla film con 5 columnas y una de ellas es primary key.


#Solo para las películas de menor duración, mostrar los actores que actuaron en ellas.
#No usar agregaciones (MIN, MAX, etc). No usar valores directamente, por ejemplo en Sakila las películas de menor duración son de 46 minutos. 
#No usar el valor 46 en la query. La query tiene que ser lo suficientemente general como para funcionar en cualquier caso.
#Las columnas a mostrar son el título del film, la duración, el nombre y apellido del actor. 
#Nota, el título y la duración se van a repetir en cada fila por cada actor que haya trabajado en dicha película.

SELECT title,`length`, actor.first_name, actor.last_name 
  FROM film f1, actor, film_actor
  	where EXISTS(select *
					from film f2
					where f1.film_id = f2.film_id)
AND NOT EXISTS (SELECT * 
                     FROM film f3, film_actor
                    WHERE f3.`length` < f1.`length`); 
                    
SELECT film.title, film.`length`, actor.first_name, actor.last_name
FROM film, actor
WHERE actor.actor_id IN (SELECT f_a.actor_id FROM film_actor f_a
                WHERE f_a.actor_id = actor.actor_id
                AND film.film_id = f_a.film_id)
AND film.film_id IN (SELECT f1.film_id
                        FROM film f1
                        WHERE NOT EXISTS (SELECT * FROM film f2
                                        WHERE f1.`length` > f2.`length`))
                    
 ##Mostrar los filmes cuya categorías sean 'Comedy', 'Children' o 'Animation' donde el valor del alquiler (rental_rate) sea menor a 3 dólares 7
 #El reporte tiene que estar ordenado alfabéticamente por categoría, 
 #luego por el rental_rate de menor a mayor y luego el titulo de la película alfabéticamente.
 
SELECT title, rental_rate
FROM film, film_actor, film_category
where(rental_rate < 3)
and film.film_id IN(SELECT *
		from film, film_category
		where film.film_id = film_category.film_id and category.name="Comedy" or category.name="Children" or category.name="Animation" );
		
SELECT film.title, category.name, film.rental_rate
FROM film, film_category, category
WHERE film.film_id=film_category.film_id
AND film_category.category_id=category.category_id
AND (category.name LIKE ('Comedy') OR category.name LIKE ('Children') OR category.name LIKE ('Animation'))
AND film.rental_rate < 3
ORDER BY category.name, film.rental_rate ASC, film.title;


#todas las direcciones (address) almacenadas en la DB sakila de los países que terminen con la letra 
#'a' (minúscula) y cuya cuidad empiece con la letra 'E' (mayúscula)	
SELECT address
FROM address, city,country
where(address.city_id = city.city_id AND city.country_id = country.country = "%a" and city.city="E%");

SELECT country.country, city.city, address.address, address.district, address.postal_code
FROM country, city, address
WHERE country.country_id = city.country_id
AND city.city_id = address.city_id
AND country.country LIKE '%a'
AND city.city LIKE 'E%';
