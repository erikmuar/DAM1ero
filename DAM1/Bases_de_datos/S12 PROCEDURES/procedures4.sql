--EXERCICI 1:
-- Useu la base de dades mymovies.
-- Creeu un procedure nou que mostri per pantalla el títol i l'any de creació de totes les pel·lícules que hàgin estat
-- creades dins d'un període d'anys especificat per l'usuari i ordenades per data de creació i títol de la pel·lícula.

--El seu call per exemple podria ser: CALL getMoviesByYear(1986,2001);

-- Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.


USE mymovies;

DELIMITER $$

DROP PROCEDURE IF EXISTS getMoviesByYear $$

CREATE PROCEDURE getMoviesByYear(IN startYear INT, IN endYear INT)
BEGIN
    SELECT title, year
    FROM movies
    WHERE year BETWEEN startYear AND endYear
    ORDER BY year, title;
END $$

DELIMITER ;


--EXERCICI 2:
--Useu la base de dades mymovies.
--Creeu un procedure nou que mostri per pantalla el títol i l'any de creació de totes les pel·lícules que en el seu títol de la pel·lícula continguin
--el text passat per paràmetre.

--El seu call per exemple podria ser: CALL getMoviesByName('Superman');

--Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.

DELIMITER $$

DROP PROCEDURE IF EXISTS getMoviesByName $$

CREATE PROCEDURE getMoviesByName(IN vTitle VARCHAR(50))
BEGIN
    SELECT title, year
    FROM movies
    WHERE title LIKE CONCAT('%', vTitle, '%')
    ORDER BY year, title;
END $$

DELIMITER ;

