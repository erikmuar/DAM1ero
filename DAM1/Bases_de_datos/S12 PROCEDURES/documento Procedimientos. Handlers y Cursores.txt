# Código completo comentado en el documento 'Procedimientos. Handlers y Cursores'

DROP DATABASE IF EXISTS bd_pruebas;
CREATE DATABASE bd_pruebas;
USE bd_pruebas;

CREATE TABLE personal(
   ID INTEGER NOT NULL AUTO_INCREMENT,
   nombre VARCHAR(20), 
   apellido VARCHAR(20), 
   PRIMARY KEY(ID)
);

CREATE TABLE historial( 
   ID_persona INTEGER NOT NULL
);

INSERT INTO personal (nombre, apellido) VALUES 
('Manuel', 'Montero'),
('Judit', 'Jiménez'),
('Carlos', 'Cervantes');

DELIMITER $$

DROP PROCEDURE IF EXISTS lectorBasico $$

CREATE PROCEDURE lectorBasico() 
BEGIN

   DECLARE done INT DEFAULT 0;
   DECLARE identificador INTEGER;

   DECLARE cur1 CURSOR FOR SELECT ID FROM personal;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

   OPEN cur1;
   bucle1:LOOP
      FETCH cur1 INTO identificador;
      IF done=1 THEN
         LEAVE bucle1;
      END IF;

      SELECT identificador;

      INSERT INTO historial VALUES (identificador);
   END LOOP bucle1;
   CLOSE cur1;

END $$
DELIMITER ;

# Llamada al procedimiento
CALL lectorBasico();