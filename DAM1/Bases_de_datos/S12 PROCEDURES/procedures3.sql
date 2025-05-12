/* 1 
Aneu a Northwind.
Creeu un procediment que mostri les dades de shippers per pantalla.
*/

DELIMITER $$

DROP PROCEDURE IF EXISTS mostrarTransportistas $$

CREATE PROCEDURE showShippers()
BEGIN
    SELECT * FROM Shippers;
END $$

DELIMITER ;


/* 2 
Aneu a la BD Northwind.
Mireu la taula customers.
Feu un procediment que comprovi si un CustomerID existeix. En cas de que exiteixi, que retorni el seu ContactName.
Si no existeix que mostri un missatge d'error.

Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).
*/

CREATE PROCEDURE checkCustomerID(IN vCustomerID VARCHAR(??), OUT vContactName VARCHAR(??))

DELIMITER $$

DROP PROCEDURE IF EXISTS comprobarCliente $$

CREATE PROCEDURE comprobarCliente(
    IN vCustomerID VARCHAR(10), 
    OUT vContactName VARCHAR(50)
)
BEGIN
    SELECT ContactName INTO vContactName 
    FROM Customers 
    WHERE CustomerID = vCustomerID;
    
    IF vContactName IS NULL THEN
        SET vContactName = 'Error: Cliente no encontrado';
    END IF;
    
END $$

DELIMITER ;
