USE mymovies;

DELIMITER $$
DROP PROCEDURE IF EXISTS getMoviesByYear $$

CREATE PROCEDURE getMoviesByYear(IN vPrimerAny INT, IN vSegonAny INT)
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE anyo INT;
    DECLARE nombre VARCHAR(100);
    
    DECLARE cur1 CURSOR FOR SELECT name, year 
							FROM movies 
							WHERE year between vPrimerAny AND vSegonAny 
							ORDER BY year, name;
                            
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
		OPEN CUR1;
        
			bucle:LOOP
				FETCH cur1 INTO nombre, anyo;
                
                IF done=1 THEN
					LEAVE bucle;
				END IF;
                
					SELECT nombre, anyo;
                
                END LOOP bucle;
			
            CLOSE cur1;
            
		END $$
        DELIMITER ;

  CALL getMoviesByYear(2010,2020);