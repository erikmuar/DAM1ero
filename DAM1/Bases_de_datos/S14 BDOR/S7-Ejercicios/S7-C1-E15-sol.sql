-- DROP de la tabla solo si da error debido a algun ejercio anterior:
DROP TABLE employees_tbl;

/

CREATE OR REPLACE TYPE employee_t AS OBJECT(
  name VARCHAR2(20),
  manager REF employee_t
);

/
CREATE OR REPLACE TYPE departament_t AS OBJECT(
  name VARCHAR2(20),
  manager REF employee_t
);

/

CREATE TABLE employees_tbl OF employee_t (name PRIMARY KEY);

/

INSERT INTO employees_tbl VALUES ('Empleado1',NULL);
/

INSERT INTO employees_tbl VALUES ('Empleado2',(SELECT REF(e) FROM employees_tbl e WHERE e.name='Empleado1'));
/

CREATE TABLE departaments_tbl OF departament_t (name PRIMARY KEY);
/

INSERT INTO departaments_tbl VALUES ('Departamento1',(SELECT REF(e) FROM employees_tbl e WHERE e.name='Empleado2'));
/

INSERT INTO departaments_tbl VALUES ('Departamento2',(SELECT REF(e) FROM employees_tbl e WHERE e.name='Empleado1'));