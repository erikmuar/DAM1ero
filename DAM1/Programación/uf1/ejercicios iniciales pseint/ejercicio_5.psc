Algoritmo ejercicio_5
	Repetir
		Escribir("Tienes 2 coches registrados")
		Escribir("1. Volkswagen")
		Escribir("2. Camper") 
		
		Escribir("Selecciona un coche") 
		leer coche 
		
		
		Escribir("Introduce el número de km")
		leer km 
		
		Segun coche Hacer
			
			1: valor_mercado = 73490 - (73490*(0.0000001*(km))) 
				
			2: valor_mercado = 93490 - (93490*(0.0000001*(km))) 
				
		
		Fin Segun
		
		Escribir "El valor de mercado del coche es " valor_mercado
	Hasta Que coche == 1 o coche == 2
	
	
	
FinAlgoritmo
