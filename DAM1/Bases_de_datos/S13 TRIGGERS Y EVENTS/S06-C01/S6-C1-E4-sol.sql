# Activar event scheduler:
SET GLOBAL event_scheduler = 1;


DELIMITER $$
DROP EVENT IF EXISTS evento_ej4 $$
CREATE EVENT IF NOT EXISTS evento_ej4
ON SCHEDULE EVERY 1 WEEK
STARTS '2019-03-22 23:59:00'
DO BEGIN
  SET @inserts = (SELECT COUNT(id) FROM log WHERE text LIKE '%añadido%');
  SET @updates = (SELECT COUNT(id) FROM log WHERE text LIKE '%cambio%');
  SET @deletes = (SELECT COUNT(id) FROM log WHERE text LIKE '%eliminado%');
  SET @info = CONCAT("Inserts: ",@inserts," Updates:",@updates," Deletes: ",@deletes);
  SET @aux = CONCAT ("SELECT '", @info,"' into outfile 'estadisticas_", CURDATE(), ".txt' LINES TERMINATED BY '\n'");
  PREPARE stmt1 FROM @aux;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;

