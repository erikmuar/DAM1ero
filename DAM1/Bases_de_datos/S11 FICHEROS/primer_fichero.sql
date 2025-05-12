-- BBDD World

-- 1 Crear un fichero con el nombre de los paises 

SELECT name INTO OUTFILE 'C:/Users/maria/OneDrive/Documents/DAM1/DAM1ero/DAM1/Bases_de_datos/S11 FICHEROS/archivos/country_names.txt' 
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'FROM city;

-- 1.1 Crear un fichero con el nombre de los paises y lenguas 


SELECT c.name, cl.Language INTO OUTFILE 'C:/Users/maria/OneDrive/Documents/DAM1/DAM1ero/DAM1/Bases_de_datos/S11 FICHEROS/archivos/country_names2.txt' 
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'FROM country AS c
JOIN countrylanguage AS cl ON cl.CountryCode = c.Code;



-- 2 Creo bbdd backupworld 


CREATE DATABASE backupWorld;

CREATE TABLE nom_paisos(
    name VARCHAR(30),
    
    PRIMARY KEY(name)
    
    ); 
    
CREATE TABLE countrylanguage(
    countryName VARCHAR(40),
    language VARCHAR(40),
    
    FOREIGN KEY (countryName) REFERENCES nom_paisos(name)
    
    
    );



-- 3 LOAD ficheros del paso 1 

LOAD DATA INFILE 'C:/Users/maria/OneDrive/Documents/DAM1/DAM1ero/DAM1/Bases_de_datos/S11 FICHEROS/archivos/city_names.txt'
INTO TABLE nom_paisos FIELDS TERMINATED BY '\t' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';




