CREATE DATABASE s5_ej3;
USE s5_ej3;
CREATE TABLE pais(
    id INTEGER AUTO_INCREMENT,
    nombre_pais VARCHAR(20),
    habitantes INTEGER,
    PRIMARY KEY (id)
);
INSERT INTO pais (nombre_pais, habitantes) VALUES 
("Irlanda",4500000),
("Suecia",1000000),
("Dinamarca",5600000);
SELECT nombre_pais, habitantes/(SELECT sum(habitantes) FROM pais)*100
  INTO OUTFILE 'RUTA_FICHERO/pais_habitantes.txt'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';\n'
  FROM pais;
