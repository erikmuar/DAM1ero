CREATE OR REPLACE TYPE Concierto AS OBJECT (
    id_concierto NUMBER,
    nombre_concierto VARCHAR2(30),
    nombre_grupo VARCHAR2(20),
    direccion Direccion_T,
    fecha_y_hora DATE,
    promotor Promotor_T,
    
    MEMBER PROCEDURE mostrarinformacion,
    MEMBER FUNCTION diasRestantes RETURN NUMBER
);
/

CREATE OR REPLACE TYPE Promotor_T AS OBJECT (
    nombre VARCHAR2(20),
    telefono VARCHAR2(12),
    web VARCHAR2(30)
);
/


CREATE OR REPLACE TYPE Direccion_T AS OBJECT (
    numero NUMBER,
    calle VARCHAR2(30),
    poblacion VARCHAR2(20)
);
/





CREATE OR REPLACE TYPE BODY Concierto AS
    MEMBER PROCEDURE mostrarinformacion IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || id_concierto || ', Nombre: ' || nombre_concierto || 
            ', Grupo o Artista: ' || nombre_grupo || ', Fecha y hora: ' || TO_CHAR(fecha_y_hora, 'DD/MM/YYYY HH24:MI')
        );
    END;
    
    MEMBER FUNCTION diasRestantes RETURN NUMBER IS
    BEGIN
        RETURN TRUNC(fecha_y_hora - SYSDATE);
    END;
END;
/

DECLARE
    v_concierto Concierto := Concierto(
        1, 'Primavera Sound', 'Els Catarres',
        Direccion_T(123,'Calle Falsa', 'Marruecos'),
        TO_DATE('25/12/2026 20:00', 'DD/MM/YYYY HH24:MI'),
        Promotor_T('Jaime Jaimeson', '987321654', 'www.jaimejaimeson.com')
    );
BEGIN
    v_concierto.mostrarinformacion();
    DBMS_OUTPUT.PUT_LINE('Días restantes de concierto: ' || v_concierto.diasRestantes());
END;
/