/*Crea un tipo de objeto rectangle_t que tenga como atributos longitud, anchura y área. Define 
un  constructor  que  tenga  únicamente  dos  parámetros  (longitud,  anchura)  y  que  calcule  el 
área multiplicando los parámetros recibidos de longitud y altura. Define en un bloque PL/SQL 
dos objetos rectangle_t, usando el constructor por defecto y el constructor creado. Muestra 
por pantalla, el valor del área de cada uno de los rectángulos creados. */

CREATE OR REPLACE TYPE rectangle_t AS OBJECT (
  longitud NUMBER,
  anchura  NUMBER,
  area     NUMBER,
  CONSTRUCTOR FUNCTION rectangle_t(
    p_longitud IN NUMBER, 
    p_anchura IN NUMBER
  ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY rectangle_t AS

  CONSTRUCTOR FUNCTION rectangle_t(
    p_longitud IN NUMBER, 
    p_anchura IN NUMBER
  ) RETURN SELF AS RESULT IS
  BEGIN
    self.longitud := p_longitud;
    self.anchura  := p_anchura;
    self.area     := p_longitud * p_anchura;
    RETURN;
  END rectangle_t;

END;

/

DECLARE
  r1 rectangle_t := rectangle_t(5, 10);
  r2 rectangle_t := rectangle_t(3, 4);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Rectángulo 1: ' || r1.area);
    DBMS_OUTPUT.PUT_LINE('Rectángulo 2: ' || r2.area);
  END;

  /