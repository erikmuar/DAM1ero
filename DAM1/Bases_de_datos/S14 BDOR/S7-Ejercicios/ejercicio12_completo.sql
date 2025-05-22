
-- person_t
CREATE OR REPLACE TYPE person_t AS OBJECT (
    idno NUMBER,
    name VARCHAR2(30),
    surname VARCHAR2(30),
    birth DATE,
    phone VARCHAR2(15),

    NOT FINAL MEMBER FUNCTION get_datos RETURN VARCHAR2,
    MAP MEMBER FUNCTION get_fecha RETURN DATE
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY person_t AS
    MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
        RETURN name || ' ' || surname || ' (' || phone || ')';
    END;

    MAP MEMBER FUNCTION get_fecha RETURN DATE IS
    BEGIN
        RETURN birth;
    END;
END;
/

-- student_t
CREATE OR REPLACE TYPE student_t UNDER person_t (
    college VARCHAR2(30),
    averageScore NUMBER,

    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY student_t AS
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
        RETURN (SELF AS person_t).get_datos() || ', ' || college || ', Nota: ' || averageScore;
    END;
END;
/

-- student_parcial_t
CREATE OR REPLACE TYPE student_parcial_t UNDER student_t (
    numHours NUMBER,

    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
);
/ 

CREATE OR REPLACE TYPE BODY student_parcial_t AS
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
        RETURN (SELF AS student_t).get_datos() || ', Horas: ' || numHours;
    END;
END;
/

-- a, b
SET SERVEROUTPUT ON;
BEGIN
    DECLARE
        estudiante student_t := student_t(
            1, 'Juan', 'Pérez', TO_DATE('1995-02-15', 'YYYY-MM-DD'), '5551234', 'La Salle', 8.5
        );

        estudiante_parcial student_parcial_t := student_parcial_t(
            2, 'Ana', 'García', TO_DATE('1993-05-20', 'YYYY-MM-DD'), '5555678', 'La Salle', 9.0, 20
        );
    BEGIN
        -- Mostrar datos
        DBMS_OUTPUT.PUT_LINE('Estudiante: ' || estudiante.get_datos());
        DBMS_OUTPUT.PUT_LINE('Estudiante parcial: ' || estudiante_parcial.get_datos());

        -- Comparar edades
        IF estudiante.get_fecha() < estudiante_parcial.get_fecha() THEN
            DBMS_OUTPUT.PUT_LINE('El estudiante es mayor');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El estudiante parcial es mayor');
        END IF;
    END;
END;
/

DROP TABLE personas_tab;
CREATE TABLE personas_tab OF person_t (
    PRIMARY KEY (idno)
)
OBJECT IDENTIFIER IS PRIMARY KEY;

-- Insertar registros de distintos tipos
INSERT INTO personas_tab VALUES (
    student_t(1, 'Juan', 'Pérez', TO_DATE('1995-02-15', 'YYYY-MM-DD'), '5551234', 'La Salle', 8.5)
);
INSERT INTO personas_tab VALUES (
    student_parcial_t(2, 'Ana', 'García', TO_DATE('1993-05-20', 'YYYY-MM-DD'), '5555678', 'La Salle', 9.0, 20)
);
INSERT INTO personas_tab VALUES (
    student_t(3, 'Carlos', 'Sánchez', TO_DATE('1994-03-10', 'YYYY-MM-DD'), '5559012', 'UPC', 7.0)
);
INSERT INTO personas_tab VALUES (
    student_parcial_t(4, 'Lucía', 'Martínez', TO_DATE('1996-07-25', 'YYYY-MM-DD'), '5553456', 'UB', 8.8, 15)
);
INSERT INTO personas_tab VALUES (
    person_t(5, 'Pedro', 'López', TO_DATE('1980-01-01', 'YYYY-MM-DD'), '5550000')
);

COMMIT;

-- c
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Estudiantes (student_t y subtipos) ordenados por fecha de nacimiento ---');
    FOR r IN (
        SELECT VALUE(p) p_obj
        FROM personas_tab p
        WHERE TREAT(VALUE(p) AS student_t) IS NOT NULL
        ORDER BY p.get_fecha()
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(r.p_obj.get_datos());
    END LOOP;
END;
/

-- d
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Estudiantes a tiempo parcial (student_parcial_t) ordenados por fecha de nacimiento ---');
    FOR r IN (
        SELECT VALUE(p) p_obj
        FROM personas_tab p
        WHERE TREAT(VALUE(p) AS student_parcial_t) IS NOT NULL
        ORDER BY p.get_fecha()
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(r.p_obj.get_datos());
    END LOOP;
END;
/
