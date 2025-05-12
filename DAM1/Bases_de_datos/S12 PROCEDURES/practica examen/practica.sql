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


average de temperatura y ponerlo dentro de un fichero desde  el 1980 hasta ahora y que el nombre del fichero sea dinamico. Mirar AVG y selects 

Hacer un bucle en el que vayas sumando +1 al año y hay que crear un documento por año, sacando 


Events --> haz un event que a tal hora y tal dia haga un call al primer procedure y al segundo a tal dia y tal hora, a partir de tal hora que empiece uno es cada mes y el otro es una fecha especifica

SET GLOBAL 

Triggers  guardar unlog de una tabla especifica y si era mas antiguo el aviso era warning, si era de hace un mes otro aviso. Muy parecido al de la ram 
como se usa la fecha,, te da las fechas en formato date, hay que comparar por años 
 


/*
Aneu a Northwind.
Creeu un procediment que mostri les dades de shippers per pantalla.
*/



DELIMITER $$

DROP PROCEDURE IF EXISTS proc_shippers $$
CREATE PROCEDURE proc_shippers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE shipperID INT;
    DECLARE CompanyName VARCHAR(200);
    DECLARE Phone VARCHAR(20);

    DECLARE cur1 CURSOR FOR SELECT * FROM shippers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur1;

    bucle: LOOP
        FETCH cur1 INTO shipperID, CompanyName, Phone;

        IF done = 1 THEN
            LEAVE bucle;
        END IF;

        SELECT shipperID, CompanyName, Phone;
    END LOOP bucle;

    CLOSE cur1;
END $$

DELIMITER ;



CALL proc_shippers();


/*
Aneu a la BD Northwind.
Mireu la taula customers.
Feu un procediment que comprovi si un CustomerID existeix. En cas de que exiteixi, que retorni el seu ContactName.
Si no existeix que mostri un missatge d'error.

Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).
*/


DELIMITER $$

DROP PROCEDURE IF EXISTS proc_custom $$
CREATE PROCEDURE proc_custom ((IN vCustomerID VARCHAR(29), (OUT vContactName VARCHAR(100))
BEGIN 


    DECLARE iContactName VARCHAR(100)
    DECLARE iCustomerID VARCHAR(10)
    DECLARE done INT DEFAULT 0;

    DECLARE cur1 CURSOR FOR SELECT CustomerID, ContactName FROM customers; 
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur1;
    bucle: LOOP

            FETCH cur1 INTO iCustomerID,iContactName ;

        IF done = 1 THEN
            LEAVE bucle;
        ELSEIF vCustomerID = iCustomerID THEN 
            SELECT iContactName;
            vContactName = iContactName;
            LEAVE bucle;
        
        ELSE 

        SELECT 'Error, ID no trobat';

                END IF;


    END LOOP bucle;

    CLOSE cur1;

    END $$

DELIMITER ; 

        

/*
Aneu a la BD Northwind.
Mireu la taula orders.
Creeu una taula nova que es digui orders_bck i que tingui la mateixa estructura que la taula orders més una columna que es digui bck_date de tipus DATETIME.

Feu un procediment que usi un cursor per recòrrer tota la taula orders i que insereixi les files dins de la taula orders_bck afegint la data actual a l'última columna.
*/


DELIMITER $$ 

DROP PROCEDURE IF EXISTS proc_orders $$ 
CREATE PROCEDURE proc_orders() 



/*EXERCICI 1:
Useu la base de dades mymovies.
Creeu un procedure nou que mostri per pantalla el títol i l'any de creació de totes les pel·lícules que hàgin estat
creades dins d'un període d'anys especificat per l'usuari i ordenades per data de creació i títol de la pel·lícula.

El seu call per exemple podria ser: CALL getMoviesByYear(1986,2001);

Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.*/


DELIMETER $$ 

DROP PROCEDURE IF EXISTS getMoviesByYear $$
CREATE PROCEDURE getMoviesByYear (IN any1 INT, IN any2 INT)
BEGIN 

DECLARE nombre INT; 
DECLARE anyo_peli INT; 
DECLARE done INT DEFAULT 0; 


DECLARE cur1 CURSOR FOR SELECT name, year FROM movies WHERE year >= any1 AND year <= any2 ORDER BY year, name DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


 OPEN cur1 
 bucle:LOOP

    FETCH cur1 INTO nombre, anyo_peli;

    IF done = 1 THEN 
        LEAVE bucle;
    END IF;

    SELECT nombre, anyo_peli;


END LOOP bucle;

CLOSE cur1;

END $$ 

DELIMITER ; 


CALL getMoviesByYear(2010,2020);



/*EXERCICI 2:
Useu la base de dades mymovies.
Creeu un procedure nou que mostri per pantalla el títol i l'any de creació de totes les pel·lícules que en el seu títol de la pel·lícula continguin
el text passat per paràmetre.

El seu call per exemple podria ser: CALL getMoviesByName('Superman');

Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.*/


DELIMITER $$
DROP PROCEDURE IF EXISTS getMoviesByName $$
CREATE PROCEDURE getMoviesByName(IN nombre_peli VARCHAR(29))
BEGIN 

DECLARE done INT DEFAULT 0;
DECLARE titulo VARCHAR(200);
DECLARE anyo INT (10);

DECLARE cur1 CURSOR FOR SELECT name, year FROM movies WHERE name LIKE @aux;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

SET @aux = CONCAT('%',nombre_peli,'%');

OPEN cur1;
bucle: LOOP 

    FETCH cur1 INTO titulo, anyo;

    IF done = 1 THEN 
        LEAVE bucle;
    END IF;
    
    SELECT titulo AS Titiulo, anyo AS Año;
    

END LOOP bucle;

CLOSE cur1; 

END $$

DELIMITER ;


CALL getMoviesByName('Superman');


/*EXERCICI 3:
Useu la base de dades mymovies.
Creeu un procedure nou que permeti a l'usuari calcular els beneficis d'una pel·lícula en concret especificant el seu id de pel·lícula.
Els beneficis de les pel·lícules es calculen multiplicant la columna stockUnits * price.
Els beneficis de la peli s'han de guardar en una variable de sortida.
Aquest procedure només té un paràmetre.

El seu call per exemple podria ser:

DECLARE X FLOAT;
SET X = 36;
CALL calculateRevenue(X);
SELECT X;

Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.*/
        


DELIMITER $$ 

DROP PROCEDURE IF EXISTS calculateRevenue $$
CREATE PROCEDURE calculateRevenue (IN id_pelicula INT, OUT benefici DECIMAL (10,2))
BEGIN 

DECLARE done INT DEFAULT 0;
DECLARE beneficios FLOAT(20,2);


DECLARE cur1 CURSOR FOR SELECT stockUnits * price FROM movies WHERE id = id_pelicula;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


OPEN cur1;
bucle:LOOP

    FETCH cur1 INTO beneficios; 

    IF done = 1 THEN    
        LEAVE bucle;
    END IF;

    SET benefici = beneficios;

END LOOP bucle; 

CLOSE cur1;
    

END $$

DELIMITER ; 





/*Tenemos que a traves de la insercion de un año en el procedure, sacar la media de temperaturas */