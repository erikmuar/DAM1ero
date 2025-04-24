DELIMITER ~~

DROP PROCEDURE IF EXISTS pHelloWorld ~~

CREATE PROCEDURE pHelloWorld (IN vName varchar(15))
BEGIN
SET @aux = CONCAT ("Hello ",vName);
SELECT @aux;
END ~~

DELIMITER ;

CALL pHelloWorld("NomAlumne");