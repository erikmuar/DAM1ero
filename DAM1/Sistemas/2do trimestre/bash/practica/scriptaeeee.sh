#!/bin/bash   

# Variables para controlar los bucles
break=-1
break2=-1

# Bucle principal que se repetirá hasta que break sea diferente de -1
while [ $break -eq -1 ]
do
    echo -n "Introduce tu ID: "  # Pide al usuario que introduzca su ID
    read id  # Guarda el ID introducido en la variable 'id'

    # Busca en el archivo trabajadores.txt si existe el ID introducido
    # Si existe, guarda el ID y el nombre en la variable 'estar'
    estar=$(awk -v var="$id" '$1==var {print $1, $2}' trabajadores.txt)

    # Comprueba si no se encontró el ID
    if [[ -z $estar ]]
    then
        echo "El ID no existe"

        # Segundo bucle para preguntar si quiere introducir un nuevo ID
        while [ $break2 -eq -1 ]
        do
            echo -n "¿Quieres introducir un nuevo ID? (S/N): "  # Pregunta al usuario si quiere intentar otro ID
            read resposta  # Guarda la respuesta

            case $resposta in
                S)  # Si responde S (sí), simplemente sale del bucle secundario
                    break2=0
                    ;;
                N)  # Si responde N (no), termina ambos bucles y el script
                    break=0
                    break2=0
                    echo "Saliendo..."
                    ;;
                *)  # Si escribe algo distinto, muestra un mensaje de error
                    echo "Por favor, escribe una respuesta válida (S/N)."
                    ;;
            esac
        done

    else  # Si el ID sí existe

        # Comprueba si el archivo horaEntrada.txt no existe, y si no, lo crea
        if [[ ! -f horaEntrada.txt ]]; then
            > horaEntrada.txt  # Crea un archivo vacío
        fi

        # Guarda la fecha y la hora actuales
        fecha=$(date "+%d-%m-%Y")
        hora=$(date "+%H:%M")

        # Comprueba si ya existe una entrada para este ID y esta fecha en horaEntrada.txt
        existe=$(awk -v var="$id" -v fecha="$fecha" '$1==var && $3==fecha {print $1}' horaEntrada.txt)

        if [[ -z $existe ]]  # Si NO existe, significa que es la hora de entrada
        then
            # Extrae el nombre del trabajador
            nombre=$(echo "$estar" | awk '{print $2}')
            # Añade la entrada al archivo horaEntrada.txt
            echo "$id $nombre $fecha $hora" >> horaEntrada.txt
           
