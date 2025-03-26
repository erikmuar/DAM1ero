# Ejemplo Eventos

# Tablas
CREATE TABLE IF NOT EXISTS log (
  id int NOT NULL AUTO_INCREMENT,
  texto varchar(250) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS persona (
  id int NOT NULL AUTO_INCREMENT,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  apellido2 varchar(50) NOT NULL,
  correo_electronico varchar(100) NOT NULL,
  dni varchar(10) NOT NULL,
  PRIMARY KEY (id)
);

#Evento
DELIMITER $$
DROP EVENT IF EXISTS evento_log_diario $$
CREATE EVENT IF NOT EXISTS evento_log_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2019-01-01 00:00:00'
ENDS '2019-12-31 00:00:00'
DO BEGIN
  SET @aux = CONCAT ("SELECT texto from log into outfile '", CURDATE(), "-log-diario.txt'");
  PREPARE stmt1 FROM @aux;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;


