CREATE TABLE film (
	film_id INT(11) NOT NULL AUTO_INCREMENT,
  tittle VARCHAR(30) NOT NULL,
  description VARCHAR(25),
  release_year DATE,
  CONSTRAINT film_pk PRIMARY KEY (film_id)
  
);
CREATE TABLE actor(
	actor_id INT(11) NOT NULL AUTO_INCREMENT,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);

CREATE TABLE film_actor(
	film_id INT(11) NOT NULL ,
	actor_id INT(11) NOT NULL
);

ALTER TABLE film_actor ADD 
  CONSTRAINT film_id
    FOREIGN KEY (film_id)
    REFERENCES film (film_id);
 
ALTER TABLE film_actor ADD 
  CONSTRAINT actor_id
    FOREIGN KEY (actor_id)
    REFERENCES actor (actor_id);
    
ALTER TABLE actor
	ADD 	last_update TIMESTAMP;
	
ALTER TABLE film
	ADD 	last_update TIMESTAMP;
	
INSERT INTO imdb.actor
(actor_id, first_name, last_name)
VALUES(1, 'Brad', 'Pitt');

INSERT INTO imdb.actor
(actor_id, first_name, last_name)
VALUES(2, 'Robert', 'De Niro');

INSERT INTO imdb.actor
(actor_id, first_name, last_name)
VALUES(3, 'Pablo', 'Rago');

INSERT INTO imdb.film
(film_id, tittle, description, release_year, last_update)
VALUES(1, 'Titanic', 'Se hunde el barco', '1987-02-19', CURRENT_TIMESTAMP);

INSERT INTO imdb.film
(film_id, tittle, description, release_year, last_update)
VALUES(2, 'Manuel Belgrano', 'Procer Argentino', '2012-03-25', CURRENT_TIMESTAMP);


INSERT INTO imdb.film_actor
(film_id, actor_id)
VALUES(1, 1);

INSERT INTO imdb.film_actor
(film_id, actor_id)
VALUES(2, 2);

