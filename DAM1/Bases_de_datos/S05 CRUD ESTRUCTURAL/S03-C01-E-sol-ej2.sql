# Base de datos
CREATE DATABASE IF NOT EXISTS s3_c1_ej2; 
USE s3_c1_ej2;

# Tablas
CREATE TABLE IF NOT EXISTS persona(
	num_ss VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	PRIMARY KEY (num_ss)
) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci';

CREATE TABLE IF NOT EXISTS arbitro(
	num_ss_arbitro VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	num_colegiado VARCHAR(50),
	ano_inicio INT,
	profesion VARCHAR(50),
	PRIMARY KEY (num_ss_arbitro),
	FOREIGN KEY (num_ss_arbitro) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS equipo(
	nombre VARCHAR(50),
	ano_fundacion INT,
	presupuesto VARCHAR(50),
	presidente VARCHAR(50),
	entrenador VARCHAR(50),
	direccion VARCHAR(200),
	PRIMARY KEY (nombre)
);

CREATE TABLE IF NOT EXISTS jugador(
	num_ss_jugador VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	dorsal INT,
	ubicacion VARCHAR(50),
	ficha DECIMAL,
	nombre_equipo VARCHAR(50),
	PRIMARY KEY (num_ss_jugador),
	FOREIGN KEY (num_ss_jugador) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_equipo) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS partido(
	num_ss_arbitro VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	equipo_local VARCHAR(50),
	equipo_visitante VARCHAR(50),
	resultado VARCHAR(50),
	fecha DATE,
	PRIMARY KEY (num_ss_arbitro,equipo_local,equipo_visitante),
	FOREIGN KEY (num_ss_arbitro) REFERENCES arbitro(num_ss_arbitro) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_local) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_visitante) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);


