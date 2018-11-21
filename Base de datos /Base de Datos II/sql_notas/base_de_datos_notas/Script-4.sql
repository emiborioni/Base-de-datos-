#Clase 7 
# Se compara con todos y muestra la pelicula de mayor duracion
#All busca el mayor (Similar a max)
SELECT title,length 
  FROM film 
 WHERE length >= ALL (SELECT length 
                        FROM film);

UPDATE film SET length = 200 WHERE film_id = 182;
#Se compara con todos excepto con ella misma (mas refinada)
SELECT title,length 
  FROM film f1 
 WHERE length > ALL (SELECT length 
                       FROM film f2
                      WHERE f2.film_id <> f1.film_id);
                      
#Any,busca que por lo menos encuentre 1 o mas 
#All busca que sea mayor a todo el subset no a cualquiera
SELECT title,length, film_id 
  FROM film f1 
 WHERE NOT length <= ANY (SELECT length 
                       FROM film f2 
                      WHERE f2.film_id <> f1.film_id);

UPDATE film SET length = 185 WHERE film_id = 182;  

SELECT title,replacement_cost 
  FROM film 
 WHERE replacement_cost > ANY (SELECT replacement_cost 
                                 FROM film) 
 ORDER BY replacement_cost; 

-- Same query with exists
 SELECT title,replacement_cost 
  FROM film f1 
 WHERE EXISTS (SELECT * 
                 FROM film f2 
                WHERE f1.replacement_cost > f2.replacement_cost) 
 ORDER BY replacement_cost; 

 SELECT title,description,
rental_rate,
rental_rate * 15 AS in_pesos 
  FROM film 
 WHERE rental_rate * 15 > 10.0 
   AND rental_rate * 15 < 70.0;

-- Can be written

SELECT * 
  FROM (SELECT title,description,rental_rate,rental_rate * 15 AS in_pesos 
          FROM film) g 
 WHERE in_pesos > 10.0 
   AND in_pesos < 70.0; 