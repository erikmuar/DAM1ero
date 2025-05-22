/*Crea un tipo de objeto person_t que permita la definición de subtipos y pueda almacenar: 
• Idno: entero 
• name caracter (30) 
• surname caracter (30) 
• Birth: fecha 
• phone caracter 
Y los siguientes métodos. 
• get_datos: método que devuelve una string con el name, surname y phone 
• get_fecha: método que permita la ordenación de personas por su birth (MAP). 
Crea un subtipo de person_t denominado student_t que permita la definición de subtipos y 
pueda almacenar: 
• college: carácter (30) 
• averageScore: integer 
Debe sobrescribir el método get_datos mostrando name, surname, phone, college y 
averageScore  
Crea un subtipo de student_t denominado student_parcial_t que pueda almacenar: 
• numHours: integer 
Debe sobrescribir el método get_datos mostrando name, surname, phone, college y 
averageScore y numHours 
En un bloque PL/SQL, */


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

/*a) Crea un objeto tipo student_t y otro student_parcial_t. Usa el método get_datos para 
mostrar en pantalla los datos de cada uno de ellos. Muestra por pantalla también cuál 
de ellos es más joven. */

SET SERVEROUTPUT ON;
BEGIN
    DECLARE
        estudiante student_t := student_t(
            1, 'Juan', 'Cuesta', TO_DATE('1998-06-22', 'YYYY-MM-DD'), '5551234', 'La Salle', 8.5
        );

        estudiante_parcial student_parcial_t := student_parcial_t(
            2, 'Ana', 'García', TO_DATE('1996-09-11', 'YYYY-MM-DD'), '5555678', 'La Salle', 9.0, 20
        );
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Estudiante: ' || estudiante.get_datos());
        DBMS_OUTPUT.PUT_LINE('Estudiante parcial: ' || estudiante_parcial.get_datos());

        IF estudiante.get_fecha() < estudiante_parcial.get_fecha() THEN
            DBMS_OUTPUT.PUT_LINE('Este estudiante es mayor');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El estudiante parcial es mayor');
        END IF;
    END;
END;
/

/*
b) Crea una tabla de objetos del tipo person_t (PK idno) con los siguientes registros  
 */ 
 DROP TABLE personas_tab;
CREATE TABLE personas_tab OF person_t (
    PRIMARY KEY (idno)
)
OBJECT IDENTIFIER IS PRIMARY KEY;

INSERT INTO personas_tabla VALUES (
    student_t(
      10,
      'María',
      'Rodríguez',
      TO_DATE('1998-09-12', 'YYYY-MM-DD'),
      '5557890',
      'UAH',
      8.1
    )
);

INSERT INTO personas_tabla VALUES (
    student_parcial_t(
      11,
      'David',
      'Gómez',
      TO_DATE('1997-11-05', 'YYYY-MM-DD'),
      '5552345',
      'UAM',
      7.5,
      18
    )
);

INSERT INTO personas_tabla VALUES (
    student_t(
      12,
      'Laura',
      'Fernández',
      TO_DATE('1999-02-20', 'YYYY-MM-DD'),
      '5556789',
      'UCM',
      9.3
    )
);

INSERT INTO personas_tabla VALUES (
    student_parcial_t(
      13,
      'Jorge',
      'Muñoz',
      TO_DATE('1996-08-30', 'YYYY-MM-DD'),
      '5554321',
      'UPM',
      8.0,
      22
    )
);

INSERT INTO personas_tabla VALUES (
    person_t(
      14,
      'Isabel',
      'Vega',
      TO_DATE('1985-12-15', 'YYYY-MM-DD'),
      '5559876',
      'UB',
      7.7,
      26
    )
);

COMMIT;
 
 
/*c) Muestra  por  pantalla  los  datos  (get_datos)  de  los  estudiantes  (sólo  estudiantes) 
ordenados por fecha de nacimiento (birth) */

BEGIN
    DBMS_OUTPUT.PUT_LINE(' Estudiantes (student_t y subtipos) ordenados por fecha de nacimiento ');
    FOR estudiante IN (
        SELECT VALUE(p) AS persona
        FROM personas_tabla p
        WHERE p IS OF (student_t, student_parcial_t)
        ORDER BY p.get_fecha()
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(estudiante.persona.get_datos());
    END LOOP;
END;


/*d) Muestra  por  pantalla  los  datos  (get_datos)  de  los  estudiantes  a  tiempo  parcial 
ordenados por fecha de nacimiento (birth) */
BEGIN
    DBMS_OUTPUT.PUT_LINE(' Estudiantes a tiempo parcial (student_parcial_t) ordenados por fecha de nacimiento ');
    FOR estudiante_parcial IN (
        SELECT VALUE(p) AS persona
        FROM personas_tabla p
        WHERE p IS OF student_parcial_t
        ORDER BY p.get_fecha()
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(estudiante_parcial.persona.get_datos());
    END LOOP;
END;