-- Triggers


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





