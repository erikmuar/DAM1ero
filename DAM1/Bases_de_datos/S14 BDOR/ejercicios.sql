1 


 a) Teléfono:
    - Código país INT
    - Código de la región INT 
    - Número teléfono INT 

  b) Alumnos:
    - DNI VARCHAR2(9)
    - Nombre VARCHAR2(10) 
    - Apellidos VARCHAR2 (19)
    - Dirección Dirección 
    - fecha_nacimiento DATE 
    - Telefono VARCHAR2 (20)

    Dirección: 
    calle VARCHAR2
    codigo_postal NUMBER 
    población VARCHAR2
    provincia VARCHAR2


    c) 



3
     

CREATE OR REPLACE TYPE categoria_t AS OBJECT (
  id        NUMBER(2),
  nombre    VARCHAR2(50)
);

/

CREATE OR REPLACE TYPE proveedor_t AS OBJECT (
  id           NUMBER(2),
  nombre       VARCHAR2(50),
  ciudad_sede  VARCHAR2(50)
);

/

CREATE OR REPLACE TYPE producto_t AS OBJECT (
  id         NUMBER(5),
  nombre     VARCHAR2(80),
  ID_CAT     NUMBER(2),
  categoria  REF categoria_t,
  ID_PROV    NUMBER (3),
  proveedor  REF proveedor_t
);


4 


CREATE OR REPLACE TYPE noticia_t AS OBJECT (
  codigo       NUMBER,
  fecha_publicacion  DATE,
  dias_publicacion   NUMBER,
  texto        VARCHAR2(4000),



);
/
