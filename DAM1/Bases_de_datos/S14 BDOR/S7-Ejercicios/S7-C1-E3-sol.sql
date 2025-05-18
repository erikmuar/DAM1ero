CREATE OR REPLACE TYPE proveedor_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(50),
  ciudad_sede VARCHAR2(50)
);

/

CREATE OR REPLACE TYPE categoria_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(50)
);

/

CREATE OR REPLACE TYPE producto_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(80),
  cat categoria_t,
  prov proveedor_t
);