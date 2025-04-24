# Tablas

CREATE TABLE IF NOT EXISTS `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `apellido2` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dni` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
);

# Tarea 1
CREATE TABLE IF NOT EXISTS `combinaciones` (
  `nombre` varchar(50),
  `apellido` varchar(50),
  `apellido2` varchar(50)
);

DELIMITER  $$
DROP PROCEDURE IF EXISTS ej5Tarea1 $$
CREATE PROCEDURE ej5Tarea1 ()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE vnombre VARCHAR(50);
    DECLARE vapellido VARCHAR(50);
    DECLARE vapellido2 VARCHAR(50);

    DECLARE cur1 CURSOR FOR SELECT nombre FROM persona;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

    OPEN cur1;
    primer_loop: LOOP

      FETCH cur1 INTO vnombre;
      IF done=1 THEN
        LEAVE primer_loop;
      END IF;
      BEGIN
        DECLARE cur2 CURSOR FOR SELECT apellido FROM persona;
        OPEN cur2;

        segundo_loop: LOOP

          FETCH cur2 INTO vapellido;
          IF done=1 THEN
            LEAVE segundo_loop;
          END IF;

          BEGIN
            DECLARE cur3 CURSOR FOR SELECT apellido2 FROM persona;
            OPEN cur3;

            tercer_loop: LOOP

            FETCH cur3 INTO vapellido2;
            IF done=1 THEN
              LEAVE tercer_loop;
            END IF;

            INSERT INTO combinaciones VALUES (vnombre, vapellido, vapellido2);

            END LOOP tercer_loop;
            CLOSE cur3;
            SET done = 0;
          END;
        END LOOP segundo_loop;
        CLOSE cur2;
        SET done = 0;
      END;
    END LOOP primer_loop;
    CLOSE cur1;

END $$
DELIMITER ;


# Tarea 2, solución A
DELIMITER $$
DROP PROCEDURE IF EXISTS  ej5Tarea2A  $$
CREATE PROCEDURE  ej5Tarea2A (IN vdni VARCHAR(50), OUT vmail VARCHAR(100))
BEGIN
  DECLARE done INT DEFAULT 0;

  DECLARE cur1 CURSOR FOR SELECT email FROM persona WHERE dni = vdni;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  SET vmail = CONCAT("El usuario con el DNI: ", vdni, " no existe.");

  OPEN cur1;
  bucle: LOOP

    FETCH cur1 INTO vmail;
    IF done=1 THEN
      LEAVE bucle;
    END IF;

  END LOOP bucle;
  CLOSE cur1;

END $$
DELIMITER ;

# Tarea 2, solución B
DELIMITER $$
DROP PROCEDURE IF EXISTS  ej5Tarea2B $$
CREATE PROCEDURE ej5Tarea2B (IN vdni VARCHAR(50), OUT vmail VARCHAR(100))
BEGIN

  SELECT email into vmail FROM persona WHERE dni = vdni;

  IF vmail IS NULL THEN
  	  SET vmail = CONCAT("L'usuari amb el DNI: ", vdni, " no existeix.");
  END IF;

END $$
DELIMITER ;

# Tarea 3 (Suponiendo que el DNI no tendra nunca mas de 8 números)
DELIMITER $$
DROP PROCEDURE IF EXISTS ej5Tarea3 $$
CREATE PROCEDURE ej5Tarea3 (IN vid INT(11))
BEGIN
  DECLARE vnombre VARCHAR(50);
  DECLARE vapellido VARCHAR(50);
  DECLARE vapellido2 VARCHAR(50);
  DECLARE vmail VARCHAR(100);
  DECLARE vdni VARCHAR(50);

  DECLARE done INT DEFAULT 0;
  DECLARE encontrado INT DEFAULT 0;

  DECLARE cur1 CURSOR FOR SELECT nombre, apellido, apellido2, email, dni FROM persona WHERE id = vid;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

  OPEN cur1;
  bucle: LOOP

    FETCH cur1 INTO vnombre, vapellido, vapellido2, vmail, vdni;
    IF done=1 THEN
      IF encontrado = 0 THEN
        SELECT CONCAT("No se ha encontrado ningún registro con la id: ", vid);
      END IF;
      LEAVE bucle;
    END IF;
    SET encontrado = 1;

    SET vnombre = CONCAT(UCASE(LEFT(vnombre, 1)), LCASE(SUBSTRING(vnombre, 2)));
    SET vapellido = CONCAT(UCASE(LEFT(vapellido, 1)), LCASE(SUBSTRING(vapellido, 2)));
    SET vapellido2 = CONCAT(UCASE(LEFT(vapellido2, 1)), LCASE(SUBSTRING(vapellido2, 2)));

    SET vmail = LCASE(vmail);

    # Esta parte del procedimiento se podria hacer de muchas otras maneras (utilizando bucles y/o otras funciones)
    IF RIGHT(vdni, 1) REGEXP '^[A-Z]' THEN
      SET vdni = LPAD(vdni, 9, 0);
    END IF;

    IF RIGHT(vdni, 1) REGEXP '^[a-z]' THEN
      SET vdni = UCASE(LPAD(vdni, 9, 0));
    END IF;

    IF LENGTH(vdni) < 9 THEN
      SET vdni = CONCAT(LPAD(vdni, 8, 0), 'A');
    END IF;

    UPDATE persona SET nombre = vnombre, apellido = vapellido, apellido2 = vapellido2, email = vmail, dni = vdni WHERE id = vid; 

  END LOOP bucle;
  CLOSE cur1;

END $$
DELIMITER ;
