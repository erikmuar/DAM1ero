/*Crea un tipo que se llame Alumno_T que permita almacenar como atributos el DNI del alumno, la nota de la primera evaluación, de la segunda evaluación y de la tercera. Una vez definido el tipo asóciale dos funciones:
• CalcMedia, que tomará los valores de las tres notas, los promediará y retornará el resultado sin decimales.
• CalcMediaPond, que recibirá como parámetros el porcentaje que vale cada evaluación sobre la nota final. Por ejemplo: 25, 50, 25. Esta función debe retornar la nota media teniendo en cuenta esta ponderación.
Crea un bloque PL/SQL en el que se declare y se cree un objeto del tipo ALUMNO_T y calcula la nota media y la nota ponderada teniendo en cuenta que el peso de las evaluaciones es 25%, 50%, 25%*/

CREATE OR REPLACE TYPE Alumno_T AS OBJECT (
  dni       VARCHAR2(9),
  nota1     NUMBER(3,2),
  nota2     NUMBER(3,2),
  nota3     NUMBER(3,2),
  MEMBER FUNCTION CalcMedia RETURN NUMBER,
  MEMBER FUNCTION CalcMediaPond(
    p1 IN NUMBER, 
    p2 IN NUMBER, 
    p3 IN NUMBER
  ) RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY Alumno_T AS

  MEMBER FUNCTION CalcMedia RETURN NUMBER IS
  BEGIN
    RETURN ROUND( (nota1 + nota2 + nota3) / 3, 0 );
  END CalcMedia;

  MEMBER FUNCTION CalcMediaPond(
    p1 IN NUMBER, 
    p2 IN NUMBER, 
    p3 IN NUMBER
  ) RETURN NUMBER IS
  BEGIN
    RETURN (nota1 * p1 + nota2 * p2 + nota3 * p3) / 100;
  END CalcMediaPond;

END;

BEGIN
  DECLARE
    al    Alumno_T := Alumno_T('87654321B', 5.4, 7.8, 9.2);
    m     NUMBER;
    mpond NUMBER;
  BEGIN
    m     := al.CalcMedia;              
    mpond := al.CalcMediaPond(25,50,25);

    DBMS_OUTPUT.PUT_LINE('DNI       : ' || al.dni);
    DBMS_OUTPUT.PUT_LINE('Media     : ' || m);
    DBMS_OUTPUT.PUT_LINE('Ponderada : ' || mpond);
  END;
END;
/