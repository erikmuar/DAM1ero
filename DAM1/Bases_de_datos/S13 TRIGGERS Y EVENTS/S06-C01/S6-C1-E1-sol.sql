DELIMITER $$
DROP TRIGGER IF EXISTS update_servidorstatus $$
CREATE TRIGGER update_servidorstatus AFTER UPDATE ON servidorstatus
FOR EACH ROW
BEGIN

  IF NEW.is_broken IS TRUE THEN
    INSERT INTO alertas VALUES (null, "Prioritario", CONCAT("El servidor ", NEW.id_servidor, " esta estropeado."), null, NOW());
  END IF;

  IF NEW.ram_upgrade IS TRUE THEN
    INSERT INTO alertas VALUES (null, "Mantenimento", CONCAT("Ram al servidor ", NEW.id_servidor, " augmentada."), null, NOW());
    UPDATE servidor SET ram = ram + 256 WHERE id_servidor = NEW.id_servidor;
  END IF;

  IF NEW.ram_downgrade IS TRUE THEN
    SET @vram = (SELECT ram FROM servidor WHERE id_servidor = NEW.id_servidor);
    IF @vram > 256 THEN
      INSERT INTO alertas VALUES (null, "Mantenimento", CONCAT("Ram al servidor ", NEW.id_servidor, " reducida."), null, NOW());
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
  INSERT INTO alertes VALUES (null, "Baja", CONCAT("El servidor ", OLD.id_servidor, " se ha dado de baja."), null, NOW());
END $$
DELIMITER ;
