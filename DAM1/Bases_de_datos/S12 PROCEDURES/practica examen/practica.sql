-- EJEMPLO BASICO Definimos la tabla personal con tres campos (ID, nombre, apellido).
-- Definimos una segunda tabla historial para guardar datos históricos ( ID’s
-- Cargamos datos en la tabla con la herramienta INSERT.
-- Creamos un procedimiento llamado lectorBasico que lea las ID’s de la
-- tabla de personal, las muestre por pantalla una a una y las inserte en la
-- tabla de historial.


DROP TABLE IF EXISTS personal;

CREATE TABLE personal(

    ID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID)

);


DROP TABLE IF EXISTS historial; 

CREATE TABLE IF EXISTS historial(

    id_personal INT NOT NULL
);


INSERT INTO personal(nombre, apellido) VALUES ('Juan','Juanson'),('Jaime', 'Jaimeson'), ('Carlos', 'Carleton');


DELIMITER $$
DROP PROCEDURE IF EXISTS lector_basico $$
CREATE PROCEDURE lector_basico()

BEGIN 

DECLARE cur1 CURSOR FOR SELECT id FROM personal;
DECLARE done INT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
DECLARE identificador INT;


    OPEN cur1
    bucle1:LOOP

        FETCH cur1 INTO identificador;

        IF done = 1 THEN
            LEAVE bucle1
        END IF 

        SELECT identificador; 

        INSERT INTO historial VALUES (identificador);

            
    END LOOP bucle1;
        CLOSE cur1;
END $$

DELIMITER; 




