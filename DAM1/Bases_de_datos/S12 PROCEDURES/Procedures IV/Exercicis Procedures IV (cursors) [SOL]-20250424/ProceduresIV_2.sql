use mymovies;

DELIMITER $$
DROP PROCEDURE IF EXISTS  getMoviesByName $$

CREATE PROCEDURE getMoviesByName(IN vName VARCHAR(100))
	BEGIN
		DECLARE done INT DEFAULT 0;
        DECLARE año INT;
        DECLARE nombre VARCHAR(100);
        
        DECLARE cur1 CURSOR FOR (SELECT M.name, M.year FROM movies as M WHERE M.name LIKE @aux);
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        
        SET @aux= CONCAT('%',vName,'%');
        
        OPEN cur1;
			bucle:LOOP
				FETCH cur1 INTO nombre, año;
                
                IF done=1 THEN
					LEAVE bucle;
				END IF;
                
                SELECT nombre, año;
                
			END LOOP bucle;
        CLOSE cur1;
        
    END $$
DELIMITER ;

CALL getMoviesByName('Superman');