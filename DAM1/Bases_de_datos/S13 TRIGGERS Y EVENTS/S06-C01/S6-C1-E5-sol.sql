# Activar event scheduler:
SET GLOBAL event_scheduler = 1;



CREATE DATABASE backup_lslog;
USE backup_lslog;

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

      SET @aux = CONCAT("CREATE TABLE TABLE IF NOT EXISTS ", nombre_tabla," LIKE ", bbdd_origen, ".", nombre_tabla);
      PREPARE stmt1 FROM @aux;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

      SET @aux = CONCAT("DELETE FROM ",nombre_tabla);
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



# Evento que lama al procedimiento de backup
DELIMITER $$
DROP EVENT IF EXISTS evento_ej5 $$
CREATE EVENT IF NOT EXISTS evento_ej5
ON SCHEDULE EVERY 1 DAY
STARTS '2019-03-19 04:00:00'
DO BEGIN
  CALL fes_backup("lslog","backup_lslog");
END $$
DELIMITER ;

