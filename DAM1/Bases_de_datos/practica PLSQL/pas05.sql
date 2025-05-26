DELIMITER $$

CREATE PROCEDURE afegir_activitat_nova(
    IN nom_input VARCHAR(50),
    IN descripcio_input VARCHAR(255)
)
BEGIN
    DECLARE nom_validat VARCHAR(50);
    DECLARE descripcio_validada VARCHAR(255);
    DECLARE comptador INT;

    -- Convertim a minúscules i validem valors nuls o buits
    SET nom_validat = LOWER(TRIM(COALESCE(NULLIF(nom_input, ''), 'activitat_desconeguda')));
    SET descripcio_validada = TRIM(COALESCE(NULLIF(descripcio_input, ''), 'Descripció no disponible'));

    -- Comprovem si ja existeix el registre
    SELECT COUNT(*) INTO comptador
    FROM MD_activitat
    WHERE LOWER(nom) = nom_validat;

    -- Si no existeix, l'afegim
    IF comptador = 0 THEN
        INSERT INTO MD_activitat (id_activitat, nom, descripcio)
        VALUES (
            (SELECT COALESCE(MAX(id_activitat), 0) + 1 FROM MD_activitat),
            nom_validat,
            descripcio_validada
        );
    END IF;
END $$

DELIMITER ;


--Com fer-lo servir
CALL afegir_activitat_nova('Correr', 'Activitat cardiovascular d'intensitat mitjana');
CALL afegir_activitat_nova('', '');
CALL afegir_activitat_nova('Caminar', NULL);
