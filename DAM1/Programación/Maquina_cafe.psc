Algoritmo Maquina_cafe
	
	
	Escribir ("Bienvenido")
	Escribir("Selecciona una opción")
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
		
		Escribir ("Selecciona el tamaño") 
		Escribir ("1.Pequeño")
		Escribir ("2.Mediano")
		Escribir ("3.Grande")
		leer tamaño
		
		Segun (tamaño)
			
			1: Escribir ("Has seleccionado tamaño pequeño")
				precio = 2
			2: Escribir("Has seleccionado tamaño mediano")
				precio = 2.5
			3: Escribir("Has seleccionado tamaño grande")
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
		
		Escribir ("Elige método de pago")
		Escribir("1.Efectivo")
		Escribir("2.Tarjeta")
		leer metodo
		
		segun (metodo) 
			
			1: 	Escribir ("Inserta dinero")
				leer efectivo
				Mientras efectivo < precio Hacer
					diferencia = precio - efectivo 
					Escribir "Cantidad insuficiente de dinero, faltan " diferencia "$. Inserta más dinero"
					Leer efectivo1
					efectivo = efectivo + efectivo1
					
				Fin Mientras
				
				
				Si efectivo > precio 
					cambio = efectivo - precio
					Escribir "El cambio es " cambio ", gracias y que tenga un buen día"
					
				Fin si
				
				Si efectivo = precio Entonces
					Escribir("Gracias")
				FinSi
				
				
				Escribir ("Que tenga un buen día") 
				
			2: Escribir "El importe es " precio ",introduzca PIN"
				leer tarjeta
				
				Escribir ("Gracias y que tenga un buen día")
				
				
		FinSegun
	SiNo
		Escribir ("Gracias y que tenga un buen día")

	Fin Si
	
	
FinAlgoritmo
 