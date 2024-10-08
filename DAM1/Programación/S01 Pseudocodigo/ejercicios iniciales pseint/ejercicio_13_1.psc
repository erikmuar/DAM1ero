Algoritmo ejercicio_13
	
	flg = Verdadero
	
	Repetir
		
		Escribir "Bienvenido, seleccione un cafe"
		Escribir "1. Cafe"
		Escribir "2. Cortado"
		Escribir "3. Cafe con leche"
		Escribir "4. Salir"
		
		leer cafe 
		
		Si cafe > 4 o cafe < 1   Entonces
			Escribir "Introduce una de las 4 opciones disponibles"
		Fin Si
		
	
		
	Hasta Que (cafe <= 4 y cafe >= 0) 
	
	Mientras flg = Verdadero Hacer
		
		Si cafe = 4 Entonces
			Escribir "Hasta luego"
			flg = Falso
		SiNo
			
			precio = 0.5
			
			Segun cafe Hacer
				1:
					Escribir "Ha elegido un cafe"
				2:
					Escribir "Ha elegido un cortado" 
				3:
					Escribir "Ha elegido un cafe con leche" 
					
			Fin Segun
			
			Escribir " El precio es 0.5. Introduce dinero " 
			leer dinero
			
			Si dinero >= precio Entonces
				cambio = dinero - precio
				
				Escribir "El cambio es " cambio  " Gracias y que tenga un buen dia"
				flg = Falso
			SiNo
				Escribir  "ERROR"
				flg = Falso
			Fin Si
			
			
		Fin Si
		

	Fin Mientras
	
	
	
	
	
	
	
	
FinAlgoritmo
