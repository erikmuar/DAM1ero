--1. Crear tabla
CREATE TABLE MD_activitat (
    id_activitat INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    descripcio VARCHAR(255)
);

--2. Edicción
--Eliminar la columna antigua tipus_activitat si existe
-- Afegim la columna si no existeix
ALTER TABLE activitats_net
ADD id_activitat INT;

-- Creem la relació entre activitats_net i MD_activitat
ALTER TABLE activitats_net
ADD CONSTRAINT fk_id_activitat
FOREIGN KEY (id_activitat)
REFERENCES MD_activitat(id_activitat);
