-- ESTO BUSCA TODOS LOS QUE ALQUILARON UNA PELICULA 
SELECT c.customer_id, first_name, last_name, COUNT(*)
  FROM rental r1, customer c
 WHERE c.customer_id = r1.customer_id
GROUP BY c.customer_id, first_name, last_name
HAVING COUNT(*) = 1; --  Si le saco el = 1 me da todos los que alquilaron alguna pelicula 

-- ESTO BUSCA TODOS LOS QUE ALQUILARON MAS DE UNA PELICULA 
SELECT c.customer_id, first_name, last_name, COUNT(*)
  FROM rental r1, customer c
 WHERE c.customer_id = r1.customer_id
GROUP BY c.customer_id, first_name, last_name
HAVING COUNT(*) > 1;  -- SE PUEDE NO PONER EL >1 

-- Show the films' ratings where the minimum film duration in that group is greater than 46
SELECT rating, MIN(`length`)
FROM film
GROUP BY rating
HAVING MIN(`length`) > 46;

-- Show ratings that have less than 195 films
SELECT rating AS total
FROM film
GROUP BY rating -- ; me da los 5 por que agrupa a todos
HAVING COUNT(*) < 195;  -- limita a los que luego de hacerle el count da menor a 195 

-- same but with subqueries
SELECT DISTINCT rating,
(SELECT COUNT(*) FROM film f3 WHERE f3.rating = f1.rating) AS total
FROM film f1
WHERE (SELECT COUNT(*) 
FROM film f2 WHERE f1.rating = f2.rating) < 195; 

-- Show ratings where their film duration average is grater than all films duration average.
SELECT rating, AVG(`length`)
FROM film
GROUP BY rating
HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film); 

EXPLAIN -- EXPLICA LO QUE HACE EL MOTOR PARA TRAER LAS COSAS
SELECT *
  FROM film
      INNER JOIN `language`
              ON film.language_id = `language`.language_id;
EXPLAIN             
SELECT * 
  FROM `language`, film 
 WHERE film.language_id = `language`.language_id ;        
 
 select film_id 
 from inventory
 group by (film_id )order by film_id;
 
 SELECT *
FROM film q1
WHERE EXISTS (
    SELECT *
    FROM rental q2
    WHERE q1.film_id = q2.film_id
    AND EXISTS (
        SELECT *
        FROM rental q3
        WHERE q1.film_id = q3.film_id
        AND q2.rental_id <> q3.rental_id
    )ORDER by q1.last_name
);

