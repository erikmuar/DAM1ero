#!/bin/bash
break=-1
break2=-1

while [ $break -eq -1 ]
do
    echo -n "Introduce tu ID: "
    read id

    estar=$(awk -v var="$id" '$1==var {print $1, $2}' trabajadores.txt)

    if [[ -z $estar ]]
    then
        echo "El ID no existe"

        while [ $break2 -eq -1 ]
        do
            echo -n "¿Quieres introducir un nuevo ID? (S/N): "
            read resposta
            case $resposta in
                S)  
                    break2=0
                    ;;
                N)  
                    break=0
                    break2=0
                    echo "Saliendo..."
                    ;;
                *)  
                    echo "Por favor, escribe una respuesta válida (S/N)."
                    ;;
            esac
        done
    else

        if [[ ! -f horaEntrada.txt ]]; then
            > horaEntrada.txt
        fi

        fecha=$(date "+%d-%m-%Y")
        hora=$(date "+%H:%M")

        existe=$(awk -v var="$id" -v fecha="$fecha" '$1==var && $3==fecha {print $1}' horaEntrada.txt)

        if [[ -z $existe ]]
        then
            nombre=$(echo "$estar" | awk '{print $2}')
            echo "$id $nombre $fecha $hora" >> horaEntrada.txt
            echo "ID aceptado, la hora de entrada es: $hora"
            break=0
        else
            if [[ ! -f horaSortida.txt ]]; then
                > horaSortida.txt
            fi

            existe2=$(awk -v var="$id" -v fecha="$fecha" '$1==var && $3==fecha {print $1}' horaSortida.txt)

            if [[ -z $existe2 ]]
            then
                nombre=$(echo "$estar" | awk '{print $2}')
                echo "$id $nombre $fecha $hora" >> horaSortida.txt
                echo "ID aceptado, la hora de salida es: $hora"
                break=0
            else
                echo "La persona con este ID no puede fichar hasta mañana."
                break=0
            fi
        fi
    fi
done

