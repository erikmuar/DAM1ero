SELECT table_name 
  INTO OUTFILE 'RUTA_FICHERO/nom_taules.txt' 
  LINES TERMINATED BY ';\n' 
  FROM information_schema.TABLES 
  WHERE TABLE_SCHEMA="INTRODUCIR_NOMBRE_BBDD" 
    AND TABLE_TYPE = "base table"
SELECT table_name 
  INTO OUTFILE 'RUTA_FICHERO/nombre_tablas.txt' 
  LINES TERMINATED BY ';\n' 
  FROM information_schema.TABLES 
  WHERE TABLE_SCHEMA="INTRODUCIR_NOMBRE_BBDD" 
    AND TABLE_TYPE = "base table"
