Algoritmo ejercicio_8
	
	Repetir

	Escribir ("Cuantas noches te quedar�s ?") 
	leer noches 
	
	Escribir ("A que hora saldr�s el �ltimo d�a ? (formato 24h) ") 
	leer hora 
	
	Escribir ("Cuantos d�as de media pensi�n te quedar�s?") 
	leer pension 
	
	Si pension <= noches Entonces
		precio_noches = noches * 20
		precio_pension = pension * 20 
		precio_hora = 0
		Si hora > 12 Entonces
			precio_hora = 15
		Fin Si
		total = precio_noches + precio_pension + precio_hora
		Escribir "El precio total es " total 
		
	SiNo
		Escribir ("No es posible quedarse mas d�as que noches")
		
	Fin Si
	
	
	
Hasta Que pension < noches
FinAlgoritmo
