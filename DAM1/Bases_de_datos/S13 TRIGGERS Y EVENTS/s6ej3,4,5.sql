-- 3 Cread un evento que cada final de mes guarde todos los correos electrónicos de la tabla persona 
-- (si el atributo del correo para un registro es null hemos de obviar aquella fila) en un fichero 
-- de texto que tendrá el nombre siguiente: correos_MES_AÑO.txt (donde MES sea el número de mes 
-- actual y AÑO sea el año actual).




SET GLOBAL event_scheduler = ON;

DELIMITER $$

DROP EVENT IF EXISTS exportar_correos_mensual $$

CREATE EVENT IF NOT EXISTS exportar_correos_mensual
ON SCHEDULE EVERY 1 MONTH
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL (1 - DAY(CURRENT_DATE)) MONTH + INTERVAL 23 HOUR + INTERVAL 59 MINUTE)
DO
BEGIN
  
  SET @aux = CONCAT(
    "SELECT correo_electronico ",
    "FROM persona ",
    "WHERE correo_electronico IS NOT NULL ",
    "INTO OUTFILE 'C:/xampp/mysql/data/lslog/correos_",
    MONTH(CURRENT_DATE), "_", YEAR(CURRENT_DATE), ".txt' ",
    "FIELDS TERMINATED BY ',' ",
    "OPTIONALLY ENCLOSED BY '\' ",
    "LINES TERMINATED BY '\n'"

    );

  PREPARE stmt FROM @aux;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$

DELIMITER ;



-- 4 


-- Activar el event scheduler (si no está activo)
SET GLOBAL event_scheduler = ON;

DELIMITER $$

DROP EVENT IF EXISTS evento_estadisticas_log $$

CREATE EVENT evento_estadisticas_log
ON SCHEDULE
    EVERY 1 WEEK
    STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL (7 - DAYOFWEEK(CURRENT_DATE)) DAY + INTERVAL 23 HOUR + INTERVAL 59 MINUTE)
DO
BEGIN
    DECLARE vInsert INT DEFAULT 0;
    DECLARE vUpdate INT DEFAULT 0;
    DECLARE vDelete INT DEFAULT 0;

    SELECT COUNT(*) INTO vInsert FROM log WHERE texto LIKE '%INSERT%';
    SELECT COUNT(*) INTO vUpdate FROM log WHERE texto LIKE '%UPDATE%';
    SELECT COUNT(*) INTO vDelete FROM log WHERE texto LIKE '%DELETE%';

    SET @salida = CONCAT(
        "SELECT 'Registros INSERT: ", vInsert,
        "\\n Registros UPDATE: ", vUpdate,
        "\\n Registros DELETE: ", vDelete,
        "' INTO OUTFILE 'C:/xampp/mysql/data/lslog/estadísticas_",
        DATE_FORMAT(CURRENT_DATE, '%Y-%m-%d'),
        ".txt'"
    );

    -- Ejecutar la consulta dinámica
    PREPARE stmt FROM @salida;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$

DELIMITER ;




-- 5  Cread un evento que cada día a las 4:00 de la mañana haga una copia de --backup de la base de datos usada en los ejercicios anteriores. Las tablas solo --deben crearse la primera vez ya que después siempre existirán. Posteriormente --debéis vaciarlas y volverlas a llenar con la información actual de la BBDD --sobre la que hacéis el backup.


CREATE DATABASE IF NOT EXISTS lslog_backup;

SET GLOBAL event_scheduler = ON;

DELIMITER $$

DROP EVENT IF EXISTS evento_backup_lslog $$

CREATE EVENT evento_backup_lslog
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 4 HOUR)
DO
BEGIN
    SET @crear_tablas = 
     "CREATE TABLE IF NOT EXISTS lslog_backup.persona LIKE lslog.persona;
     CREATE TABLE IF NOT EXISTS lslog_backup.log LIKE lslog.log;
    ";
    PREPARE stmt FROM @crear_tablas;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    DELETE FROM lslog_backup.persona;
    DELETE FROM lslog_backup.log;

    INSERT INTO lslog_backup.persona SELECT * FROM lslog.persona;
    INSERT INTO lslog_backup.log SELECT * FROM lslog.log;
    
END $$

DELIMITER ;


