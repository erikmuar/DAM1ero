DELIMITER ~~

DROP PROCEDURE IF EXISTS pHelloWorld ~~

CREATE PROCEDURE pHelloWorld (IN vName varchar(15))
BEGIN
SET @aux = CONCAT ("Hello ",vName);
SELECT @aux;
END ~~

DELIMITER ;

CALL pHelloWorld("NomAlumne");



-- 1 Sin utilizar procedimientos, copia el nombre de las tablas de una base de datos cualquiera (si no
--dispones de ninguna, crea una con al menos 3 tablas, 3 atributos por tabla e inserta 3 filas por tabla)
--en un fichero llamado nombre_tablas.txt:

