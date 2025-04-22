# Primer trigger
DELIMITER $$
DROP TRIGGER IF EXISTS insert_persona $$
CREATE TRIGGER insert_persona AFTER INSERT ON persona
FOR EACH ROW
BEGIN
 INSERT INTO log VALUES (null, CONCAT("Se ha añadido un usuario nuevo con id: ",NEW.id," y el DNI: ",NEW.dni));
END $$
DELIMITER ;

# Segundo trigger
DELIMITER $$
DROP TRIGGER IF EXISTS update_persona $$
CREATE TRIGGER update_persona AFTER UPDATE ON persona
FOR EACH ROW
BEGIN

	IF OLD.nombre <> NEW.nombre THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo nombre. El valor antiguao era ",OLD.nombre,". El valor nuevo es ",NEW.nombre,"."));
	END IF;
	
	IF OLD.apellido <> NEW.apellido THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido. El valor antiguao era ",OLD.apellido,". El valor nuevo es ",NEW.apellido,"."));
	END IF;

	IF OLD.apellido2 <> NEW.apellido2 THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido2. El valor antiguao era ",OLD.apellido2,". El valor nuevo es ",NEW.apellido2,"."));
	END IF;

	IF OLD.correo_electronico <> NEW.correo_electronico THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo correo_electronico. El valor antiguao era ",OLD.correo_electronico,". El valor nuevo es ",NEW.correo_electronico,"."));
	END IF;

	IF OLD.dni <> NEW.dni THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo dni. El valor antiguao era ",OLD.dni,". El valor nuevo es ",NEW.dni,"."));
	END IF;

END $$
DELIMITER ;

# Tercer trigger
DELIMITER $$
DROP TRIGGER IF EXISTS delete_persona $$
CREATE TRIGGER delete_persona AFTER DELETE ON persona
FOR EACH ROW
BEGIN
	INSERT INTO log VALUES (null, CONCAT("Se ha eliminado el registro del usuario con id: ",OLD.id," y el DNI: ",OLD.dni));
END $$
DELIMITER ;
