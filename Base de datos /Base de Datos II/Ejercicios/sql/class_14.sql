#Write a query that gets all the customers that live in Argentina.
#Show the first and last name in one column, the address and the city.
#1
SELECT CONCAT(c.first_name, c.last_name), a.address, ci.city
FROM customer c
INNER JOIN address a USING (address_id)
INNER JOIN city ci USING (city_id)
INNER JOIN country cou USING (country_id)
WHERE cou.country = "Argentina";

#Write a query that shows the film title, language and rating.
#Rating shall be shown as the full text described here: 
#https://en.wikipedia.org/wiki/Motion_picture_content_rating_system
#United_States. Hint: use case.
#2
SELECT f.title, l.name, CASE f.rating 
	WHEN 'G' THEN 'All Ages Are Admitted.'
	WHEN 'PG' THEN 'Some Material May Not Be Suitable For Children.'
	WHEN 'PG-13' THEN 'Some Material May Be Inappropriate For Children Under 13.'
	WHEN 'R' THEN 'Under 17 Requires Accompanying Parent Or Adult Guardian.'
	WHEN 'NC-17' THEN 'No One 17 and Under Admitted.'
	END
FROM film f 
INNER JOIN `language` l USING (language_id);


#Write a search query that shows all the films (title and release year) an actor was part of.
#Assume the actor comes from a text box introduced by hand from a web page.
#Make sure to "adjust" the input text to try to find the films as effectively as you think is possible.
#3
SELECT f.title, f.release_year
FROM film f
INNER JOIN film_actor fa USING (film_id)
INNER JOIN actor a USING (actor_id)
WHERE TRIM(LOWER(CONCAT(a.first_name))) LIKE TRIM(LOWER(' Zero '));


#Find all the rentals done in the months of May and June.
#Show the film title, customer name and if it was returned or not.
#There should be returned column with two possible values 'Yes' and 'No'.
#4
SELECT title, first_name, CASE
	WHEN return_date IS NULL THEN "no"
	WHEN return_date Is NOT NULL THEN "yes"
END AS returned
FROM rental
INNER JOIN inventoryz USING (inventory_id)
INNER JOIN film USING (film_id)
INNER JOIN customer USING (customer_id)
where MONTH(return_date) in ('5','6');


#5
CAST:
Convert a value from one datatype to another datatype.
eg: SELECT CAST("2017-08-29" AS DATE); 

CONVERT:
Convert a value from one datatype to another datatype.
eg:  SELECT CONVERT("2017-08-29", DATE); 

CAST and CONVERT do the same thing, except that CONVERT allows more options, such as changing character set with USING. CAST uses 'AS' and CONVERT a comma.

EXAMPLES BASED ON SAKILA DB
SELECT CAST(rental_date AS CHAR) from rental WHERE rental_id=80;
SELECT CONVERT(amount ,SIGNED) from payment WHERE payment_id=80;

#6
|NVL FUNCTION|

The NVL() function is available in Oracle, and not in MySQL or SQL Server. 
This function is used to replace NULL value with another value. It is similar to the IFNULL Function in MySQL.

|IFNULL FUNCTION|

So NVL() in MYSQL is IFNULL():
SELECT title, CONCAT(first_name, " ", last_name) as Nombre, 
IFNULL(return_date, "NOT RETURNED YET")
FROM rental
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
INNER JOIN customer USING(customer_id);

If the first expression isn't null, it returns itself. Otherwise, returns the second one.
In this example if rental_date is null then it'll be selected with the text "NOT RETURNED YET".

|ISNULL FUNCTION|
Test whether an expression is NULL
SELECT ISNULL(return_date) from rental;
In this case it returns 1(true) or 0(false)

|COALESCE FUNCTION|
Return the first non-null expression in a list
SELECT COALESCE(email,last_name) from customer;
In this case if a customer does not have an email it'll return the last_name.							
