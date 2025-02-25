

CREATE DATABASE IF NOT EXISTS lol;
use lol;

CREATE TABLE characters(
	id INT,
	name VARCHAR(50),
	class VARCHAR(50),
	style INT,
	difficulty INT,
	damagetype VARCHAR(50),
	damage INT,
	sturdiness INT,
	crowd_control INT,
	mobility INT,
	functionality INT,
	PRIMARY KEY (id)
);




LOAD DATA INFILE 'C:/Users/guill/Downloads/LoL-Champions.csv'
INTO TABLE characters FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/Users/guill/Downloads/LoL-Champions-con-cabecera.csv'
INTO TABLE characters FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;