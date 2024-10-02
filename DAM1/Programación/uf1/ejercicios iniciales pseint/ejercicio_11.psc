Algoritmo ejercicio_11
	
	Escribir ("Introduce la nota de los ejercicios entregables") 
	leer entregables 
	
	entregables = entregables * 0.2
	
	
	Escribir ("Introduce la nota de los pozos evaluables") 
	leer pozos
	pozos = pozos * 0.1
	
	Escribir ("Introduce la nota del examen final") 
	leer examen
	examen = examen * 0.4
	
	Escribir ("Introduce la nota del práctica final")
	leer practica 
	practica = practica * 0.3
	
	total = entregables + pozos + examen + practica
	
	
	Si total < 5 Entonces
		Escribir "Has suspendido, tu nota media es un " total 
	SiNo
		Escribir "Enhorabuena, has aprobado, tu nota media es un " total
	Fin Si
	

	
	
FinAlgoritmo
