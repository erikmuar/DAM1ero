-- 0) Activar DBMS_OUTPUT para ver resultados
SET SERVEROUTPUT ON;



-- 3) Definir persona_t con los nuevos atributos price y tax
CREATE OR REPLACE TYPE persona_t AS OBJECT(
  id        NUMBER,
  nombre    VARCHAR2(20),
  apellido  VARCHAR2(20),
  titulo    VARCHAR2(20),
  direccion direccion_t,
  price     NUMBER(10,2),    -- precio base
  tax       NUMBER(5,2),     -- tasa en %
  MEMBER FUNCTION precioFinal RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY persona_t AS

  MEMBER FUNCTION precioFinal RETURN NUMBER IS
  BEGIN
    RETURN price * (1 + tax/100);
  END precioFinal;

END;
/

-- 5) Bloque PL/SQL de prueba
BEGIN
  DECLARE
    dir  direccion_t := direccion_t(
             1,
             'Calle Falsa 123',
             NULL,
             NULL,
             'Madrid',
             'Madrid'
           );
    p    persona_t := persona_t(
             42,
             'Juan',
             'Pérez',
             'Sr.',
             dir,
             5.25,   -- price
             21      -- tax %
           );
    pf   NUMBER;
  BEGIN
    pf := p.precioFinal;  -- 5.25 * 1.21 = 6.3525

    DBMS_OUTPUT.PUT_LINE('Persona     : ' || p.nombre || ' ' || p.apellido);
    DBMS_OUTPUT.PUT_LINE('Título      : ' || p.titulo);
    DBMS_OUTPUT.PUT_LINE('Dirección   : ' 
      || p.direccion.linia1 || ', ' || p.direccion.ciudad || ' (' || p.direccion.provincia || ')');
    DBMS_OUTPUT.PUT_LINE('Precio base : ' || p.price);
    DBMS_OUTPUT.PUT_LINE('Tasa I.V.A. : ' || p.tax || '%');
    DBMS_OUTPUT.PUT_LINE('Precio final: ' || pf);
  END;
END;
/
