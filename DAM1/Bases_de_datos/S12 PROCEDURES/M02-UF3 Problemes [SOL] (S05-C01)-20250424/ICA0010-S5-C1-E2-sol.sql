CREATE DATABASE bkp_s5_ej2;
USE bkp_ejercicio2;
CREATE TABLE tabla1 LIKE BBDD_ORIGEN.tabla1;
INSERT INTO tabla1 SELECT * FROM BBDD_ORIGEN.tabla1;
….
CREATE TABLE tablaN LIKE BBDD_ORIGEN.tablaN;
INSERT INTO tablaN SELECT * FROM BBDD_ORIGEN.tablaN;
CREATE DATABASE bkp_s5_ej2;
USE bkp_ejercicio2;
CREATE TABLE tabla1 LIKE BBDD_ORIGEN.tabla1;
INSERT INTO tabla1 SELECT * FROM BBDD_ORIGEN.tabla1;
 
# Repentir tantas veces como haga falta segun las tablas que tengamos

CREATE TABLE tablaN LIKE BBDD_ORIGEN.tablaN;
INSERT INTO tablaN SELECT * FROM BBDD_ORIGEN.tablaN;
