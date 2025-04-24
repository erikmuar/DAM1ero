# Activar event scheduler:
SET GLOBAL event_scheduler = 1;


DELIMITER $$
DROP EVENT IF EXISTS event_ej3 $$
CREATE EVENT IF NOT EXISTS evento_ej3
ON SCHEDULE EVERY 1 MONTH
STARTS '2019-03-27 00:00:00'
DO BEGIN
  SET @aux = CONCAT ("SELECT correo_electronico FROM persona 
  	WHERE correo_electronico IS NOT NULL into outfile 
  	'correos_", MONTH(NOW()),"_",YEAR(NOW()), ".txt' 
  	LINES TERMINATED BY '\n'");
  PREPARE stmt1 FROM @aux;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;

