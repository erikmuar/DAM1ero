CREATE OR REPLACE TYPE noticia_t AS OBJECT(
  codigo NUMBER,
  fecha DATE,
  num_dias_publicado NUMBER,
  texto VARCHAR2(500),
  MEMBER FUNCTION deberia_publicada RETURN BOOLEAN,
  MEMBER PROCEDURE displayDetails
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
  MEMBER FUNCTION deberia_publicada RETURN BOOLEAN IS
  BEGIN
    IF(fecha-SYSDATE > num_dias_publicado) THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  MEMBER PROCEDURE displayDetails IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(codigo)||' '||fecha||' '||TO_CHAR(num_dias_publicado)||' '||texto);
  END;
END;

/

set serveroutput on;
DECLARE
  noticia noticia_t;
BEGIN
  noticia := noticia_t(1,SYSDATE,2,'lorem ipsum ...');
  IF noticia.deberia_publicada() THEN
    DBMS_OUTPUT.PUT_LINE('La noticia deberia estar publicada');
  ELSE
    DBMS_OUTPUT.PUT_LINE('La noticia no deberia estar publicada');
  END IF;
END;
