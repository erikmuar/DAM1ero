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
  prov proveedor_t,
  price NUMBER,
  tax NUMBER,
  MEMBER FUNCTION calcPrecioFinal RETURN NUMBER
);

/

CREATE OR REPLACE TYPE BODY producto_t AS
  MEMBER FUNCTION calcPrecioFinal RETURN NUMBER IS
  BEGIN
    RETURN self.price+(self.price*self.tax/100);
  END;
END;

/

set serveroutput on;
DECLARE
  p producto_t;
BEGIN
  p:=producto_t(5,'test',categoria_t(1,'c'),proveedor_t(1,'p','bcn'),5,21);
  DBMS_OUTPUT.PUT_LINE('Precio final es: ' || p.calcPrecioFinal());
END;