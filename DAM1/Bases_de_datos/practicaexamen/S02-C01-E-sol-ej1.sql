# Tablas necesarias para poder validar la sintaxis de los selects del ejercicio 1, para ver como trabajar con ellas, visualitza el video S2-C1-V5
CREATE TABLE temporada(
	id_temporada INT AUTO_INCREMENT,
	fecha_inicio DATE,
	fecha_fin DATE,
	PRIMARY KEY (id_temporada)
);

CREATE TABLE competicion(
	nombre_competicion VARCHAR(50),
	nombre_TV VARCHAR(50),
	PRIMARY KEY (nombre_competicion)
);

CREATE TABLE federacion(
	nombre_federacion VARCHAR(50),
	fecha_creacion DATE,
	responsable VARCHAR(50),
	PRIMARY KEY (nombre_federacion)
);

CREATE TABLE equipo(
	nombre_equipo VARCHAR(50),
	ciudad VARCHAR(50),
	presidente VARCHAR(50),
	nombre_federacion VARCHAR(50),
	PRIMARY KEY (nombre_equipo),
	FOREIGN KEY (nombre_federacion) REFERENCES federacion(nombre_federacion) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE clasificacion(
	id_temporada INT,
	nombre_competicion VARCHAR(50),
	nombre_equipo VARCHAR(50),
	posicion INT,
	PRIMARY KEY (id_temporada, nombre_competicion, nombre_equipo),
	FOREIGN KEY (id_temporada) REFERENCES temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_competicion) REFERENCES competicion(nombre_competicion) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_equipo) REFERENCES equipo(nombre_equipo) ON UPDATE CASCADE ON DELETE CASCADE
);


# a)	Selecciona el identificador de las temporadas que han empezado entre el 2010 y el 2015.
SELECT id_temporada FROM temporada WHERE YEAR(fecha_inicio) BETWEEN 2010 AND 2015; 

# b)	Selecciona las temporadas que no han terminado (suponiendo que una temporada que no ha terminado tendrá el valor de ese atributo a NULL).
SELECT * FROM temporada WHERE fecha_fin IS NULL;

# c)	Selecciona el nombre de las competiciones con un nombre de televisión de más de 5 letras.
SELECT nombre_competicion FROM competicion WHERE LENGTH(nombre_TV) > 5;

# d)	Selecciona el nombre de las competiciones con un nombre de televisión que empiece con el texto ‘SKY’.
SELECT nombre_competicion FROM competicion WHERE nombre_TV LIKE 'SKY%';

# e)	Selecciona las ciudades donde tenemos equipos, evitando tener resultados repetidos.
SELECT DISTINCT(ciudad) FROM equipo;

# f)	Selecciona el nombre del equipo y su ciudad que ha quedado en 1º lugar, en la competición ‘La Liga’ en la temporada con identificador 3.
SELECT e.nombre_equipo, e.ciudad FROM equipo AS e, clasificacion AS c 
	WHERE e.nombre_equipo = c.nombre_equipo 
		AND posicion = 1 AND nombre_competicion = 'La Liga' AND id_temporada = 3;

# g)	Selecciona el nombre de los equipos de Madrid, Barcelona o Sevilla
SELECT nombre_equipo FROM equipo WHERE ciudad = 'Madrid' OR ciudad = 'Barcelona' OR ciudad = 'Sevilla';

# h)	Muestra los equipos que han quedado entre los tres primeros clasificados en la competición ‘Champions’ en la temporada con id 5.
SELECT e.* FROM equipo AS e, clasificacion AS c 
	WHERE e.nombre_equipo = c.nombre_equipo 
		AND posicion <= 3 AND nombre_competicion = 'Champions' AND id_temporada = 5;
