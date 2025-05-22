CREATE OR REPLACE TYPE employee_t AS OBJECT(
  name VARCHAR2(20),
  manager REF employee_t
);

/

CREATE TABLE employees_tbl OF employee_t (name PRIMARY KEY);

/

INSERT INTO employees_tbl VALUES ('Empleado1',NULL);

/

INSERT INTO employees_tbl VALUES ('Empleado2',(SELECT REF(e) FROM employees_tbl e WHERE e.name='Empleado1'));
