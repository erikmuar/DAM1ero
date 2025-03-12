DELIMITER $$


/*5. També a la BD World, modifica l'exercici anterior per fer que el nom del fitxer 
resultant sigui: NOM_LLENGUA.txt on NOM_LLENGUA òbviament s'adapta al valor de a llengua passada per paràmetre, no en text literal.*/


DROP PROCEDURE IF EXISTS exportarPaisesPorIdioma $$
CREATE PROCEDURE exportarPaisesPorIdioma (IN idioma VARCHAR(50))
BEGIN
    SET @nombreArchivo = CONCAT(UPPER(REPLACE(idioma, ' ', '_')), '.txt');
    SET @consulta = CONCAT(
        "SELECT co.name INTO OUTFILE '", @nombreArchivo, "' ",
        "FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "FROM country AS co, countrylanguage AS cl ",
        "WHERE co.code = cl.countrycode AND cl.language = '", idioma, "';"
    );
    PREPARE stmt FROM @consulta;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$

/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que té. 
Aquests dos valors també s'han de passar com a paràmetres de sortida */


DROP PROCEDURE IF EXISTS contarIdiomasYCiudades $$
CREATE PROCEDURE contarIdiomasYCiudades (IN codigoPais CHAR(3), OUT totalIdiomas INT, OUT totalCiudades INT)
BEGIN
    SELECT COUNT(*) INTO totalIdiomas FROM countrylanguage WHERE CountryCode = codigoPais;
    SELECT COUNT(*) INTO totalCiudades FROM city WHERE CountryCode = codigoPais;
END $$

/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage. 
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/


DROP PROCEDURE IF EXISTS exportarIdiomas $$
CREATE PROCEDURE exportarIdiomas (IN nombreArchivo VARCHAR(255))
BEGIN
    SET @consulta = CONCAT(
        "SELECT * INTO OUTFILE '", nombreArchivo, "' ",
        "FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\'' ",
        "LINES TERMINATED BY '\n' ",
        "FROM countrylanguage;"
    );
    PREPARE stmt FROM @consulta;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$

DELIMITER $$

