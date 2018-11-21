select title, rental_rate, category.name
FROM film f1,film_category, category 
where f1.rental_rate < 3 AND  f1.film_id = film_category.film_id and film_category.category_id = category.category_id AND category.name = "Comedy"and category.name="Children" and category.name="Animation" ;