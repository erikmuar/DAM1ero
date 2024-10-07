Algoritmo ejercicio_10
	
	flg = Verdadero 	
	
	Escribir ("Cuanto dinero quieres invertir?") 
	leer inversion 
	
	
	Mientras flg = Verdadero Hacer
		
		
		
		Escribir ("Cual es el estado del mercado?")
		Escribir ("1. Alza ")
		Escribir ("2. Baja ")
		
		
		leer mercado
		
		Segun mercado Hacer
			1:
				resultado = inversion * 1.02 
				
				total_BTC = resultado/8400 
				flg = Falso 
				
			2:
				resultado = inversion * 0.98 
				
				total_BTC = resultado/8400
				
				flg = Falso 
				
			De Otro Modo:
				Escribir ("Opción no válida. Por favor, selecciona 1 o 2.") 
				
		Fin Segun	
	Fin Mientras
	
		
	
	Escribir "El resultado de tu inversión es " total_BTC " Bitcoins"
	
	
	
	
	
	
	
	
	
	 
FinAlgoritmo
