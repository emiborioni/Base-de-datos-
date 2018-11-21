#Add a new customer
#To store 1
#For address use an existing address. The one that has the biggest address_id in 'United States'

INSERT INTO customer (store_id, first_name, last_name, email, address_id) 
VALUES (1, "Emiliano", "Borioni", "yosemite@gmail.com",
		(SELECT address.address_id FROM address
			INNER JOIN city USING (city_id) 
	INNER JOIN country USING (country_id)
			WHERE country.country = "United States" ORDER BY country.country_id DESC LIMIT 1));

#Add a rental
#Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
#Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
#Select any staff_id from Store 2.

INSERT INTO rental (rental_date,inventory_id,customer_id, return_date, staff_id,last_update)
VALUES()