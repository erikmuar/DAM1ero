/*

Crea una tabla de objetos noticia_t que se llame noticias_obj. La clave primaria debe 
ser  el  código.  Inserta  3  valores  y  comprueba  que  los  valores  se  han  insertado 
correctamente.  Realiza  un  SELECT  de  la  tabla  noticias_obj  para  verificar  que  las 
noticias se han insertado correctamente. 
b) Crea una tabla que contenga un objeto noticia_t y un varchar2 que se llame sección. 
La clave primaria de la tabla debe ser el atributo código del objeto noticia. Inserta 3 
valores y comprueba que se han insertado correctamente. 

*/
CREATE OR REPLACE TYPE noticia_t AS OBJECT(
  codigo NUMBER,
  fecha DATE,
  num_dias_publicado NUMBER,
  texto VARCHAR2(500),

);

CREATE TABLE noticias_obj OF noticia_t (
  CONSTRAINT pk_noticias_obj PRIMARY KEY (codigo)
);

INSERT INTO noticias_obj VALUES (
  noticia_t(1, TO_DATE('2025-12-25', 'YYYY-MM-DD'), 5, 'Buenos dias por la mañana.')
);
INSERT INTO noticias_obj VALUES (
  noticia_t(2, TO_DATE('2025-12-01', 'YYYY-MM-DD'), 8, 'Hace sol hoy.')
);
INSERT INTO noticias_obj VALUES (
  noticia_t(3, TO_DATE('2025-12-17', 'YYYY-MM-DD'), 7, 'Galileo Galilei se fumaba cada uno.')
);
COMMIT;

SELECT * FROM noticias_obj;

/* b) Crea una tabla que contenga un objeto noticia_t y un varchar2 que se llame sección. 
La clave primaria de la tabla debe ser el atributo código del objeto noticia. Inserta 3 
valores y comprueba que se han insertado correctamente.*/


CREATE TABLE noticias_seccion (
  noticia noticia_t,
  seccion VARCHAR2(30),
  CONSTRAINT pk_noticias_mixtas PRIMARY KEY (noticia.codigo)
);

INSERT INTO noticias_seccion VALUES (
  noticia_t('Martes','Miercoles','Jueves'), 'Semana'
);
INSERT INTO noticias_seccion VALUES (
  noticia_t('Hola','Buenos','dias'), 'Santa'
);
INSERT INTO noticias_seccion VALUES (
  noticia_t('Viernes','Sábado','Domingo'), 'Rojo'
);
COMMIT;


SELECT 
  noticia.codigo     AS código,
  noticia.fecha_publicacion AS publicado_el,
  noticia.dias_publicada    AS días_activa,
  noticia.texto       AS texto,
  seccion
FROM noticias_seccion;
