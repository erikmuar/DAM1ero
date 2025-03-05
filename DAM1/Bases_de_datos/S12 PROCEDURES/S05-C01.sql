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

SELECT TABLE_NAME INTO OUTFILE 'C:/Users/maria/OneDrive/Documents/DAM1/DAM1ero/DAM1/Bases_de_datos/S12 PROCEDURES/archivos/nombre_tablas.txt'
FIELDS TERMINATED BY '\n ' 
LINES TERMINATED BY '\n' 
FROM information_schema.tables
WHERE table_schema = "northwind"
AND table_type = "base table"; --Esto es para que no coja vistas 


-- 2 Para la misma base de datos que hayas elegido en el ejercicio anterior, y sin utilizar procedimientos,
-- crea una base de datos de backup y desde esta, copia la estructura de las tablas y su información.

CREATE DATABASE backupNorthwind;


CREATE TABLE northwind.customers