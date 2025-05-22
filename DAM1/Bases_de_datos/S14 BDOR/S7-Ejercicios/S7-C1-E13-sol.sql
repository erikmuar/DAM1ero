CREATE OR REPLACE TYPE immueble_t AS OBJECT (
  id INTEGER,
  superficie NUMBER,
  precio NUMBER,
  ciudad VARCHAR2(20),
  FINAL MAP MEMBER FUNCTION ordernarPrecio RETURN NUMBER,
  MEMBER FUNCTION show RETURN VARCHAR2
) NOT FINAL;

/

CREATE OR REPLACE TYPE BODY immueble_t AS
  FINAL MAP MEMBER FUNCTION ordernarPrecio RETURN NUMBER IS
  BEGIN
      RETURN SELF.precio;
  END;
  MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'id: '||SELF.id||'
      superficie: '||SELF.superficie||'
      precio : '||SELF.precio||'
      ciudad : '||SELF.ciudad;
  END;
END;

/

CREATE OR REPLACE TYPE oficina_t UNDER immueble_t (
  num_plantas NUMBER,
  tiene_ascensor INTEGER,
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2,
  MEMBER FUNCTION hay_ascensor RETURN BOOLEAN
);

/

CREATE OR REPLACE TYPE BODY oficina_t AS
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'Oficina:
      -id: '||SELF.id||'
      -superficie: '||SELF.superficie||'
      -precio: '||SELF.precio||'
      -ciudad: '||SELF.ciudad||'
      -num_plantas: '||SELF.num_plantas||'
      -tiene_ascensor: '||SELF.tiene_ascensor;
  END;
  MEMBER FUNCTION hay_ascensor RETURN BOOLEAN IS
  BEGIN
    IF SELF.tiene_ascensor = 1 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;
END;

/

CREATE OR REPLACE TYPE vivienda_t UNDER immueble_t (
  num_habitaciones NUMBER,
  num_baños NUMBER,
  tiene_terraza INTEGER,
  tiene_piscina INTEGER,
  tiene_garage INTEGER,
  tiene_ascensor INTEGER,
  MEMBER FUNCTION getTipo RETURN VARCHAR2,
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY vivienda_t AS
  MEMBER FUNCTION getTipo RETURN VARCHAR2 IS
  BEGIN
    IF SELF.num_habitaciones = 1 THEN
      RETURN 'Estudio';
    ELSIF SELF.num_habitaciones = 2 THEN
      RETURN 'Apartamento';
    ELSIF SELF.num_habitaciones > 2 THEN
      RETURN 'Piso';
    END IF;
  END;
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'Vivienda:-id: '||SELF.id||'-superficie: '||SELF.superficie||'-precio: '||SELF.precio||'-ciudad: '||SELF.ciudad||'-num_habitaciones: '||SELF.num_habitaciones||'-num_baños: '||SELF.num_baños||',-tiene_terraza: '||SELF.tiene_terraza||',-tiene_piscina: '||SELF.tiene_piscina||',-tiene_garage: '||SELF.tiene_garage||',-tiene_ascensor: '||SELF.tiene_ascensor;
  END;
END;

/

CREATE TABLE immuebles_table (
  immueble immueble_t,
  fecha_alta DATE,
  CONSTRAINT pk_immuebles_table PRIMARY KEY(immueble.id)
);
/
INSERT INTO immuebles_table VALUES (oficina_t(1,50,33.2,'Barcelona',5,1),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (oficina_t(2,50,33.2,'Barcelona',2,0),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(3,50,33.2,'Barcelona',1,1,0,0,0,0),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(4,50,33.2,'Barcelona',2,1,0,1,1,1),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(5,50,33.2,'Barcelona',3,1,1,0,1,1),'22-FEB-2020');

/

SELECT i.immueble.show() FROM immuebles_table i ORDER BY i.immueble.precio;

/

SELECT i.immueble.show() FROM immuebles_table i
WHERE extract(month from i.fecha_alta)-1 = extract(month from SYSDATE)
  AND extract(year from i.fecha_alta) = extract(year from SYSDATE);

/

SELECT i.immueble.show() FROM immuebles_table i WHERE i.immueble.precio BETWEEN 10 AND 50;

/

-- La función VALUE no funciona en ORACLE Live: 
SELECT i.immueble.show() FROM immuebles_table i WHERE VALUE(i.immueble) IS OF TYPE (vivienda_t);
/
-- Podemos hacelo sin ella:
SELECT i.immueble.show() FROM immuebles_table i WHERE (i.immueble) IS OF TYPE (vivienda_t);