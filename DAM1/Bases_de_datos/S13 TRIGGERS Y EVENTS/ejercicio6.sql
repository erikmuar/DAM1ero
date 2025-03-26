

-- a) Crear el usuario ‘user1’ sin contraseña
CREATE USER 'user1';

-- b) Crear el usuario ‘user2’ con contraseña ‘pwd2’
CREATE USER 'user2' IDENTIFIED BY 'pwd2';

-- c) Crear el usuario ‘user3’ con contraseña ‘pwd3’
CREATE USER 'user3' IDENTIFIED BY 'pwd3';

-- d) Crear el usuario ‘user4’ con contraseña ‘pwd4’
CREATE USER 'user4' IDENTIFIED BY 'pwd4';

-- e) Borrar el usuario ‘user4’
DROP USER 'user4';

-- f) Cambiar el nombre del ‘user2’ a ‘admindb’
RENAME USER 'user2' TO 'admindb';

-- g) Cambiar el password de ‘admindb’ a ‘pwdadmin’
SET PASSWORD FOR 'admindb' = PASSWORD('pwdadmin');

-- h) Dar privilegios totales al usuario ‘admindb’ sobre todas las bases de datos
GRANT ALL PRIVILEGES ON *.* TO 'admindb' WITH GRANT OPTION;

-- i) Dar privilegios de SELECT, INSERT, UPDATE, DELETE al ‘user1’ sobre todas las bases de datos
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'user1';

-- j) Quitar los permisos de INSERT, UPDATE, DELETE al ‘user1’
REVOKE INSERT, UPDATE, DELETE ON *.* FROM 'user1';

-- k) Dar permisos de SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP al ‘user3’
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP ON *.* TO 'user3';

-- l) Quitar todos los permisos al ‘admindb’
REVOKE ALL PRIVILEGES ON *.* FROM 'admindb';
