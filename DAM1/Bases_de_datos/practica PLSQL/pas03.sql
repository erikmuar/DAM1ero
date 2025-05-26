CREATE TABLE control_carregues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_fitxer VARCHAR(100),
    files_inserides INT,
    data_carrega DATETIME
);

DELIMITER $$

CREATE PROCEDURE importar_activitats_dia_anterior(
    IN nom_fitxer VARCHAR(100)
)
BEGIN
    DECLARE dia_anterior DATE;
    DECLARE files_insertades INT;

    SET dia_anterior = CURDATE() - INTERVAL 1 DAY;

    INSERT INTO activitats_net (
        id_usuari,
        data_activitat,
        hora_inici,
        durada_minuts,
        tipus_activitat,
        calories,
        dispositiu,
        cap_de_setmana
    )
    SELECT
        id_usuari,
        data_activitat,
        hora_inici,
        durada_minuts,
        tipus_activitat,
        calories,
        dispositiu,
        CASE 
            WHEN DAYOFWEEK(data_activitat) IN (1, 7) THEN TRUE
            ELSE FALSE
        END AS cap_de_setmana
    FROM activitats_raw
    WHERE DATE(data_activitat) = dia_anterior;

    SET files_insertades = ROW_COUNT();

    INSERT INTO control_carregues (nom_fitxer, files_inserides, data_carrega)
    VALUES (nom_fitxer, files_insertades, NOW());
END $$

DELIMITER ;

CALL importar_activitats_dia_anterior('activitats_iso08601.csv');


DELIMITER $$

CREATE PROCEDURE exportar_control_carregues()
BEGIN
    SELECT * FROM control_carregues
    INTO OUTFILE 'C:/xampp/mysql/data/control_carregues.csv'
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';
END $$

DELIMITER ;

CALL exportar_control_carregues();


