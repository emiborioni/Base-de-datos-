## INSERT Statement

The INSERT statement is used to insert a single record or multiple records into a table.

Syntax

In its simplest form, the syntax for the INSERT statement when inserting a single record using the VALUES keyword is:

```sql
INSERT INTO table
(column1, column2, ... )
VALUES
(expression1, expression2, ... ),
(expression1, expression2, ... ),
...;
```

In its simplest form, the syntax for the INSERT statement when inserting multiple records using a sub-select in MySQL is:

```sql
INSERT INTO table
(column1, column2, ... )
SELECT expression1, expression2, ...
FROM source_table
[WHERE conditions];
```

Example - Using VALUES keyword
```sql
INSERT INTO suppliers
(supplier_id, supplier_name)
VALUES
(1000, 'Dell');
```

Example - Using sub-query

```sql
INSERT INTO suppliers
(supplier_id, supplier_name)
SELECT account_no, name
FROM customers
WHERE customer_id < 5000;
```

## UPDATE Statement

The UPDATE statement is used to update existing records in a table in a database. 
There are 3 syntaxes for the UPDATE statement depending on the type of update that you wish to perform.

Syntax

In its simplest form, the syntax for the UPDATE statement when updating one table in is:

```sql
UPDATE table
SET column1 = expression1,
    column2 = expression2,
    ...
[WHERE conditions];
```

OR

The syntax for the UPDATE statement when updating one table with data from another table in MySQL is:

```sql
UPDATE table1
SET column1 = (SELECT expression1
               FROM table2
               WHERE conditions)
[WHERE conditions];
```

OR

```sql
The syntax for MySQL UPDATE statement when updating multiple tables is:

UPDATE table1, table2, ... 
SET column1 = expression1,
    column2 = expression2,
    ...
WHERE table1.column = table2.column
AND conditions;
```

Example - Update single column

```sql
UPDATE customers
SET last_name = 'Anderson'
WHERE customer_id = 5000;
```

Example - Update multiple columns

```sql
UPDATE customers
SET state = 'California',
    customer_rep = 32
WHERE customer_id > 100;
```

Example -  Update table with data from another table

```sql
UPDATE customers
SET city = (SELECT city
            FROM suppliers
            WHERE suppliers.supplier_name = customers.customer_name)
WHERE customer_id > 2000;
```

Example - Update multiple Tables
```sql
UPDATE customers, suppliers
SET customers.city = suppliers.city
WHERE customers.customer_id = suppliers.supplier_id;
```

## DELETE Statement

The DELETE statement is used to delete a single record or multiple records from a table.

Syntax

In its simplest form, the syntax for the DELETE statement in is:
```sql
DELETE FROM table
[WHERE conditions];
```

Example - With One condition
```sql
DELETE FROM contacts
WHERE last_name = 'Johnson';
```

Example - With Two conditions
```sql
DELETE FROM contacts
WHERE last_name = 'Johnson'
AND contact_id < 1000;
```

Example - With LIMIT modifier

```sql
DELETE FROM contacts
WHERE last_name = 'Johnson'
ORDER BY contact_id DESC
LIMIT 1;
```

Example - Using EXISTS Condition
```sql
DELETE FROM suppliers
WHERE EXISTS
  ( SELECT *
    FROM customers
    WHERE customers.customer_id = suppliers.supplier_id
    AND customer_id > 500 );
```

This DELETE example would delete all records in the suppliers table where there is a record in the customers 
table whose customer_id is greater than 500, and the customer_id matches the supplier_id.


## TRUNCATE TABLE Statement

The TRUNCATE TABLE statement is used to remove all records from a table. It performs the same function as a DELETE statement without a WHERE clause.

`Warning: If you truncate a table, the TRUNCATE TABLE statement can not be rolled back.`


Syntax

The syntax for the TRUNCATE TABLE statement is:

```sql
TRUNCATE TABLE [database_name.]table_name;
```

Notes

- When you truncate a table, the AUTO_INCREMENT counters on the table will be reset.
- MySQL truncates the table by dropping and creating the table. Thus, the DELETE triggers for the table do not fire during the truncation.
- Starting in MySQL 5.5, you can not truncate an InnoDB table that is referenced by a foreign key in another table.
- Starting in MySQL 5.6, you can not truncate a NDB table that is referenced by a foreign key in another table.

Example
```sql
TRUNCATE TABLE customers;
```

This example would truncate the table called customers and remove all records from that table.


## IS NULL Condition

The **IS NULL** Condition is used to test for a NULL value in a **SELECT, INSERT, UPDATE, or DELETE** statement.

Syntax

The syntax for the IS NULL Condition in MySQL is:

```sql
expression IS NULL
```

Example - With INSERT Statement

```sql
INSERT INTO contacts
(contact_id, contact_name)
SELECT account_no, supplier_name
FROM suppliers
WHERE category IS NULL;
```
 
Example - With UPDATE Statement

