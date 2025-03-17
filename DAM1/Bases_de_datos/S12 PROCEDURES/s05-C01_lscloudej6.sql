--Ejercicio 6 
--Crea un procedimiento llamado lsCloudLocation donde dada una localización a través de un
--parámetro de entrada, nos guarde en un archivo el servername y Nick del usuario al que pertenece (1
--por línea).
--El nombre del fichero tiene que ser: location_NOMBRE-LOCALIZACION_FECHA-ACTUAL.txt (por ej.
--Irlanda_YYYY-MM-DD.txt).
--A parte, se tiene que guardar en un parámetro de salida el número de servidores que hay en esa
--localización.
--En el caso que no exista ningún servidor en la localización designada, hay que escribir en el fichero el
--texto: ‘Localización noválida!’  



DELIMITER $$

DROP PROCEDURE IF EXISTS lsCloudLocation $$

CREATE PROCEDURE lsCloudLocation (
    IN vLocalizacion VARCHAR(50),
    OUT vNumServidores INT
)
BEGIN
    DECLARE vServername VARCHAR(50);
    DECLARE vNick VARCHAR(20);
    DECLARE done INT DEFAULT 0;
    DECLARE file_path VARCHAR(255);
    
    DECLARE cur CURSOR FOR
        SELECT s.servername, u.nick 
        FROM servidor s
        JOIN usuario u ON s.id_usuario = u.id_usuario
        WHERE s.localizacion = vLocalizacion;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    SELECT COUNT(*) INTO vNumServidores
    FROM servidor
    WHERE localizacion = vLocalizacion;
    
   
    
END $$

DELIMITER ;
