SET GLOBAL event_scheduler = 1; 

USE procedures;

delete from missatge;

DROP TABLE Missatge;

CREATE TABLE Missatge(
	id INT AUTO_INCREMENT,
    text_missatge TEXT NOT NULL ,
    data_hora DATETIME NOT NULL,
    CONSTRAINT PK_Missatge PRIMARY KEY (id)
    );
    
SELECT *
FROM missatge;

DELIMITER &&
DROP EVENT IF EXISTS calleu &&

CREATE EVENT IF NOT EXISTS calleu
ON SCHEDULE EVERY 10 SECOND
STARTS current_timestamp()
ENDS current_timestamp() + INTERVAL 2 MINUTE
DO BEGIN -- Tenir en compte el DO BEGIN enlloc de BEGIN a seques
	INSERT INTO procedures.missatge(text_missatge, data_hora)
    VALUES("CALLEU!", now());
END &&
DELIMITER ;

DELIMITER &&
DROP EVENT IF EXISTS calleu2 &&

CREATE EVENT IF NOT EXISTS calleu2
ON SCHEDULE EVERY 10 SECOND
STARTS NOW() + INTERVAL 1 DAY
ENDS '2022-03-25 00:00:00'
DO BEGIN -- Tenir en compte el DO BEGIN enlloc de BEGIN a seques
	INSERT INTO procedures.missatge(text_missatge, data_hora)
    VALUES("CALLEU!", now());
END &&
DELIMITER ;


DELIMITER ((
DROP EVENT IF EXISTS exportDades ((
CREATE EVENT IF NOT EXISTS exportDades
ON SCHEDULE AT NOW() 
	+ INTERVAL 1 MINUTE + INTERVAL 10 SECOND
DO BEGIN
	CALL northwind.exportOrderDetailsPerCountry();
END ((
DELIMITER ;
