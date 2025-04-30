Variables declaradas: DECLARE id INT;
Variables no declaradas: @aux, @cadena_texto;

SET @aux = TRUE;
SET id = 5;
SET @aux = FALSE;


SET @aux = CONCAT(“INSERT INTO “, nombre_tabla , ” SELECT * FROM “ ,
nombre_bbdd , “.”, nombre_tabla);
PREPARE stmt1 FROM @aux
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

<IN OUT INOUT > nombre_parametro > tipo_parametro
IN vid INTEGER
OUT vfecha DATE
INOUT vcadena VARCHAR(50)


-- Condicionales y bucles

DELIMITER $$
DROP PROCEDURE IF EXISTS calculo $$
CREATE PROCEDURE calculo( IN param1 INTEGER)
BEGIN
        DECLARE var1 CHAR(10);
        
    //contenido del IF
END $$
DELIMITER;



IF param1=1 THEN

    SELECT 'opcion_if';
    SET var1 = 'opcion_if';

    ELSE 
    SELECT 'opcion_else';
    SET var1 = 'opcion_else';
END IF;
INSERT INTO table1 VALUES (var1);


-- CASE

SELECT CASE
    WHEN param1 = 1 THEN 'opcion_1'
    WHEN param1 = 2 THEN 'opcion_2'
    ELSE 'opcion_default'
END CASE;   



DELIMETER $$

DROP PROCEDURE IF EXISTS procedimiento $$
CREATE PROCEDURE procedimiento(IN param1 INT)
BEGIN   
    CASE param1
        WHEN 1 THEN
            SELECT 'Opción 1 seleccionada';
        WHEN 2 THEN
            SELECT 'Opción 2 seleccionada';
        ELSE
            SELECT 'Opción no válida';
    END CASE;   
END $$
DELIMITER ;


-- WHILE

DELIMITER $$
DROP PROCEDURE IF EXISTS procedimiento $$
CREATE PROCEDURE procedimiento()

BEGIN 
    WHILE var1>0 DO
        SELECT var1;
        SET var1 = var1 - 1;
    END WHILE;
END $$
DELIMITER ;


-- LOOP

etiqueta: LOOP
    -- Aquí va el código que se ejecutará en el bucle
    -- Puedes usar un IF para salir del bucle si es necesario
    IF condicion=1 THEN
        LEAVE etiqueta;
    END IF;
END LOOP etiqueta;

DELIMETER $$

DROP PROCEDURE IF EXISTS procedimiento $$
CREATE PROCEDURE procedimiento()
BEGIN
    DECLARE incremento;
    SET incremento = 0;
    etiqueta: LOOP
        SET incremento = incremento + 1;
        IF incremento > 10 THEN
            LEAVE etiqueta;
        END IF;
    END LOOP etiqueta;
END $$


-- HANDLERS 

-- Los HANDLERS nos permiten controlar la finalización de los bucles LOOP ya que se activan al finalizar el contenido de un SELECT.

DECLARE done INT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Los CURSORS son un instrumento de lectura que permite examinar y tratar fila a fila una selección o tabla. Se tienen que declarar después de las variables y antes que los HANDLERS.

DECLARE nombre_cursor CURSOR FOR (Query sin INTO);


OPEN nombre_cursor;
FETCH nombre_cursor INTO variable1, variable2, ...;
CLOSE nombre_cursor;

-- ¿El número de variables a usar en el FETCH de que depende? El número de variables del FETCH tiene que corresponder con el numero de atributos seleccionados en el CURSOR asociado.

DECLARE cur1 CURSOR FOR SELECT nombre, apellido FROM persona);
FETCH cur1 INTO vnombre, vapellido;



-- EJEMPLO BASICO Definimos la tabla personal con tres campos (ID, nombre, apellido).
-- Definimos una segunda tabla historial para guardar datos históricos ( ID’s
-- Cargamos datos en la tabla con la herramienta INSERT.
-- Creamos un procedimiento llamado lectorBasico que lea las ID’s de la
-- tabla de personal, las muestre por pantalla una a una y las inserte en la
-- tabla de historial.


CREATE TABLE personal(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE historial(
ID_persona INT NOT NULL,
);

INSERT INTO personal (nombre, apellido) VALUES ('Juan','Pérez'),('Ana','Gómez'),('Luis','Martínez');


DELIMITER $$
DROP PROCEDURE IF EXISTS lector_basico $$
CREATE PROCEDURE lector_basico()
BEGIN   
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INT;
    DECLARE cur1 CURSOR FOR SELECT id FROM personal;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Tratamiento del cursor
        OPEN cur1;
        bucle1:LOOP
            FETCH cur1 INTO identificador; -- Con el fetch obtenemos el valor de identificador
            -- Si el cursor ha llegado al final, salimos del bucle
            IF done=1 THEN
                LEAVE bucle1;
            END IF;
            -- Aquí puedes realizar operaciones con el identificador obtenido
            SELECT identificador;
            INSERT INTO historial VALUES (identificador);
        END LOOP bucle1;
        CLOSE cur1;
    END $$

    DELIMITER; 
    
































DELIMITER $$

DROP PROCEDURE IF EXISTS procedimiento $$
CREATE PROCEDURE procedimiento
({IN fech DATE})
BEGIN 
    DECLARE fecha DATE;
    DECLARE id INT;
    DECLARE nombre VARCHAR(50);
    DECLARE precio DECIMAL(10,2);
    DECLARE cantidad INT;
    DECLARE total DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;
    
    -- Cursor para seleccionar los productos vendidos en la fecha dada
    DECLARE cur CURSOR FOR 
        SELECT p.id_producto, p.nombre, p.precio, d.cantidad, (p.precio * d.cantidad) AS total
        FROM productos p
        JOIN detalles_venta d ON p.id_producto = d.id_producto
        JOIN ventas v ON d.id_venta = v.id_venta
        WHERE v.fecha = fecha;
    
    -- Handler para cerrar el cursor al finalizar
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Abrir el cursor
    OPEN cur;
    
    -- Bucle para recorrer los resultados del cursor
    read_loop: LOOP
        FETCH cur INTO id, nombre, precio, cantidad, total;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Aquí puedes realizar las operaciones que necesites con los datos obtenidos
        SELECT CONCAT('ID: ', id, ', Nombre: ', nombre, ', Precio: ', precio, ', Cantidad: ', cantidad, ', Total: ', total) AS resultado;
        
    END LOOP read_loop;
    
    -- Cerrar el cursor
    CLOSE cur;
END $$

