CREATE DATABASE lslog;
USE lslog;

CREATE TABLE IF NOT EXISTS log (
  id int NOT NULL AUTO_INCREMENT,
  texto varchar(250) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS persona (
  id int NOT NULL AUTO_INCREMENT,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  apellido2 varchar(50) NOT NULL,
  correo_electronico varchar(100) NOT NULL,
  dni varchar(10) NOT NULL,
  PRIMARY KEY (id)
);