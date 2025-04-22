--1 Crea un trigger a la base de dades mymovies que, abans d'un update sobre la taula movies, 
-- guardi les dades originals que hi havia a la taula en una taula nova. Aquesta taula nova, és dirà 
-- movies_version i contindrà les mateixes columnes que la taula original més una taula de tipus 
-- datetime per a guardar l'hora de l'update i també una altra columna per a especificar la versió 
-- del canvi. És a dir, si hi ha hagut tres canvis de nom sobre la taula movies, la taula movies_version 
-- tindrà tres files per a la mateixa taula i l'id de la versió anirà de 1 a 3. 
-- Pensa com resoldràs la situació de saber quin número de versió estem.


CREATE TABLE movies_version (
  id INT,
  name VARCHAR(100),
  year INT,
  stockUnits INT,
  price DOUBLE,
  fecha_update DATETIME,
  version_id INT
);
 

DELIMITER $$

DROP TRIGGER IF EXISTS before_update_movies $$
CREATE TRIGGER before_update_movies
BEFORE UPDATE ON movies
FOR EACH ROW
BEGIN
    DECLARE v_version INT;

    SELECT IFNULL(MAX(version_id), 0) + 1 INTO v_version
    FROM movies_version
    WHERE id = OLD.id;

    INSERT INTO movies_version (id, title, year, director, genre, fecha_update, version_id)
    VALUES (OLD.id, OLD.title, OLD.year, OLD.director, OLD.genre, NOW(), v_version);
END $$
DELIMITER ;



-- Crea un altre trigger per a la taula movies de la mateixa base de dades anterior. 
-- Aquest cop volem que s'executi després d'un INSERT. Dins del cos del trigger, volem que 
-- guardi una fila dins d'una altra taula nova (que haurem de crear). Aquesta taula nova que 
-- hem de crear amb el nom de movies_per_year, conté dues columnes: year de tipus INT i countmovies 
-- de tipus INT. Voldrem guardar la informació sobre quantes pel·lícules tenim per cada any de creació.
-- Per tant, si per exemple creem una pel·lícula nova de l'any 1999, haurem d'anar a la taula movies_per_year, 
-- comprovar si hi ha recompte de pel·lícules per l'any 1999, si n'hi ha, incrementarem el recompte, 
-- en cas de que no n'hi hagi, inserirem una fila nova per l'any 1999 i li posarem valor 1.



CREATE TABLE movies_per_year (
  year INT PRIMARY KEY,
  countmovies INT
);

DELIMITER $$

DROP TRIGGER IF EXISTS after_insert_movies $$

CREATE TRIGGER after_insert_movies
AFTER INSERT ON movies
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM movies_per_year WHERE year = NEW.year) THEN
    UPDATE movies_per_year
    SET countmovies = countmovies + 1
    WHERE year = NEW.year;
  ELSE
    INSERT INTO movies_per_year (year, countmovies)
    VALUES (NEW.year, 1);
  END IF;
END $$

DELIMITER ;





