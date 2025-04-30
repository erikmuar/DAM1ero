#################################### TRIGGERS ##############################

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_historico
CREATE TRIGGER trigger_historico AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
    INSERT INTO historico nombre_antiguo , nombre_nuevo , usuario,
        fecha)
    VALUES (OLD.nombre , NEW.nombre , CURRENT_USER(), NOW()
END $$
DELIMITER;

-- Los triggers se activan cuando los usuarios hacen operaciones 

Temporalidad --> AFTER BEFORE

Operaciones --> INSERT UPDATE DELETE 

Una tabla solo puede tener un trigger asociado por temporalidad y operacion a controlar.


   

OLD./NEW.

Sirven para tratar datos previos o posteriores a la accion 

INSERT solo permite usar NEW.

UPDATE solo permite usar NEW. y OLD. 

DELETE solo permite usar OLD. 




-- Para mostrar los triggers: 

SHOW TRIGGERS;


-- Para mostrar la creación de los triggers: 

SHOW CREATE TRIGGER trigger_historico; 



-- Llamar a un procedure desde un trigger: 

DELIMITER $$ 

DROP TRIGGER IF EXISTS trigger_llamada_procedimiento $$ 

CREATE TRIGGER trigger_llamada_procedimiento AFTER INSERT ON personal 

FOR EACH ROW 
BEGIN 
    CALL nombre_procedimiento();
END $$
DELIMITER; 


-- EJEMPLO 

-Tabla del historico 


DROP TABLE IF EXISTS historico; 

CREATE TABLE historico(

id INT NOT NULL AUTO_INCREMENT, 
nombre_antiguo VARCHAR(20) NOT NULL,
nombre_nuevo VARCHAR (20), 
usuario VARCHAR (20),
fecha DATETIME, 
PRIMARY KEY (id)
); 

-Tabla de personal ç

DROP TABLE IF EXISTS personal;

CREATE TABLE personal(
ID INTEGER NOT NULL AUTO_INCREMENT,
nombre VARCHAR(20),
apellido VARCHAR(20),
PRIMARY KEY(ID)
);


# Inserción de datos:
INSERT INTO personal( nombre,apellido ) VALUES (Juan','López), (David','García)


# Trigger 

DELIMITER $$ 

DROP TRIGGER IF EXISTS trigger_historico $$
CREATE TRIGGER trigger_historico AFTER UPDATE ON personal
FOR EACH ROW 
BEGIN 

    INSERT INTO historico (nombre_antiguo , nombre_nuevo , usuario, fecha) VALUES (OLD.nombre , NEW.nombre , CURRENT_USER(), NOW());

END $$ 

DELIMITER; 



# Comprobación 

UPDATE personal SET nombre='Pablo' WHERE apellido ='Garcia';

SELECT * FROM historico;  # Aquí encontraremos un registro correspondiente al updete realizado

Resultado
ID --> 1
nombre_antiguo --> David
nombre_nuevo --> Pablo
usuario --> root@localhost
fecha --> 2019 03 18 14:35:43




######################### EVENTOS ########################################




DELIMITER $$ 
DROP EVENT IF EXISTS evento_log_diario $$
CREATE EVENT evento_log_diario
ON SCHEDULE EVERY 1 DAY 
DO BEGIN 
    SET @aux = CONCAT ("SELECT texto from log into outfile ", CURDATE(), "-log-diario.txt");
    PREPARE stmt1 FROM @aux;
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

END $$ 
DELIMITER; 


-- Los eventos se ejecutan en una temporalidad definida:

Programada --> AT 

Planificada --> Every 

Podemos trabajar con intervalos de tiempo: YEAR, MONTH, DAY, WEEK, etc.ABORT
Podemos definir inicio (STARTS) y final (ENDS) para los eventos.


# Activar el event scheduler:

SET GLOBAL event_scheduler = ON;
SET GLOBAL event_scheduler = 1;

# Desactivar el event scheduler:
SET GLOBAL event_scheduler = OFF; 
SET GLOBAL event_scheduler = 0;


#Mostrar los eventos: 
SHOW EVENTS;

# Muestra la creación de los eventos:
SHOW CREATE EVENT event_log_diario;





# Ejemplo Eventos

# Tablas
CREATE TABLE IF NOT EXISTS log (
  id int NOT NULL AUTO_INCREMENT,
  texto varchar(250) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS persona (
  id int NOT NULL AUTO_INCREMENT,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  apellido2 varchar(50) NOT NULL,
  correo_electronico varchar(100) NOT NULL,
  dni varchar(10) NOT NULL,
  PRIMARY KEY (id)
);

#Evento
DELIMITER $$
DROP EVENT IF EXISTS evento_log_diario $$
CREATE EVENT IF NOT EXISTS evento_log_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2019-01-01 00:00:00'
ENDS '2019-12-31 00:00:00'
DO BEGIN
  SET @aux = CONCAT ("SELECT texto from log into outfile '", CURDATE(), "-log-diario.txt'");
  PREPARE stmt1 FROM @aux;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;