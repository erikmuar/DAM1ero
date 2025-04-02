DELIMITER $$

DROP TRIGGER IF EXISTS trg_update_serverstatus $$
CREATE TRIGGER trg_update_serverstatus
AFTER UPDATE ON servidor
FOR EACH ROW
BEGIN

  IF NEW.is_broken IS TRUE THEN
    INSERT INTO alertas VALUES (null, 'Prioritario', CONCAT('El servidor ', NEW.id_servidor, ' está estropeado'));
  END IF;

  IF NEW.ram_upgrade IS TRUE THEN
   
    INSERT INTO alertas VALUES (null, 'Mantenimiento', CONCAT('Ram en el servidor ', NEW.id_servidor, ' aumentada'));
    UPDATE ServerStatus SET ram = ram + 256 WHERE id_servidor = NEW.id_servidor;
  END IF;


  IF NEW.ram_downgrade IS TRUE THEN
    set @vram = (SELECT ram FROM servidor WHERE id_servidor = NEW.id_servidor);
    IF @vram > 256 THEN 
        INSERT INTO alertas VALUES (null, 'Mantenimiento', CONCAT('Ram en el servidor ', NEW.id_servidor, ' reducida'));
        UPDATE servidor SET ram = ram - 256 WHERE id_servidor = NEW.id_servidor;
    END IF;
  END IF;
END $$

DELIMITER ;


DELIMITER $$
DROP TRIGGER IF EXISTS delete_servidor $$
CREATE TRIGGER delete_servidor AFTER DELETE ON servidor
FOR EACH ROW
BEGIN
  INSERT INTO alertas VALUES (null, 'Prioritario', CONCAT('El servidor ', OLD.id_servidor, ' ha sido eliminado'));
END $$
DELIMITER ;