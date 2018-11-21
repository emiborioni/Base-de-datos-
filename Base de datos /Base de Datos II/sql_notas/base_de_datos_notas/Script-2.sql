SELECT title,special_features,rating FROM film where rating = "PG-13";
SELECT title,`length` from film;
SELECT title, rental_rate,replacement_cost from film where replacement_cost > 20.00 and replacement_cost < 24.00;
SELECT f.title,f.rating  from film f, film_category fc , category c where special_features ='Behind the Scenes';
SELECT a.address, c.city, co.country, s.store_id FROM address a, city c, country co, store s WHERE s.address_id = a.address_id AND a.city_id=c.city_id AND c.country_id = co.country_id AND s.store_id = 1;
SELECT f1.title, f2.title, f1.rating from film f1, film f2 where f1.rating <> f2.rating ;
SELECT DISTINCT film.title, staff.first_name, staff.last_name FROM film, inventory, store, staff WHERE film.film_id = inventory.film_id AND store.store_id = inventory.store_id AND store.store_id = 2 AND staff.staff_id = store.manager_staff_id;



SELECT first_name,last_name 
	FROM actor a1 
 WHERE EXISTS (SELECT * 
                FROM actor a2
                WHERE a1.last_name=a2.last_name && a1.actor_id<>a2.actor_id);
                
#Find actors that don't work in any film
select last_name 
	from actor a1

where not exists(select *
					from film_actor fa2
						where a1.actor_id = fa2.actor_id);
#Find customers that rented only one film
#Find customers that rented more than one film
SELECT actor_id, first_name, last_name, f1.`length`     
  FROM actor, film f1
 WHERE actor_id IN (SELECT actor.actor_id
                      FROM film_actor, actor, film f1, film f2
                     WHERE f2.`length` < f1.`length`);
                       
#List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'  film. id == film.title = "Betrayed rear" or "otro coso"
select actor_id
	from film_actor fa1
where (select *
			from film f1, film_actor fa1, actor a1
				where (f1.description="BETRAYED REAR").film_id = )