USE mymovies;

DELIMITER %%
DROP PROCEDURE IF EXISTS CalculateRevenue %%

CREATE PROCEDURE CalculateRevenue(INOUT var FLOAT)
BEGIN

	SELECT (stockUnits * price) INTO var FROM movies WHERE id = var;

END %%
DELIMITER ;


SET @aux = 46;
CALL mymovies.CalculateRevenue(@aux);
SELECT @aux;