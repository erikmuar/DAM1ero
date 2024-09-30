Algoritmo ejercicio_8
	
	Repetir

	Escribir ("Cuantas noches te quedarás ?") 
	leer noches 
	
	Escribir ("A que hora saldrás el último día ? (formato 24h) ") 
	leer hora 
	
	Escribir ("Cuantos días de media pensión te quedarás?") 
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
		Escribir ("No es posible quedarse mas días que noches")
		
	Fin Si
	
	
	
Hasta Que pension < noches
FinAlgoritmo
