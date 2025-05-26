CREATE DATABASE IF NOT EXISTS lsfit;
USE lsfit;


CREATE TABLE activitats_raw (
    id_usuari INT,
    data_activitat DATE,
    hora_inici TIME,
    durada_minuts INT,
    tipus_activitat VARCHAR(20),
    calories INT,
    dispositiu VARCHAR(15)
);
LOAD DATA INFILE './activitats_iso08601.csv'
INTO TABLE activitats_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_usuari, data_activitat, hora_inici, durada_minuts, tipus_activitat, calories, dispositiu);


