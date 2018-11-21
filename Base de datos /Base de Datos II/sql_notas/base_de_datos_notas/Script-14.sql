#Crear una base de datos llamada 'classroom';. 
#Dentro de la base de datos, agregar tres tablas,
#una llamada 'student', con los campos 'student_id'. 
#Otra tabla llamada 'test' con un 'test_id'.
#Estas dos primeras tablas, agregar dos campos más que crea pertinente. 
#Por último, otra tabla llamada 'grade', con los campos 'grade_id', 'test_id', 'student_id' y la 'nota' propiamente dicha. 
#No puede haber mas de una nota por evaluación del mismo alumno (Agregar el constraint correspondiente).
#Crear un usuario que pueda leer las tres tablas y un usuario que además, pueda modificar el contenido de la tabla 'nota' *

CREATE DATABASE classroom;

CREATE TABLE student (student_id INT ( 11 ) NOT NULL AUTO_INCREMENT, first_name VARCHAR (25) NOT NULL, last_name VARCHAR(25) NOT NULL, CONSTRAINT PRIMARY KEY ( student_id ) );
CREATE TABLE test (test_id INT ( 11 ) NOT NULL AUTO_INCREMENT, CONSTRAINT PRIMARY KEY ( test_id ), student_id INT (11),FOREIGN KEY (student_id) REFERENCES student(student_id), mark INT(11));
CREATE TABLE grade (grade_id INT ( 11 ) NOT NULL AUTO_INCREMENT, CONSTRAINT PRIMARY KEY ( grade_id ), student_id INT (11),FOREIGN KEY (student_id) REFERENCES student(student_id), test_id INT (11),FOREIGN KEY (test_id) REFERENCES test(test_id), mark INT(11));
ALTER TABLE grade ADD CONSTRAINT uniquemark UNIQUE ( test_id , student_id ); 

CREATE USER reader_only@localhost IDENTIFIED BY 'reader_only';

GRANT SELECT ON classroom.*
TO reader_only@localhost
with GRANT OPTION;

CREATE USER modify_user@localhost IDENTIFIED BY 'modify_user';

GRANT SELECT ON classroom.*
TO modify_user@localhost
with GRANT OPTION;

GRANT SELECT,UPDATE,DELETE ON classroom.grade
TO modify_user@localhost
with GRANT OPTION;


# Write 2 triggers: 
# One when inserting a row that you have to add an entry in the audit table that specifies the action 'rented'.
# The other trigger is when the table is updated and should specify the action 'returned'. 
# You can assume updates are only updating the column return_date.

DELIMITER $$
CREATE TRIGGER before_film_update 
    BEFORE UPDATE ON rental
    FOR EACH ROW 
BEGIN
    INSERT INTO rental_audit
    SET action = 'update',
    rental_id = OLD.rental_id,
     rental.return_date = NOW()
        ; 
END
DELIMITER ;


DELIMITER $$
CREATE TRIGGER before_film_rental 
    BEFORE INSERT ON rental
    FOR EACH ROW 
BEGIN
    INSERT INTO rental_audit
    SET action = 'insert',
    rental_id = NEW.rental_id,
    rental_date = NOW(),
	inventory_id = NEW.inventory_id,
	customer_id = NEW.customer_id
        ; 
END
DELIMITER ;








