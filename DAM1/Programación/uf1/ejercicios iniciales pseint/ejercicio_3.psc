Algoritmo ejercicio_3
	
	
	
	Escribir ("Cual es el precio del producto?") 
	leer precio 
	Escribir "El precio es " precio 
	
	Escribir "En que estado se encuentra la figura, bueno (1) o malo (2)?" 
	Leer estado
	
	
	Segun estado Hacer
		1:precio = precio * 1.25
			
		2:precio = precio * 1.1
			
		De Otro Modo:
			Escribir ("Introduce 1 o 2") 
	FinSegun
	
	Escribir "El precio es " precio
	
	
FinAlgoritmo
