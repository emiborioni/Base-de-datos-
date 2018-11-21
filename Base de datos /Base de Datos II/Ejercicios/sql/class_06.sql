#List all the actors that share the last name. Show them in order
SELECT first_name,last_name 
	FROM actor a1 
 WHERE EXISTS (SELECT * 
                FROM actor a2
                WHERE a1.last_name=a2.last_name && a1.actor_id<>a2.actor_id)
                ORDER BY last_name, first_name;

SELECT COUNT(*) from actor;             
#Find actors that don't work in any film
select last_name, actor_id 
	from actor a1
where not exists(select *
					from film_actor fa2
						where a1.actor_id = fa2.actor_id);
#Find customers that rented only one film
SELECT *
FROM customer q1
WHERE EXISTS (
    SELECT *
    FROM rental q2
    WHERE q1.customer_id = q2.customer_id
    AND NOT EXISTS (
        SELECT *
        FROM rental q3
        WHERE q1.customer_id = q3.customer_id
        AND q2.rental_id <> q3.rental_id
    )
);
#Find customers that rented more than one film
SELECT *
FROM customer q1
WHERE EXISTS (
    SELECT *
    FROM rental q2
    WHERE q1.customer_id = q2.customer_id
    AND EXISTS (
        SELECT *
        FROM rental q3
        WHERE q1.customer_id = q3.customer_id
        AND q2.rental_id <> q3.rental_id
    )ORDER by q1.last_name
);
#List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'  film. id == film.title = "Betrayed rear" or "otro coso"
SELECT *
FROM actor a1
WHERE EXISTS(
    SELECT *
    FROM film_actor fa1, film f1
    WHERE a1.actor_id = fa1.actor_id
    AND fa1.film_id = f1.film_id
    AND f1.title IN ('BETRAYED REAR', 'CATCH AMISTAD'));

#List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR") 
   AND a.actor_id NOT IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;

# List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR")# comparar los mismos id y encima mismo titulo 
   AND a.actor_id IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;

# List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id NOT IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR")# comparar los mismos id y encima mismo titulo 
   OR a.actor_id NOT IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;
