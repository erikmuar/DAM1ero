Algoritmo Maquina_cafe
	
	
	Escribir ("Bienvenido")
	Escribir("Selecciona una opci�n")
	Escribir ("1.Cafe")
	Escribir ("2.Cafe con leche")
	Escribir ("3.Cortado")
	Escribir ("4.Salir")
	
	
	
	Leer cafe 
	Si cafe <> 4 Entonces
		Segun (cafe)
			1: Escribir("Has seleccionado un cafe")
			2: Escribir ("Has seleccionado un cafe con leche")
			3: Escribir("Has seleccionado un cortado") 
				
		FinSegun
		
		Escribir ("Selecciona el tama�o") 
		Escribir ("1.Peque�o")
		Escribir ("2.Mediano")
		Escribir ("3.Grande")
		leer tama�o
		
		Segun (tama�o)
			
			1: Escribir ("Has seleccionado tama�o peque�o")
				precio = 2
			2: Escribir("Has seleccionado tama�o mediano")
				precio = 2.5
			3: Escribir("Has seleccionado tama�o grande")
				precio = 3 
				
				
		FinSegun
		
		Escribir ("1 Azucar")
		Escribir ("2 Azucar")
		Escribir ("3 Azucar")
		Escribir ("4 Azucar")
		Escribir ("5 Azucar")
		
		Escribir("Selecciona nivel de azucar")
		Leer azucar
		Segun (azucar)
			
			1: Escribir ("Has seleccionado 1 azucar")
			2: Escribir("Has seleccionado 2 azucar")
			3: Escribir("Has seleccionado 3 azucar")
			4: Escribir("Has seleccionado 4 azucar")
			5: Escribir("Has seleccionado 5 azucar")
				
		FinSegun
		
		
		
		Escribir "El importe es " precio 
		
		Escribir ("Elige m�todo de pago")
		Escribir("1.Efectivo")
		Escribir("2.Tarjeta")
		leer metodo
		
		segun (metodo) 
			
			1: 	Escribir ("Inserta dinero")
				leer efectivo
				Mientras efectivo < precio Hacer
					diferencia = precio - efectivo 
					Escribir "Cantidad insuficiente de dinero, faltan " diferencia "$. Inserta m�s dinero"
					Leer efectivo1
					efectivo = efectivo + efectivo1
					
				Fin Mientras
				
				
				Si efectivo > precio 
					cambio = efectivo - precio
					Escribir "El cambio es " cambio ", gracias y que tenga un buen d�a"
					
				Fin si
				
				Si efectivo = precio Entonces
					Escribir("Gracias")
				FinSi
				
				
				Escribir ("Que tenga un buen d�a") 
				
			2: Escribir "El importe es " precio ",introduzca PIN"
				leer tarjeta
				
				Escribir ("Gracias y que tenga un buen d�a")
				
				
		FinSegun
	SiNo
		Escribir ("Gracias y que tenga un buen d�a")

	Fin Si
	
	
FinAlgoritmo
 