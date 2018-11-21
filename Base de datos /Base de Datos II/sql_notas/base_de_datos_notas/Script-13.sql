CREATE USER data_analyst@localhost IDENTIFIED BY 'data_analyst';

GRANT SELECT,UPDATE,DELETE ON sakila.*
TO data_analyst@localhost
with GRANT OPTION;

docker exec -it mysql mysql -u root -p
GRANT ALL ON *.* TO 'user'@'%' WITH GRANT OPTION;


ALTER TABLE employees ADD age INT;
ALTER TABLE employees ADD CONSTRAINT age_range CHECK (age>=16 AND age<=70);
ALTER TABLE employees MODIFY age INT CHECK ( age > 18 ); 
ALTER TABLE employees ADD CONSTRAINT myCheckConstraint CHECK ( age >= 18 ); 
ALTER TABLE employees ADD CHECK (Age>=18); 
ALTER TABLE sakila.employees ADD CONSTRAINT CHK_PersonAge CHECK (age>=18 ); 


INSERT into sakila.employees(firstName,lastName,age, employeeNumber,extension,email,officeCode,jobTitle)
VALUES("emiliano", "borioni", 5,51511332,652, "asdsad",5,"asd");


ALTER TABLE employees add last_update TIMESTAMP;
ALTER TABLE employees add lastupdateuser VARCHAR(25);

DELIMITER $$
CREATE TRIGGER check_age
    BEFORE INSERT ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'insert',
     IF (age < 18) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age must be gte 18';
	END IF;
	
	
END 
DELIMITER ;

DELIMITER $$
CREATE TRIGGER ussers_employees_chesck
    AFTER INSERT ON employees FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'insert',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        last_update = OLD.last_update,
        changedat = NOW(); 
END 
DELIMITER ;



select trigger_schema, trigger_name, action_statement
from information_schema.triggers;



SELECT first_name, last_name, email
from sakila.customer
INNER JOIN address USING (address_id)
WHERE (address.postal_code >= "5000");

SELECT first_name, last_name, email
from sakila.customer
INNER JOIN address USING (address_id)
WHERE (address.postal_code LIKE "6802");










# Class 17 excersice full text 

SELECT first_name, last_name, email, city.city
from sakila.customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE (address.postal_code >= "5000" and 
		country.country = "Argentina") AND
		city.city = "Escobar";
		
SELECT first_name, last_name, email, city.city
from sakila.customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE (address.postal_code = '6802');


ALTER TABLE address ADD FULLTEXT ( postal_code ); 

SELECT first_name, last_name, email, city.city
from sakila.customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE MATCH (address.postal_code) against ('6802');


ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'test'


CREATE TABLE prueba ( ID INT NOT NULL , NAME VARCHAR ( 20 ) NOT NULL , AGE INT NOT NULL UNIQUE , ADDRESS CHAR ( 25 ) , SALARY DECIMAL ( 18 , 2 ), PRIMARY KEY ( ID ) ); 
ALTER TABLE prueba ADD CONSTRAINT myUniqueConstraint UNIQUE ( AGE , SALARY ); 


insert into prueba(ID,NAME,AGE,ADDRESS,SALARY)
VALUES(6,"PEDRO",23,"JUANCITO D",25);








