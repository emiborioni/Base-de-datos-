CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1058,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END 
DELIMITER ;

UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1058;
   
select * from employees_audit;

SELECT f.title, f.release_year
FROM film f
INNER JOIN film_actor fa USING (film_id)
INNER JOIN actor a USING (actor_id)
WHERE TRIM(LOWER(CONCAT(a.first_name))) LIKE TRIM(LOWER(' Zero '));


UPDATE employees SET employeeNumber = employeeNumber - 20;

  UPDATE employees SET employeeNumber = employeeNumber + 20;









































SELECT title, first_name, CASE
	WHEN return_date IS NULL THEN "no"
	WHEN return_date Is NOT NULL THEN "yes"
END AS returned
FROM rental
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
INNER JOIN customer USING (customer_id)
where MONTH(return_date) in ('5','6');



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

 select actor_id, first_name, last_name,COUNT(film_actor.actor_id), film.title
 from actor
 INNER join film_actor USING (actor_id)
 INNER JOIN film USING(film_id)
 where (film_actor.actor_id = actor.actor_id) AND
 (film.film_id = film_actor.film_id)
 group by actor_id
;