Algoritmo ejercicio_2
	Escribir (" Introduce el precio") 
	leer precio
	Escribir("Eres vip? 1.Si, 2.No")
	leer vip
	
	Si precio > 200  Entonces
		precio_final = precio * 0.8
		
	SiNo
		Segun vip Hacer
			1: precio_final = precio * 0.8
				
				
			2: precio_final = precio
				
		Fin Segun
		Escribir "El precio final es " precio_final
	
	Fin Si
	
	
	
	
	
FinAlgoritmo



