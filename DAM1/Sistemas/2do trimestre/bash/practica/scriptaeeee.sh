#!/bin/bash   # Indica que el script debe ejecutarse con Bash

# Variables de control para los bucles
break=-1      # Controla el bucle principal (mientras sea -1, sigue pidiendo ID)
break2=-1     # Controla el bucle secundario (para preguntar si quiere volver a introducir ID)

# Bucle principal: sigue pidiendo ID mientras break sea -1
while [ $break -eq -1 ]
do
    echo -n "Introduce tu ID: "  # Pide al usuario que introduzca su ID
    read id                      # Guarda el ID introducido en la variable 'id'

    # Busca en el archivo trabajadores.txt si existe el ID (comparando con la primera columna)
    # Si encuentra el ID, guarda el ID y nombre en la variable 'estar'
    estar=$(awk -v var="$id" '$1==var {print $1, $2}' trabajadores.txt)

    # Si 'estar' está vacío (el ID no existe en trabajadores.txt)
    if [[ -z $estar ]]
    then
        echo "El ID no existe"

        # Segundo bucle: pregunta si quiere introducir otro ID
        while [ $break2 -eq -1 ]
        do
            echo -n "¿Quieres introducir un nuevo ID? (S/N): "  # Pregunta si desea volver a intentarlo
            read resposta  # Guarda la respuesta del usuario

            # Dependiendo de la respuesta
            case $resposta in
                S)  # Si responde 'S' (Sí), simplemente sale del segundo bucle y vuelve a pedir ID
                    break2=0
                    ;;
                N)  # Si responde 'N' (No), sale de ambos bucles y termina el programa
                    break=0
                    break2=0
                    echo "Saliendo..."
                    ;;
                *)  # Si escribe algo inválido, muestra un mensaje de error y repite la pregunta
                    echo "Por favor, escribe una respuesta válida (S/N)."
                    ;;
            esac
        done

    else  # Si el ID sí existe

        # Comprueba si el archivo horaEntrada.txt existe, si no, lo crea vacío
        if [[ ! -f horaEntrada.txt ]]; then
            > horaEntrada.txt  # Crea un archivo vacío
        fi

        # Guarda la fecha actual en formato DD-MM-YYYY
        fecha=$(date "+%d-%m-%Y")

        # Guarda la hora actual en formato HH:MM
        hora=$(date "+%H:%M")

        # Comprueba si ya existe una entrada para ese ID en el día actual en horaEntrada.txt
        existe=$(awk -v var="$id" -v fecha="$fecha" '$1==var && $3==fecha {print $1}' horaEntrada.txt)

        if [[ -z $existe ]]  # Si NO encontró una entrada para hoy
        then
            # Extrae el nombre del trabajador desde 'estar'
            nombre=$(echo "$estar" | awk '{print $2}')

            # Añade registro de entrada al archivo horaEntrada.txt con formato: ID Nombre Fecha Hora
            echo "$id $nombre $fecha $hora" >> horaEntrada.txt
            echo "ID aceptado, la hora de entrada es: $hora"
            break=0  # Sale del bucle principal

        else  # Si ya existe una entrada, entonces es hora de salida

            # Comprueba si el archivo horaSortida.txt existe, si no, lo crea vacío
            if [[ ! -f horaSortida.txt ]]; then
                > horaSortida.txt
            fi

            # Comprueba si ya existe una salida para ese ID hoy en horaSortida.txt
            existe2=$(awk -v var="$id" -v fecha="$fecha" '$1==var && $3==fecha {print $1}' horaSortida.txt)

            if [[ -z $existe2 ]]  # Si NO hay salida registrada
            then
                nombre=$(echo "$estar" | awk '{print $2}')  # Extrae el nombre
                # Añade registro de salida al archivo horaSortida.txt
                echo "$id $nombre $fecha $hora" >> horaSortida.txt
                echo "ID aceptado, la hora de salida es: $hora"
                break=0  # Sale del bucle principal

            else  # Si ya registró entrada y salida, no puede fichar más hoy
                echo "La persona con este ID no puede fichar hasta mañana."
                break=0  # Sale del bucle principal
            fi
        fi
    fi
done
