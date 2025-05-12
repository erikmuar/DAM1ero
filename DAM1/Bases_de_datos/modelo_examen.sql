/*Ficheros, mirar bien los campos que hay que insertar. solo no poner 

en la tabla hay ID, ID_algo, tu coges el segundo ID con el resto y ya 

mete estos datos del csv en una tabla, no poner ignore one */


CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20)
);


/*CSV 


nombre,email,telefono
Juan Pérez,juan@example.com,123456789
Ana García,ana@example.com,987654321
Luis Torres,luis@example.com,555123456

*/


LOAD DATA INFILE '/ruta/al/archivo/clientes.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (EN CASO DE QUE HAYA UNA PRIMERA FILA CON EL NOMBRE DE LA COLUMNA)
(nombre, email, telefono);






/*Te pide el año y te dice que hagas la media de temperatura e ID por año de cada pais (en la tabla te dan las medias de cada ciudad), el mínimo, el máximo. 


average de temperatura y ponerlo dentro de un fichero desde el 1980 hasta ahora y que el nombre del fichero sea dinamico. Mirar AVG y selects */


DELIMITER $$

DROP PROCEDURE IF EXISTS temperatura $$
CREATE PROCEDURE temperatura ( IN anyo INT)
BEGIN 
DECLARE done INT DEFAULT 0;
DECLARE cur1 CURSOR FOR SELECT  id, AVG(temperatura)  FROM temperatura_pais;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
DECLARE temperatura INT;
DECLARE id INT;

OPEN cur1 

    bucle1:LOOP

        FETCH cur1 INTO temperatura;    
        IF done = 1 THEN 
        LEAVE bucle1;
        END IF 
        
        IF anyo > 1979 THEN 
            SELECT temperatura;
        END IF 

        @aux = CONCAT("INSERT INTO ", 'fichero.csv', "VALUES (id, temperatura) ")

        END LOOP bucle1;
CLOSE cur1; 

END $$ 

DELIMITER; 



/*Segundo try parte 1  El te daba la media por fecha de cada ciudad, Y tenías que hacer por país */

DELIMITER $$

DROP PROCEDURE IF EXISTS temperaturas_por_anyo $$

CREATE PROCEDURE temperaturas_por_anyo()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE anio INT;
    DECLARE sql_text TEXT;
    DECLARE nombre_fichero TEXT;

    -- Cursor para recorrer los años distintos desde 1980 en adelante
    DECLARE cur1 CURSOR FOR 
        SELECT DISTINCT YEAR(fecha) 
        FROM temperatura_pais 
        WHERE YEAR(fecha) >= 1980 
        ORDER BY YEAR(fecha);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur1;

    bucle: LOOP
        FETCH cur1 INTO anio;
        IF done THEN
            LEAVE bucle;
        END IF;

        -- Crear nombre de archivo para ese año
        SET nombre_fichero = CONCAT('/ruta/fichero_', anio, '.csv');

        -- Crear la consulta para ese año
        SET sql_text = CONCAT(
            'SELECT id_pais, AVG(temperatura) AS media, ',
                   'MIN(temperatura) AS minimo, ',
                   'MAX(temperatura) AS maximo ',
            'FROM temperatura_pais ',
            'WHERE YEAR(fecha) = ', anio, ' ',
            'GROUP BY id_pais ',
            'INTO OUTFILE \'', nombre_fichero, '\' ',
            'FIELDS TERMINATED BY \',\' ',
            'ENCLOSED BY \'"\' ',
            'LINES TERMINATED BY \'\\n\'''
        );

        -- Ejecutar la consulta
        PREPARE stmt FROM sql_text;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;



    END LOOP;

    CLOSE cur1;
END $$

DELIMITER ;



Hacer un bucle en el que vayas sumando +1 al año y hay que crear un documento por año, sacando 3 condiciones, si es un año anterior mensaje de error en un campo de varchar, si es anterior a un mes un warning y la ultima un log




Events --> haz un event que a tal hora y tal dia haga un call al primer procedure y al segundo a tal dia y tal hora, a partir de tal hora que empiece uno es cada mes y el otro es una fecha especifica

SET GLOBAL event_scheduler = ON;




DELIMITER $$

DROP EVENT IF EXISTS evento_diario_03 $$

CREATE EVENT evento_diario_03
ON SCHEDULE 
    EVERY 1 MONTH 
    STARTS '2025-06 -07 03:00:00'
DO
BEGIN
    CALL temperatura(8,2025);
END $$

DELIMITER ;

 











/*Triggers  guardar un log de una tabla especifica y si era mas antiguo de un año el aviso era warning, si era de hace un mes otro aviso. Muy parecido al de la ram 
como se usa la fecha,, te da las fechas en formato date, hay que comparar por años 

Si la fecha es mas de 1 año warning , si es mas de un mes el aviso y si es de este mes un aviso. IF fecha< NOW() - INTERVAL 1 YEAR THEN */

CREATE TABLE documentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200),
    fecha DATE
);

CREATE TABLE avisos_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_aviso VARCHAR(20),  -- 'Warning', 'Aviso', 'Log'
    mensaje TEXT,
    fecha_registro DATETIME
);



DELIMITER $$

DROP TRIGGER IF EXISTS documento_insert_aviso $$
CREATE TRIGGER documento_insert_aviso
AFTER INSERT ON documentos
FOR EACH ROW
BEGIN
    DECLARE tipo VARCHAR(20);
    DECLARE mensaje TEXT;

    IF YEAR(CURDATE()) - YEAR(NEW.fecha) >= 1 THEN
        SET tipo = 'Warning';
        SET mensaje = CONCAT('El documento "', NEW.titulo, '" es de hace más de un año.');

    ELSEIF YEAR(CURDATE()) = YEAR(NEW.fecha) 
           AND MONTH(CURDATE()) - MONTH(NEW.fecha) >= 1 THEN
        SET tipo = 'Aviso';
        SET mensaje = CONCAT('El documento "', NEW.titulo, '" tiene más de un mes.');

    ELSEIF YEAR(CURDATE()) = YEAR(NEW.fecha) 
           AND MONTH(CURDATE()) = MONTH(NEW.fecha) THEN
        SET tipo = 'Log';
        SET mensaje = CONCAT('El documento "', NEW.titulo, '" fue insertado este mes.');
    END IF;

    IF tipo IS NOT NULL THEN
        INSERT INTO avisos_log (tipo_aviso, mensaje, fecha_registro)
        VALUES (tipo, mensaje, NOW());
    END IF;
END $$

DELIMITER ;
