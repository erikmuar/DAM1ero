-- 1 

DELIMITER $$
DROP TRIGGER IF EXISTS trigger $$
CREATE TRIGGER trigger AFTER UPDATE ON ServerStatus
FOR EACH ROW 
BEGIN 


IF NEW.is_broken IS TRUE THEN
    INSERT INTO alerta VALUES ("Prioritario", CONCAT("El servidor ", ID_SERVIDOR, " está estropeado", NOW());
END IF 

IF NEW.ram_upgrade IS TRUE THEN
    INSERT INTO alertas VALUES ("Prioritario", CONCAT("Ram en el servidor ", ID_SERVIDOR, "  reducida", NOW());
    UPDATE servidor SET ram = ram + 256 WHERE ID_SERVIDOR = NEW.ID_SERVIDOR;
END IF 


IF NEW.ram_downgrade IS TRUE THEN

    @ram = (SELECT ram FROM servidor WHERE id_servidor = NEW.id_servidor);
    IF ram > 256 THEN
        INSERT INTO alerta VALUES("Mantenimiento", "Ram en el servidor ", ID_SERVIDOR, " reducida", NOW());
        UPDATE serviror SET ram = ram - 256 WHERE id_servidor = NEW.id_servior; 
    END IF
END IF 


END $$

DELIMITER; 


DELIMITER $$ 
DROP TRIGGER IF EXISTS trigger $$
CREATE TRIGGER trigger AFTER DELETE ON servidor 
FOR EACH ROW 
BEGIN 

INSERT INTO alerta VALUES("Baja", "El servidor ", ID_SERVIDOR, " ha sido dado de baja", NOW()); 

END $$ 

DELIMITER; 


-- 2



DELIMITER $$

DROP TRIGGER IF EXISTS trigger_insert $$
CREATE TRIGGER trigger_insert AFTER INSERT ON log 


