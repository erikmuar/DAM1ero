# Ejemplo Triggers

# Tablas
CREATE TABLE historico(
	ID INTEGER NOT NULL AUTO_INCREMENT,
	nombre_antiguo VARCHAR(20),
	nombre_nuevo VARCHAR(20),
	usuario VARCHAR(40),
	fecha DATETIME,
	PRIMARY KEY(ID)
);


CREATE TABLE personal(
	ID INTEGER NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(20),
	apellido VARCHAR(20),
	PRIMARY KEY(ID)
);


#Trigger
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_historico $$
CREATE TRIGGER trigger_historico AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
	INSERT INTO historico(nombre_antiguo, nombre_nuevo, usuario, fecha) 
	VALUES (OLD.nombre, NEW.nombre, CURRENT_USER(), NOW() );
END $$
DELIMITER ; 


#Ejemplo de uso y comprovación
INSERT INTO personal(nombre,apellido) VALUES ('Juan','López'),('David','García');

SELECT * FROM historico; # Aquí la tabla estará vacía

UPDATE personal SET nombre='Pablo' WHERE apellido='García';

SELECT * FROM historico; # Aquí encontraremos un registro correspondiente al updete realizado




