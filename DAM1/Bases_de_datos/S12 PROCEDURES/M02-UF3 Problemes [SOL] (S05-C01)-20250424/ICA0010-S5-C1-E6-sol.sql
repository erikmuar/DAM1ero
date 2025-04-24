DELIMITER  $$
DROP PROCEDURE IF EXISTS  lsCloudLocation  $$
CREATE PROCEDURE  lsCloudLocation (IN vlocalizacion varchar(50), OUT vnumservidores INT)
BEGIN
SET vnumservidores = (SELECT COUNT(id) FROM servidor);
IF vnumservidores = 0 THEN 
	SET @aux = CONCAT ("SELECT 'Localización no valida!' into outfile 'location_", vlocalizacion,"_",CURDATE(), ".txt' FIELDS TERMINATED BY ', ' LINES TERMINATED BY '\n'");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
ELSE
	SET @aux = CONCAT ("SELECT servername, nick FROM servidor AS s, usuario AS u WHERE s.id_usuario = u.id_usuario 
	AND s.localitzacion LIKE '",vlocalitzacio ,"' into outfile 'location_", vlocalizacion,"_",CURDATE(), ".txt' FIELDS TERMINATED BY ', ' LINES TERMINATED BY '\n'");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END IF;

END $$
DELIMITER ;
