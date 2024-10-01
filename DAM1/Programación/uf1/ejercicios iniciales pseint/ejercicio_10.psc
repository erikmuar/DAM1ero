Algoritmo ejercicio_10
	
	Escribir ("Cuanto dinero quieres invertir?") 
	leer inversion 
	
	Escribir ("Cual es el estado del mercado?")
	Escribir ("1. Alza ")
	Escribir ("2. Baja ")
	
	leer mercado
	
	Segun mercado Hacer
		1:
			ganancias = inversion * 1.02 
			
			total_BTC = ganancias/8400 
			
		2:
			perdidas = inversion * 0.98 
			
			total_BTC = perdidas/8400
			
		
		De Otro Modo:
			Escribir ("Vuelve a seleccionar una opción") 
			
		
	Fin Segun
	
	Escribir "El resultado de tu inversión es " total_BTC " Bitcoins"
	
	
	
	
	
	
	
	
	
	 
FinAlgoritmo
