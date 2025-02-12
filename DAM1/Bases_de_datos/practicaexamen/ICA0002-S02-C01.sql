
-- EJercicio 1 


--a) 

SELECT id_temporada 
FROM Temporada 
WHERE YEAR(fecha_inicio) BETWEEN 2010 AND 2015; 

-- b) 

SELECT id_temporada 
FROM temporada 
WHERE fecha_fin IS NULL; 

-- c)

SELECT nombre_competicion
FROM COMPETICION 
WHERE LENGTH(nombre_TV) > 5; 

-- d) 

SELECT nombre_competicion
FROM Competicion 
WHERE nombre_TV LIKE 'SKY%'; 

-- e) 

SELECT Ciudad 
FROM Equipo 
GROUP BY Ciudad; 

-- f) 

SELECT nombre_equipo, ciudad 
FROM Equipo AS e 
JOIN Clasificacion AS c ON c.nombre_equipo = e.nombre_equipo 
WHERE posicion = 1 AND e.nombre_competicion = 'La Liga' AND c.id_temporada = 3;


-- g) 

SELECT nombre_equipo 
FROm Equipo
WHERE ciudad = 'Madrid' OR ciudad = 'Barcelona' OR ciudad = 'Sevilla'; 

-- h) 

SELECT e.nombre_equipo 
FROM Equipo AS e
JOIN Clasificacion AS c ON c.nombre_equipo = e.nombre_equipo
WHERE nombre_competicion = 'Champions' AND id_temporada = 5 
ORDER BY c.posicion ASC
LIMIT 3;




-- Ejercicio 2 


-- Crear tablas 


DROP TABLE IF EXISTS persona;

CREATE TABLE persona(

num_ss VARCHAR(30),
nomobre VARCHAR(30),
apellido1 VARCHAR(10),
apellido2 VARCHAR(20),
PRIMARY KEY (num_ss)
);


DROP TABLE IF EXISTS Equipo;

CREATE TABLE Equipo(
ano_fundacion INT(4) UNSIGNED,
presupuesto DECIMAL(10,2) UNSIGNED,
presidente VARCHAR(20),
entrenador VARCHAR(20),
direccion VARCHAR(30),
PRIMARY KEY (nombre)
);


DROP TABLE IF EXISTS Jugador;

CREATE TABLE Jugador(
num_ss_jugador VARCHAR(30),
dorsal VARCHAR(3),
ubicacion VARCHAR(30),
ficha VARCHAR(20),
nombre_equipo VARCHAR(20),
PRIMARY KEY (num_ss_jugador),
FOREIGN KEY (num_ss_jugador) REFERENCES Persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (nombre_equipo) REFERENCES  Equipo(nombre) ON UPDATE CASCADE

);

DROP TABLE IF EXISTS Arbitro;

CREATE TABLE Arbitro(

num_ss_arbitro VARCHAR(30),
num_colegiado VARCHAR(10),
ano_inicio INT(4) UNSIGNED,
profesion VARCHAR(15),
PRIMARY KEY (num_ss_arbitro),
FOREIGN KEY (num_ss_arbitro) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS Partido;

CREATE TABLE Partido(
num_ss_arbitro VARCHAR(30),
equipo_local VARCHAR(20),
equipo_visitante VARCHAR(30),
resultado VARCHAR(10),
fecha DATE, 
PRIMARY KEY (num_ss_arbitro, equipo_local,equipo_visitante ),
FOREIGN KEY (num_ss_arbitro) REFERENCES Arbitro(num_ss_arbitro) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (equipo_local) REFERENCES Equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (equipo_visitante) REFERENCES Equipo(nombre)ON UPDATE CASCADE ON DELETE CASCADE
);


-- a) 

SELECT p.nombre, p.apellido1 
FROM Persona AS p 
JOIN Arbitro AS a ON a.num_ss_arbitro = p.num_ss;

-- b) 

SELECT e.nombre 
FROM Equipo AS e 
WHERE ano_fundacion < 1950 AND entrenados IS NOT NULL; 

-- c) 

SELECT p.nombre, p.apellido1 
FROM Persona AS p 
JOIN Jugador AS j ON j.num_ss_jugador = p.num_ss
WHERE (j.dorsal = 1 
AND j.ubicacion = 'Portero') OR (j.dorsal = 9 AND j.ubicacion = 'Delantero');


-- d) 

SELECT CONCAT(p.nombre, " ", p.apellido1, " ", p.apellido2)
FROM Persona AS p 
WHERE nombre LIKE '%c%'; 

-- e) 

SELECT * 
FROM Partido 
WHERE MONTH(fecha) = 2; 

-- f) 

SELECT *
FROM Partido AS p 
WHERE p.fecha = CURRENT_DATE(); 


-- g) 

SELECT p.nombre, p.apellido1 
FROM Persona AS p 
JOIN Arbitro AS a ON a.num_ss_arbitro = p.num_ss 
WHERE ano_inicio BETWEEN 2000 AND 2005 AND profesion = 'Tecnico informatico'; 

-- h) 

SELECT e.nombre, e.presupuesto -100000 AS presupuesto_reducido
FROM Equipo As e;


