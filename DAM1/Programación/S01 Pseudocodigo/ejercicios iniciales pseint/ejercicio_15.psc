Algoritmo ejercicio_15
	Definir num1, num2, num3, pos1, pos2, pos3 Como Entero
	// Entrada de datos
	Escribir 'Introduce el primer número:'
	Leer num1
	Escribir 'Introduce el segundo número:'
	Leer num2
	Escribir 'Introduce el tercer número:'
	Leer num3
	// Lógica para ordenar los números de mayor a menor
	Si num1>=num2 Y num1>=num3 Entonces
		pos1 <- num1
		Si num2>=num3 Entonces
			pos2 <- num2
			pos3 <- num3
		SiNo
			pos2 <- num3
			pos3 <- num2
		FinSi
	SiNo
		Si num2>=num1 Y num2>=num3 Entonces
			pos1 <- num2
			Si num1>=num3 Entonces
				pos2 <- num1
				pos3 <- num3
			SiNo
				pos2 <- num3
				pos3 <- num1
			FinSi
		SiNo
			pos1 <- num3
			Si num1>=num2 Entonces
				pos2 <- num1
				pos3 <- num2
			SiNo
				pos2 <- num2
				pos3 <- num1
			FinSi
		FinSi
	FinSi
	// Salida de datos
	Escribir 'Los números ordenados de mayor a menor son:'
	Escribir pos1, ' ', pos2, ' ', pos3
FinAlgoritmo