```sql
UPDATE contacts
SET last_name = 'TBD'
WHERE last_name IS NULL;
```

Example - With DELETE Statement

```sql
DELETE FROM contacts
WHERE last_name IS NULL;
```

## IS NOT NULL

The **IS NOT NULL** condition is used to test for a NOT NULL value in a **SELECT, INSERT, UPDATE, or DELETE** statement.

Syntax

The syntax for the IS NOT NULL Condition in MySQL is:

```sql
expression IS NOT NULL
```

Example - With SELECT Statement

```sql
SELECT *
FROM contacts
WHERE last_name IS NOT NULL;
```

## Excersises 

Write the statements with all the needed subqueries, do not use hard-coded ids unless is specified.
Check which fields are mandatory and which ones can be ommited (use default value).

1. Add a new customer
    - To store 1
    - For address use an existing address. The one that has the biggest address_id in 'United States'
    
2. Add a rental
   - Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
   - Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
   - Select any staff_id from Store 2. 
   
3. Update film year based on the rating
   - For example if rating is 'G' release date will be '2001'
   - You can choose the mapping between rating and year.
   - Write as many statements are needed.
   
4. Return a film
   - Write the necessary statements and queries for the following steps.
   - Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
   - Use the id to return the film.
   
5. Try to delete a film
   - Check what happens, describe what to do.
   - Write all the necessary delete statements to entirely remove the film from the DB.
   
6. Rent a film
   - Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
   - Add a rental entry
   - Add a payment entry
   - Use sub-queries for everything, except for the inventory id that can be used directly in the queries.

Once you're done. Restore the database data using the populate script from class 3.

## Results:

```
-- 1

INSERT INTO sakila.customer
(store_id, first_name, last_name, email, address_id, active)
VALUES(1, 'Pepe', 'Suarez', 'pepesuarez@gmail.com', 599, 1);


#El max da 599
SELECT MAX(a.address_id)
FROM address a
WHERE (SELECT c.country_id
		FROM country c, city c1
		WHERE c.country = "United States"
		AND c.country_id = c1.country_id
		AND c1.city_id = a.city_id);
		

SELECT *
FROM customer
WHERE last_name = "Suarez";



-- 2

INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT CURRENT_TIMESTAMP, 
		(SELECT MAX(r.inventory_id)
		 FROM inventory r
		 INNER JOIN film USING(film_id)
		 WHERE film.title = "ARABIA DOGMA"
		 LIMIT 1), 
		 601, -- Find an user here
		 NULL,
		 (SELECT staff_id
		  FROM staff
		  INNER JOIN store USING(store_id)
		  WHERE store.store_id = 2
		  LIMIT 1);

SELECT MAX(r.inventory_id)
FROM inventory r
INNER JOIN film USING(film_id)
WHERE film.title = "ALIEN CENTER";

SELECT staff_id
FROM staff
INNER JOIN store USING(store_id)
WHERE store.store_id = 2
LIMIT 1;


-- 3

UPDATE sakila.film
SET release_year='2001'
WHERE rating = "G";

UPDATE sakila.film
SET release_year='2005'
WHERE rating = "PG";

UPDATE sakila.film
SET release_year='2010'
WHERE rating = "PG-13";

UPDATE sakila.film
SET release_year='2015'
WHERE rating = "R";

UPDATE sakila.film
SET release_year='2020'
WHERE rating = "NC-17";


-- 4

#Rental id devuelto 11496 , el precio 2,99, el customer = 155, staff = 1
SELECT rental_id, rental_rate, customer_id, staff_id
FROM film
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
WHERE rental.return_date IS NULL
LIMIT 1;

#Hago un update a rental para decir que la pelicula fue devuelta
UPDATE sakila.rental
SET  return_date=CURRENT_TIMESTAMP
WHERE rental_id=11496;


-- 6

SELECT inventory_id, rental_id, store_id
FROM film
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
WHERE rental.return_date IS NOT NULL
and store_id = 2

-- inventory_id 

INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id)
--

SELECT CURRENT_TIMESTAMP,        
		t1.inventory_id, 
        customer.customer_id,
        NULL,
		t1.staff_id
FROM customer
INNER JOIN (SELECT store_id, staff_id, inventory_id
		  FROM staff
		  INNER JOIN store USING(store_id)
		  INNER JOIN inventory USING(store_id)
		  WHERE inventory_id = 10) t1
     USING(store_id)
ORDER BY customer_id DESC
LIMIT 1;

--
INSERT INTO sakila.payment
(customer_id, staff_id, rental_id, amount, payment_date, last_update)
--


SELECT r.customer_id, 
       r.staff_id, 
       r.rental_id,
      (SELECT f.rental_rate 
       from film f
       inner join inventory i USING (film_id)
       WHERE i.inventory_id = r.inventory_id ) as amount,
       r.rental_date   
FROM rental r
WHERE return_date IS NULL
AND inventory_id = 10;

```