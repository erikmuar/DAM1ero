CREATE DATABASE lscloud;
USE lscloud;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(20) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `pais` varchar(20),
  `factura` boolean,
  PRIMARY KEY (`id_usuario`)
);

CREATE TABLE IF NOT EXISTS `servidor` (
  `id_servidor` int(11) NOT NULL AUTO_INCREMENT,
  `servername` varchar(50) NOT NULL,
  `hdd` int(11),
  `ram` int(11),
  `localizacion` varchar(50),
  `id_usuario` int(11),
  PRIMARY KEY (`id_servidor`)
);

CREATE TABLE IF NOT EXISTS `servidorstatus` (
  `id_servidor` int(11),
  `is_broken` boolean,
  `ram_upgrade` boolean,
  `ram_downgrade` boolean,
  PRIMARY KEY (`id_servidor`)
);

CREATE TABLE IF NOT EXISTS `alertas` (
  `id_alerta` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_alerta` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `motivo` varchar(50),
  `fecha_aleta` datetime NOT NULL,
  PRIMARY KEY (`id_alerta`)
);

ALTER TABLE servidor ADD FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE servidorstatus ADD FOREIGN KEY (id_servidor) REFERENCES servidor(id_servidor) ON UPDATE CASCADE ON DELETE CASCADE;