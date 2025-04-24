-- Exemple Classe 1 --
SELECT name FROM country
  INTO OUTFILE 'C:/Users/guill/Downloads/paises_por_comas.txt'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';';

SELECT name, language FROM country AS c, countrylanguage AS cl
  WHERE cl.countrycode = c.code
  INTO OUTFILE 'C:/Users/guill/Downloads/paises_y_idiomas.txt'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';


CREATE DATABASE test_load;
USE test_load;

CREATE table test_country(
    name char(52)
);

CREATE table test_country_language(
    name char(52),
    language char(30)
);


LOAD DATA INFILE 'C:/Users/guill/Downloads/paises_por_comas.txt'
INTO TABLE test_country FIELDS TERMINATED BY ','
LINES TERMINATED BY ';';

LOAD DATA INFILE 'C:/Users/guill/Downloads/paises_y_idiomas.txt'
INTO TABLE test_country_language FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- Exemple Classe 2 --
CREATE table test_city LIKE world.city; 

SELECT * FROM world.city
  INTO OUTFILE 'C:/Users/guill/Downloads/city.txt'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';';

LOAD DATA INFILE 'C:/Users/guill/Downloads/city.txt'
INTO TABLE test_city FIELDS TERMINATED BY ','
LINES TERMINATED BY ';';