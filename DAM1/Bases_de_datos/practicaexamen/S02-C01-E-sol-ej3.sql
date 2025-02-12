# Tablas necesarias para poder validar la sintaxis de los selects del ejercicio 1, para ver como trabajar con ellas, visualitza el video S2-C1-V5
CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT,
	DNI VARCHAR(9),
	mail VARCHAR(50),
	direccion VARCHAR(200),
	num_targeta INT,
	PRIMARY KEY (id_usuario)
);

CREATE TABLE subscritor(
	id_subscritor INT,
	es_asociado BOOLEAN,
	PRIMARY KEY (id_subscritor),
	FOREIGN KEY (id_subscritor) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cliente(
	id_cliente INT,
	gusta_electronico BOOLEAN,
	PRIMARY KEY (id_cliente),
	FOREIGN KEY (id_cliente) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE coleccion(
	nombre_coleccion VARCHAR(50),
	ano_inicio INT,
	ano_fin INT,
	PRIMARY KEY (nombre_coleccion)
);

CREATE TABLE entrega(
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	num_paginas INT,
	PRIMARY KEY (fecha_entrega, nombre_coleccion),
	FOREIGN KEY (nombre_coleccion) REFERENCES coleccion(nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE regalo(
	id_regalo INT,
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	peso INT,
	PRIMARY KEY (id_regalo, fecha_entrega, nombre_coleccion),
	FOREIGN KEY (fecha_entrega, nombre_coleccion) REFERENCES entrega(fecha_entrega, nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE subscritor_coleccion(
	id_subscritor INT,
	nombre_coleccion VARCHAR(50),
	num_inicio INT,
	PRIMARY KEY (id_subscritor, nombre_coleccion),
	FOREIGN KEY (id_subscritor) REFERENCES subscritor(id_subscritor) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_coleccion) REFERENCES coleccion(nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cliente_entrega(
	id_cliente INT,
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	PRIMARY KEY (id_cliente, fecha_entrega, nombre_coleccion),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (fecha_entrega, nombre_coleccion) REFERENCES entrega(fecha_entrega,nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE
);


# a)	Selecciona los usuarios, que son subscritores asociados.
SELECT u.* FROM usuario AS u, subscritor AS s
	WHERE u.id_usuario = s.id_subscritor AND es_asociado IS TRUE;

# b)	Selecciona los usuarios, que son clientes a los que no les gusta el formato electrónico.
SELECT u.* FROM usuario AS u, cliente AS c
	WHERE u.id_usuario = c.id_cliente AND gusta_electronico IS FALSE;

# c)	Selecciona las colecciones iniciadas antes del 1970 y terminadas antes del 2000.
SELECT * FROM coleccion WHERE ano_fin < 1970 AND ano_fin < 2000;

# d)	Selecciona el identificador de los subscritores que han iniciado la colección con nombre ‘Minerales del Mundo’ des del 1r número.
SELECT sc.id_subscritor FROM subscritor_coleccion AS sc
	WHERE sc.nombre_coleccion = 'Minerales del Mundo' AND num_inicio = 1;

# e)	Selecciona la id de los usuarios que no tengan un email válido (suponiendo que un mail válido tiene que contener una @).
SELECT id_usuario FROM usuario WHERE mail NOT LIKE '%@%';

# f)	Muestra las id’s de los regalos que pesan menos de 100g o más de 500g (suponiendo que el atributo peso se guarda en gramos).
SELECT id_regalo FROM regalo WHERE peso < 100 OR peso > 500;
SELECT id_regalo FROM regalo WHERE peso NOT BETWEEN 100 AND 500; 
	# Las dos opciones son válidas! el BETEEN tambíen se puede usar junto con el operador NOT!

# g)	Selecciona las entregas de enero del 2019.
SELECT * FROM entrega WHERE MONTH(fecha_entrega) = 1 AND YEAR(fecha_entrega) = 2019;

# h)	Selecciona las entregas del 31 de Diciembre de 2018 o del 1 de Enero del 2019.
SELECT * FROM entrega WHERE (DAY(fecha_entrega)=31 AND MONTH(fecha_entrega)=12 AND YEAR(fecha_entrega)=2018) 
	OR (DAY(fecha_entrega)=1 AND MONTH(fecha_entrega)=1 AND YEAR(fecha_entrega)=2019);

SELECT * FROM entrega WHERE fecha_entrega = '2018-12-31' OR fecha_entrega = '2019-01-01'; 
	# Al tener que filtrar por una fecha completa no nos hace falta utilizar funciones de fecha, podemos comparar con una fecha directamente!