-- Get the amount of cities per country in the database. 
-- Sort them by country, country_id.

SELECT country.country_id,country.country, COUNT(*)
 from city, country
 where country.country_id = city.country_id
 group by country, country.country_id order by country_id 
 
-- Get the amount of cities per country in the database. 
-- Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest   

 SELECT country.country_id,country.country, COUNT(*)
 from city, country
 where country.country_id = city.country_id
 group by country, country.country_id  
  HAVING COUNT(*)>10 
  order by COUNT(*) DESC
  
-- Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. 
-- Show the ones who spent more money first .

SELECT payment.customer_id, SUM(amount),customer.last_name, customer.first_name, address.address, COUNT(rental.rental_id)-- , address.address, customer.last_name-- , SUM(amount), rental_id
from payment,customer,address, rental
where payment.customer_id = customer.customer_id and customer.address_id = address.address_id and customer.customer_id = rental.customer_id
GROUP by payment.customer_id, customer.last_name, customer.first_name, address.address, rental.customer_id
ORDER BY SUM(amount) DESC;


-- Find all the film titles that are not in the inventory

select title
FROM film
where film_id NOT IN  (select film_id 
						 from inventory
						 group by (film_id )order by film_id);
						 
-- Find all the films that are in the inventory but were never rented. 
-- Show title and inventory_id.
-- hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null						  
select title, inventory_id
FROM film, inventory
where film.film_id = inventory.film_id
AND film.film_id IN  (select film_id 
						 from inventory
						 group by (film_id )order by film_id)
AND title  NOT IN (SELECT DISTINCT film.title -- Muestra una vez el titulo y no cada vez que este en cada tabla como uno distinto y diferente 
FROM film, inventory, rental
WHERE film.film_id = inventory.film_id
AND inventory.inventory_id = rental.inventory_id);

-- Generate a report with:
-- customer (first, last) name, store id, film title,
-- when the film was rented and returned for each of these customers
-- order by store_id, customer last_name

select *
from rental
where return_date is NULL ;

select customer.first_name, customer.last_name, store.store_id, film.title
from rental, film,customer,store, staff, inventory
where return_date is NULL 
    and rental.customer_id = customer.customer_id
    and store.store_id = staff.store_id
    and staff.staff_id = rental.staff_id
    and film.film_id = inventory.film_id
    and inventory.inventory_id = rental.inventory_id
order by store.store_id, customer.last_name;

-- Show sales per store 
-- show store citi, country, manager info and total sales
-- (optional) Use concat to show city and country and manager first and last name

select CONCAT(staff.first_name,'',staff.last_name) as manager , CONCAT(city.city,'',country.country) as store , SUM(payment.amount) as total
FROM store, city, country, staff, address, payment, rental, inventory
where payment.rental_id = rental.rental_id and rental.inventory_id  = inventory.inventory_id and inventory.store_id = store.store_id
and store.address_id = address.address_id and address.city_id = city.city_id and city.country_id = country.country_id
and store.manager_staff_id = staff.staff_id
group by staff.first_name, staff.last_name, city.city, country.country
order by country.country, city.city;

-- Show sales per film rating

select film.rating, SUM(payment.amount)
from film, inventory, rental, payment
where film.film_id = inventory.film_id and inventory.inventory_id = rental.inventory_id and rental.rental_id = payment.rental_id
group by film.rating;

-- Which actor has appeared in the most films

select actor.actor_id,actor.first_name, actor.last_name, COUNT(actor.actor_id)
from film_actor, actor
where actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by count(actor.actor_id) desc 
limit 1;

-- Which film categories have the larger film duration (comparing average)?
-- Order by average in descending order

select category.name, avg(`length`)
from film, category, film_category
where film.film_id = film_category.film_id and film_category.category_id = category.category_id
group by category.name
order by AVG(`length`) DESC;

