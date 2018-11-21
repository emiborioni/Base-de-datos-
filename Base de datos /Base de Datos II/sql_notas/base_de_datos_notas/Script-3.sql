SELECT first_name,last_name 
  FROM customer c1 
 WHERE EXISTS (SELECT * 
                 FROM customer c2 
                WHERE c1.first_name = c2.first_name) ;
                
select count(*)from customer;
# esta query no sirve por que busca todos y se auto compara ella sola como el ordenamiento de juli luna 

SELECT first_name,last_name 
	FROM customer c1 
 WHERE EXISTS (SELECT * 
                FROM customer c2 
                WHERE c1.first_name = c2.first_name && c1.customer_id <> c2.customer_id);
                #Este se auto compara pero excluye a los que tienen el mismo id entonces se esquiva a si misma 
SELECT title,`length` 
  FROM film f1 
 WHERE NOT EXISTS (SELECT * 
                     FROM film f2 
                    WHERE f2.`length` > f1.`length`); 
SELECT description from film;