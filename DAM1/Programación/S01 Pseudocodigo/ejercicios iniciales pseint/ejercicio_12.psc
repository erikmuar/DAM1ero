Algoritmo ejercicio_12
	
	// Algoritmo que calcule de la factura del aigua en funci�n de los litros consumidos.
	
	//a. La quota fixa mensual �s de 6 de manteniment.
	//b. Si el consum de l?aigua �s menor de 50 litres al mes, no es paga quota variable.
	//c. Si el consum d?aigua es troba entre 50 i 200 litres, es paga 0.15  al litre.
	//d. Si el consum �s major de 200 litres, es paga el litre a 0.30 .
	
	Escribir ("Cuantos litros de agua consumes al mes? ") 
	
	leer litros 
	
	fijo = 6 

	Si litros < 50 Entonces
		factura = 0 
	Fin Si
	
	Si litros > 50 y litros < 200  Entonces
		factura = litros * 0.15 
	Fin Si
	
	Si litros > 200 Entonces
		factura = litros * 0.3 
	Fin Si
	
	
	total = factura + fijo 
	
	Escribir "El importe de la factura es " total
	
	
	
	
	
	
	
	
	
	
	
	
	
FinAlgoritmo
