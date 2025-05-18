CREATE OR REPLACE TYPE direccion_t AS OBJECT(
  id NUMBER,
  linia1 VARCHAR2(20),
  linia2 VARCHAR2(20),
  linia3 VARCHAR2(20),
  ciudad VARCHAR2(20),
  provincia VARCHAR2(20)
);

/ 

CREATE OR REPLACE TYPE persona_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(20),
  apellido VARCHAR2(20),
  titulo VARCHAR2(20),
  direccion direccion_t
);
