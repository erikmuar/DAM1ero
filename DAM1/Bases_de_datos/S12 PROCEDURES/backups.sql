-- Código completo comentado en el documento 'Ejemplo. Procedimiento de Backup'

CREATE DATABASE backup_lsonline;
USE backup_lsonline;
SET FOREIGN_KEY_CHECKS = 0;

DELIMITER $$

DROP PROCEDURE IF EXISTS doBackup  $$

CREATE PROCEDURE  doBackup (IN bbdd_origen VARCHAR(20), IN bbdd_destino VARCHAR(20))
BEGIN

   DECLARE done INT DEFAULT 0;
   DECLARE nombre_tabla VARCHAR(20);

   DECLARE cur1 CURSOR FOR SELECT table_name FROM information_schema.tables
   WHERE table_schema=bbdd_origen AND table_type="base table";

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

   OPEN cur1;

   bucle: LOOP
      FETCH cur1 INTO nombre_tabla;

      IF done=1 THEN
         LEAVE bucle;
      END IF;
	  
      SELECT CONCAT("Copia de ", nombre_tabla," a la nueva base de datos ", bbdd_destino);

      SET @aux = CONCAT("CREATE TABLE ", nombre_tabla," LIKE ", bbdd_origen, ".", nombre_tabla);
      PREPARE stmt1 FROM @aux;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

      SET @aux = CONCAT("INSERT INTO ", nombre_tabla," SELECT * FROM ", bbdd_origen, ".", nombre_tabla);
      PREPARE stmt1 FROM @aux;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

   END LOOP bucle;

   CLOSE cur1;

END $$

DELIMITER ;

#Llamada la procedimiento, suponiendo que existen las 2 bases de datos
CALL doBackup("lsonline","backup_lsonline");