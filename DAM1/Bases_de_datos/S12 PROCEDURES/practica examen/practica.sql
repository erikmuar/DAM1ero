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



Ficheros, mirar bien los campos que hay que insertar. solo no poner 
mete estos datos del csv en una tabla, no poner ignore one 


Te pide el año y te dice que hagas la media de temperatura e ID por año de cada pais, el mínimo, el máximo. 


average de temperatura y ponerlo dentro de un fichero desde el 1980 hasta ahora y que el nombre del fichero sea dinamico. Mirar AVG y selects 

Hacer un bucle en el que vayas sumando +1 al año y hay que crear un documento por año, sacando 


Events --> haz un event que a tal hora y tal dia haga un call al primer procedure y al segundo a tal dia y tal hora, a partir de tal hora que empiece uno es cada mes y el otro es una fecha especifica

SET GLOBAL 

Triggers  guardar unlog de una tabla especifica y si era mas antiguo el aviso era warning, si era de hace un mes otro aviso. Muy parecido al de la ram 
como se usa la fecha,, te da las fechas en formato date, hay que comparar por años 
 
