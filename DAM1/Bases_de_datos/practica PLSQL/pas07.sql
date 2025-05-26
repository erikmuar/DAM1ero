

CREATE DATABASE IF NOT EXISTS lsfit_backup;


DELIMITER $$

DROP PROCEDURE IF EXISTS fer_backup_setmanal $$
CREATE PROCEDURE fer_backup_setmanal()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE nom_taula VARCHAR(64);
    DECLARE sufix_data VARCHAR(20);
    
    DECLARE cur CURSOR FOR 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'lsfit' AND table_type = 'BASE TABLE';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET sufix_data = DATE_FORMAT(CURDATE(), '%Y_%m_%d');

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO nom_taula;
        IF done THEN
            LEAVE bucle;
        END IF;

        -- Crear la nova taula a backup amb mateix esquema
        SET @aux1 = CONCAT('CREATE TABLE lsfit_backup.', nom_taula, '_', sufix_data,' LIKE lsfit.', nom_taula);
        PREPARE stmt1 FROM @aux1;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;

        SET @aux2 = CONCAT('INSERT INTO lsfit_backup.', nom_taula, '_', sufix_data,' SELECT * FROM lsfit.', nom_taula);
        PREPARE stmt2 FROM @aux2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;

    END LOOP bucle;

    CLOSE cur;
END $$
DELIMITER ;




SET GLOBAL event_scheduler = ON;

CREATE EVENT evt_backup_setmanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-05 23:00:00'
ENDS '2025-12-28 23:00:00'
DO
  CALL fer_backup_setmanal();

