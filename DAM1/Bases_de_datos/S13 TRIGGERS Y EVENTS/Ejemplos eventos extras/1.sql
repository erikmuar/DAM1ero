-- Exemple 1: Aquest event s'executarà de forma cíclica cada 10 minuts (usa operador EVERY). La primera execució serà al cap de 3 minuts d'haver creat l'event a la base de dades. No pararà mai el cicle d'execució perquè no té ENDS.
USE bd;

DELIMITER $$
DROP EVENT IF EXISTS e_maintenance1 $$

CREATE EVENT IF NOT EXISTS e_maintenance1
ON SCHEDULE EVERY 10 MINUTE 
STARTS CURRENT_TIMESTAMP + INTERVAL 3 MINUTE
DO BEGIN
	SELECT 'Hello World!';
END $$
DELIMITER ;

-- Exemple 2: Aquest event s'executarà de forma cíclica cada 2 mesos (usa operador EVERY). La primera execució serà en el moment de creació l'event. Pararà d'executar-se al cap d'un any exacte de la creació de l'event.
USE bd;

DELIMITER $$
DROP EVENT IF EXISTS e_maintenance2 $$

CREATE EVENT IF NOT EXISTS e_maintenance2 
ON SCHEDULE EVERY 2 MONTH
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 YEAR
DO BEGIN
	CALL doSmthng(CURRENT_TIMESTAMP());
END $$
DELIMITER ;

-- Exemple 3: Aquest event s'executarà un sol cop (usa operador AT). La data d'execució serà el dia 03-01-2021 a les 02:10 de la nit.
USE bd;

DELIMITER $$
DROP EVENT IF EXISTS e_maintenance3 $$

CREATE EVENT IF NOT EXISTS e_maintenance3
ON SCHEDULE AT '2021-01-01 00:05' + INTERVAL 2 DAY + INTERVAL 2 HOUR + INTERVAL 5 MINUTE
DO BEGIN
	SELECT 'Hello World!';
END $$
DELIMITER ;