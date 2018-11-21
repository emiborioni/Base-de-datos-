# class 15 
#1
CREATE OR REPLACE VIEW list_of_customer AS 
  SELECT customer_id, CONCAT(first_name ," ", last_name) AS full_name , address.address, address.postal_code, address.phone, city.city, country.country, store_id
  FROM customer 
  INNER JOIN address using (address_id)
  INNER JOIN city  using (city_id) 
  INNER join country  using (country_id);
 
 select * from list_of_customer;
#2
#Create a view named film_details, it should contain the following columns:
#film id,  title, description,  category,  price,  length,  rating, actors  - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

 
 CREATE OR REPLACE VIEW film_details AS
 SELECT film_id, title, description,`length`, rating, category.name,replacement_cost, group_concat(actor.first_name, actor.last_name)
 from film
 INNER JOIN film_category USING (film_id)
 INNER JOIN category USING (category_id)
 INNER JOIN film_actor USING(film_id)
 INNER JOIN actor USING(actor_id)
 group by film_id, title, description,`length`, rating, category.name,replacement_cost
 
 select * from film_details ;
#3
 #Create view sales_by_film_category, it should return 'category' and 'total_rental' columns. SUM(payment.amount)
 CREATE OR REPLACE VIEW sales_by_film_category AS
 select name, SUM(payment.amount)
 from category
 INNER JOIN film_category USING(category_id)
 INNER JOIN film USING(film_id)
 INNER JOIN inventory USING(film_id)
 INNER JOIN rental USING(inventory_id)
 INNER JOIN payment USING(rental_id)
 group by name
 
 select * from sales_by_film_category ; 

#4
#Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

 CREATE OR REPLACE VIEW actor_information AS
 select actor_id, first_name, last_name, COUNT(film_actor.actor_id)
 from actor
 INNER join film_actor USING (actor_id)
 where (film_actor.actor_id = actor.actor_id)
 group by actor_id
 ; 
 
 select * from actor_information; 

#5
#Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each. 

# La view actor_info se utiliza para que cada vez que necesitemos saber cuantas veces participo en peliculas un actor tengamos que escribir toda la query entera.
# Lo que realiza la query es extraer de la tabla actor los siguientes parametros (actor_id, first_name, last_name)y de la tabla film_actor, se coloca un contador del campo actor_id cuando el id 
# coincida con el de la tabla actor en el campo actor_id, pero como se encuentra en una tabla distinta necesitamos realizar un inner join que nos vincule dichas tablas, 
# luego de esto para que ordene en cuantas peliculas actuo cada uno realizamos un group by el cual agrupara todos los resultados que tengan el mismo campo actor_id. 


#EJERCICIO COPIADO A MONTANE 

#5
#we select id, firstname, lastname  del actor 
SELECT a.actor_id AS actor_id, a.first_name AS first_name, a.last_name AS last_name,
	# then we concatenate the category name and 
    group_concat(
    DISTINCT concat(
    	c.name, ': ', (
    	# the movies that have that category and the actor in it
    	SELECT group_concat(f.title ORDER BY f.title ASC separator ', ')
                FROM sakila.film f 
                # here we join the tables
                	JOIN sakila.film_category fc ON(f.film_id = fc.film_id)
                    JOIN sakila.film_actor fa ON(f.film_id = fa.film_id)
                #and check that the actor and the category are the saem
                WHERE fc.category_id = c.category_id
                    AND fa.actor_id = a.actor_id)
        )
    	ORDER BY c.name ASC SEPARATOR '; ') AS film_info 
    # we add all the tables
    FROM sakila.actor a
    	LEFT JOIN sakila.film_actor fa ON(a.actor_id = fa.actor_id)
        LEFT JOIN sakila.film_category fc ON(fa.film_id = fc.film_id)
    	LEFT JOIN sakila.category c ON(fc.category_id = c.category_id)
# group by actors so that we can group concat
GROUP BY a.actor_id, a.first_name, a.last_name

SELECT * FROM actor_info

#6
#Materialized views are views that write the result of the query they run in a temporary table.
#this allows the search to be quicker but if data changes and the view is not refreshed the data will
#be out of date. This is used for data that doesn't change and to take statistics of the day before. They exist in 
# Oracle - PostgreSQL - SQL Server - Apache Kafkaand and Apache Spark -  Sybase SQL - IBM DB2 - Microsoft SQL Server 
