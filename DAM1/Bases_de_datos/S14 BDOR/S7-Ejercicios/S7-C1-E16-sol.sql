CREATE OR REPLACE TYPE veterinari_t AS OBJECT(
  num_colegiat NUMBER,
  name VARCHAR2(20),
  direccion VARCHAR2(20)
);

/ 

CREATE OR REPLACE TYPE mascota_t AS OBJECT(
  idmas INTEGER,
  fecha_nacimiento DATE,
  raza VARCHAR2(20),
  vet REF veterinari_t
);

/

CREATE TABLE veterinari_tbl OF veterinari_t (num_colegiat PRIMARY KEY);

/

CREATE TABLE mascota_tbl OF mascota_t (idmas PRIMARY KEY);

/

INSERT INTO veterinari_tbl VALUES (veterinari_t(123,'Vet1','C/abc 12'));

/

INSERT INTO veterinari_tbl VALUES (veterinari_t(456,'Vet2','C/def 34'));

/

INSERT INTO mascota_tbl VALUES (1,'12-APR-2017','oso panda',(SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123));

/

INSERT INTO mascota_tbl VALUES (2,'22-APR-2016','perro',(SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123));

SELECT m.fecha_nacimiento, m.idmas FROM mascota_tbl m WHERE m.vet = (SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123);
