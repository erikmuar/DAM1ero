# Tablas necesarias para poder validar la sintaxis de los selects del ejercicio 1, para ver como trabajar con ellas, visualitza el video S2-C1-V5
CREATE TABLE persona(
	num_ss VARCHAR(50),
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50),
	PRIMARY KEY (num_ss)
);

CREATE TABLE arbitro(
	num_ss_arbitro VARCHAR(50),
	num_colegiado VARCHAR(50),
	ano_inicio VARCHAR(50),
	profesion VARCHAR(50),
	PRIMARY KEY (num_ss_arbitro),
	FOREIGN KEY (num_ss_arbitro) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE equipo(
	nombre VARCHAR(50),
	ano_fundacion INT,
	presupuesto VARCHAR(50),
	presidente VARCHAR(50),
	entrenador VARCHAR(50),
	direccion VARCHAR(200),
	PRIMARY KEY (nombre)
);

CREATE TABLE jugador(
	num_ss_jugador VARCHAR(50),
	dorsal INT,
	ubicacion VARCHAR(50),
	ficha VARCHAR(50),
	nombre_equipo VARCHAR(50),
	PRIMARY KEY (num_ss_jugador),
	FOREIGN KEY (num_ss_jugador) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_equipo) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE partido(
	num_ss_arbitro VARCHAR(50),
	equipo_local VARCHAR(50),
	equipo_visitante VARCHAR(50),
	resultado VARCHAR(50),
	fecha DATE,
	PRIMARY KEY (num_ss_arbitro,equipo_local,equipo_visitante),
	FOREIGN KEY (num_ss_arbitro) REFERENCES arbitro(num_ss_arbitro) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_local) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_visitante) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);


# a)	Selecciona el nombre y apellido de los árbitros.
SELECT nombre, apellido1 FROM persona AS p, arbitro AS a
	WHERE p.num_ss = a.num_ss_arbitro;

# b)	Muestra el nombre de los equipos fundados antes del 1950 que tengan entrenador en la actualidad (suponiendo que si hay un valor válido en entrenador es que actualmente tienen entrenador)
SELECT nombre FROM equipo WHERE ano_fundacion < 1950 AND entrenador IS NOT NULL;

# c)	Selecciona el nombre y apellido de los jugadores con el dorsal 1 y su ubicación sea ‘Portero’ o con el dorsal 9 y su ubicación sea ‘Delantero’.
SELECT nombre, apellido1 FROM persona AS p, jugador AS j
	WHERE p.num_ss = j.num_ss_jugador AND (dorsal = 1 AND ubicacion = 'Portero') OR (dorsal = 9 AND ubicacion = 'Delantero');

# d)	Muestra el nombre, apellido y apellido2 en un único campo, separado por espacios de las personas que tengan una letra ‘c’ en su nombre. 
SELECT CONCAT(nombre,' ', apellido1,' ', apellido2) FROM persona AS p WHERE nombre LIKE '%c%';

# e)	Muestra los partidos jugados durante un mes de Febrero (de cualquier año).
SELECT * FROM partido WHERE MONTH(fecha) = 2;

# f)	Muestra los partidos jugados hoy.
SELECT * FROM partido WHERE fecha = CURRENT_DATE();

# g)	Muestra los árbitros que han iniciado entre el 2000 y el 2005 que sean ´Técnico Informático’ de profesión.
SELECT * FROM arbitro WHERE ano_inicio BETWEEN 2000 AND 2005 AND profesion = 'Técnico Informático';

# h)	Muestra el nombre de los equipos y su presupuesto, reduciendo este último en 100.000 euros.
SELECT nombre, presupuesto-100000 AS presupuesto_reducido FROM equipo

