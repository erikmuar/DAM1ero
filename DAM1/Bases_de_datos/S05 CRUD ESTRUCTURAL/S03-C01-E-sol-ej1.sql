# Base de datos
CREATE DATABASE s3_c1_ej1 DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_bin';
USE s3_c1_ej1;

# Tablas
CREATE TABLE temporada(
	id_temporada INT AUTO_INCREMENT,
	fecha_inicio DATETIME,
	fecha_fin DATETIME,
	PRIMARY KEY (id_temporada)
);

CREATE TABLE competicion(
	nombre_competicion VARCHAR(50),
	nombre_TV VARCHAR(50),
	PRIMARY KEY (nombre_competicion)
);

CREATE TABLE federacion(
	nombre_federacion VARCHAR(50),
	fecha_creacion DATETIME,
	responsable VARCHAR(50),
	PRIMARY KEY (nombre_federacion)
);

CREATE TABLE equipo(
	nombre_equipo VARCHAR(50) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	presidente VARCHAR(50) NOT NULL,
	nombre_federacion VARCHAR(50) NOT NULL,
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


