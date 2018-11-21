CREATE TABLE contacts
( contact_id INT(11) NOT NULL AUTO_INCREMENT,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(25),
  birthday DATE,
  CONSTRAINT contacts_pk PRIMARY KEY (contact_id)
);
ALTER TABLE contacts
  ADD middle_name varchar(40) NOT NULL
    AFTER contact_id;
ALTER TABLE contacts    
	DROP COLUMN middle_name;
	
ALTER TABLE contacts
  MODIFY last_name varchar(50) NULL;
