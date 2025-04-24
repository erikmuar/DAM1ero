CREATE DATABASE s5_ej4;
USE s5_ej4;

CREATE TABLE cuenta_bancaria(
    numero_cuenta INTEGER,
    saldo DOUBLE,
    PRIMARY KEY (numero_cuenta)
);

INSERT INTO cuenta_bancaria(numero_cuenta, saldo) VALUES 
(1,-100),
(2,2000),
(3,0);

SELECT *
  INTO OUTFILE 'RUTA_FICHERO/numeros_rojos.txt'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';\n'
  FROM cuenta_bancaria
  WHERE saldo < 0;

