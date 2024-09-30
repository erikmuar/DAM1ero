Algoritmo ejercicio_7
	
	Escribir("Has hecho horas extra?")
	
	Escribir ("1. Si 2. No")
	
	leer h_extra
	
	Si h_extra == 1 Entonces
		
		Escribir("Introduce cuantas horas extra has hecho")
		
		leer horas_extra
		Escribir("Tienes plus de peligrosidad? ") 
		Escribir ("1. Si 2. No")
		
		leer peligrosidad
		Si peligrosidad == 1 Entonces
			Si horas_extra <= 5 Entonces
				sueldo = 1250 + 250 +(horas_extra * 20)
				
			SiNo
				horas_extra1 = horas_extra - 5
				sueldo = 1250 + 250 + (5*20) + (17* horas_extra1) 
				
				
			Fin Si
		SiNo
			Si horas_extra <= 5 Entonces
				sueldo = 1250 +(horas_extra * 15)
				
			SiNo
				horas_extra1 = horas_extra - 5
				sueldo = 1250 + (5*15) + (12* horas_extra1) 
				
				
			Fin Si
		Fin Si
		
		Escribir "El sueldo es " sueldo 
	SiNo
		sueldo = 1250 
		Escribir "El sueldo es " sueldo
	Fin Si
	
	
	
	
	
	
	
	
	
	
	
	
	
FinAlgoritmo
