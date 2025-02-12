-- Ejercicio 1 

--a) 

INSERT INTO temporada VALUES(300, "2020-06-10", "2021-05-12"), (301, "2022-10-05", "2022-11-03");
INSERT INTO federacion VALUES("Carlos", "2024-01-19", "responsable1"), ("federacion2", "2021-10-05", "responsable2");
INSERT INTO Competicion VALUES ("hola","movistar"), ("la liga", "Cuatro");
INSERT INTO EQUIPO VALUES ("Barça", "Barcelona", "Presidente1", "Carlos"), ("Madrid", "Madrid", "Presidente2", "federacion2");
INSERT INTO Clasificacion VALUES (300,"hola", "Barça",1),(301,"la liga", "Madrid",2);

--b)

UPDATE temporada AS t, clasificacion AS c SET  posicion = 0
WHERE t.id_temporada= c.id_temporada AND YEAR(fecha_inicio) = 2020;

--c) 

UPDATE federacion AS f SET fecha_creacion = CURRENT_DATE() WHERE nombre_federacion = "Carlos"; 


--d) 

UPDATE Competicion AS c SET nombre_TV = NULL 
WHERE nombre_competicion = "Champions"; 

--e) 

DELETE FROM Clasificacion; 



--EJERCICIO 2


--a 

INSERT INTO Equipo(nombre,entrenador) VALUES ("equipo1, "entrenador2"), ("equipo2", "entrenador3");


--b)

UPDATE Jugador AS j SET dorsal = 1, ubicacion ="Portero"; 


--c)

UPDATE equipo AS e SET presidente = entrenador;

--d) 

UPDATE equipo SET presupuesto = presupuesto + 1000000
ORDER BY equipo ASC 
LIMIT 1; 

--e) 

DELETE 


