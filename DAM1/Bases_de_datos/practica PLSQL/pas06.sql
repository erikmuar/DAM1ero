CREATE TABLE auditoria_insercions (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuari INT,
    data_activitat DATE,
    hora_inici TIME,
    tipus_activitat VARCHAR(50),
    data_insercio DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuari_mysql VARCHAR(100)
);

DELIMITER $$

DROP TRIGGER IF EXISTS trigger_auditoria_insercio $$

CREATE TRIGGER trigger_auditoria_insercio 
AFTER INSERT ON activitats_net
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_insercions (
        id_usuari, data_activitat, hora_inici, tipus_activitat, usuari_mysql
    ) 
    VALUES (
        NEW.id_usuari, NEW.data_activitat, NEW.hora_inici, NEW.tipus_activitat, CURRENT_USER()
    );
END $$

DELIMITER ;

-- Tabla d'auditoria per modificacions i esborrats
CREATE TABLE auditoria_md_activitat (
    id_auditoria INT AUTO_INCREMENT,
    accio VARCHAR(10),  
    id_activitat INT,
    nom_antic VARCHAR(100),
    descripcio_antiga VARCHAR(200),
    data_event DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuari_mysql VARCHAR(100),
    PRIMARY KEY (id_auditoria)
);

DELIMITER $$

DROP TRIGGER IF EXISTS trigger_md_activitat_update $$

CREATE TRIGGER trigger_md_activitat_update 
AFTER UPDATE ON MD_activitat
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_md_activitat (
        accio, id_activitat, nom_antic, descripcio_antiga, usuari_mysql
    ) 
    VALUES (
        'UPDATE', OLD.id_activitat, OLD.nom, OLD.descripcio, CURRENT_USER()
    );
END $$

DROP TRIGGER IF EXISTS trigger_md_activitat_delete $$

CREATE TRIGGER trigger_md_activitat_delete 
AFTER DELETE ON MD_activitat
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_md_activitat (
        accio, id_activitat, nom_antic, descripcio_antiga, usuari_mysql
    ) 
    VALUES (
        'DELETE', OLD.id_activitat, OLD.nom, OLD.descripcio, CURRENT_USER()
    );
END $$

DELIMITER ;
