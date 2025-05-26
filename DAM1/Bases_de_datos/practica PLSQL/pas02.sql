CREATE TABLE activitats_net (
    id_usuari INT,
    data_activitat DATE,
    hora_inici TIME,
    durada_minuts INT,
    tipus_activitat VARCHAR(50),
    calories INT,
    dispositiu VARCHAR(50),
    cap_de_setmana BOOLEAN
);


DELIMITER $$

CREATE PROCEDURE importar_activitats_dia_anterior()
BEGIN
    DECLARE dia_anterior DATE;
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
END $$

DELIMITER ;

CALL importar_activitats_dia_anterior();
