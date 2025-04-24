/*Crear un procedure que reporti durant un any a nivell diari, quants empleats tenim a la taula persona */

create database registre;
use registre;
SET GLOBAL event_scheduler = ON;

CREATE TABLE IF NOT EXISTS persona (
id int NOT NULL AUTO_INCREMENT,
nombre varchar(50) NOT NULL,
apellido varchar(50) NOT NULL,
apellido2 varchar(50) NOT NULL,
correo_electronico varchar(100) NOT NULL,
dni varchar(10) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS log (
id int NOT NULL AUTO_INCREMENT,
texto varchar(250) NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO persona VALUES ("", "P1", "P2", "P1", "P1@empresa.cat", "1A");
INSERT INTO persona VALUES ("", "P2", "P2", "P2", "P2@empresa.cat", "3A");
INSERT INTO persona VALUES ("", "P3", "P3", "P3", "P3@empresa.cat", "3A");
INSERT INTO persona VALUES ("", "P4", "P4", "P4", "P4@empresa.cat", "4A");

DELIMITER $$
DROP PROCEDURE IF EXISTS insertLog$$
CREATE PROCEDURE insertLog()
BEGIN
	DECLARE text VARCHAR(30);
    
    SELECT COUNT(*) INTO @numEmpleats FROM registre.persona;
    SET text = CONCAT("Tenim ", @numEmpleats, " empleats");
    INSERT INTO LOG VALUES ("", text);
END $$
DELIMITER ;



DELIMITER $$
DROP EVENT IF EXISTS evento_log_diario $$
CREATE EVENT IF NOT EXISTS evento_log_diario
ON SCHEDULE EVERY 1 DAY
STARTS current_timestamp()
ENDS current_timestamp() + INTERVAL 1 YEAR
DO BEGIN
	CALL insertLog();
END $$
DELIMITER ;


