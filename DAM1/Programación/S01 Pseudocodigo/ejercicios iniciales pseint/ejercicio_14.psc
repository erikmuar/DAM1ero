Algoritmo ejercicio_14
	
	kilian = 82.5
	pau = 78.2
	
	distanciak = 171- 82.5
	distanciap = 171 - 78.2
	
	Escribir "Introduce la velocidad de kilian"
	leer velocidadk
	
	Escribir"Introduce la velocidad de pau"
	leer velocidadp
	
	tiempok = distanciak/velocidadk
	tiempop = distanciap/velocidadp
	
	Si tiempok < tiempop Entonces
		Escribir "Kilian gana la carrera"
	Sino Si tiempok > tiempop Entonces
		Escribir "Pau gana la carrera"
	Sino
		Escribir "Empate"
	FinSi
	
FinAlgoritmo
