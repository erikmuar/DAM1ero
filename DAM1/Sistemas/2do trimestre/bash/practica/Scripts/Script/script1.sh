#!/bin/bash
break=-1
break2=-1

while [ $break -eq -1 ]
do
    echo -n "Introduce tu ID manin: "
    read id

    estar=$(awk -v var=$id '$1==var {print $1, $2}' trabajadores.txt)


    if [[ -z $estar ]]
    then
        echo "El ID no existe"

        while [ $break2 -eq -1 ]
        do
            echo -n "Vols tornar a introduir un ID? (S/N): "
            read resposta
            case $resposta in
                S)  
                    break2=0
                    ;;
                N)  
                    break=0
                    break2=0
                    echo "Sortint.."
                    ;;
                *)  
                    echo "Escriu una resposta possible, és sensible a majúscules."
                    ;;
            esac
        done
    else
        if [[ ! -f horaEntrada.txt ]]
        then
            > horaEntrada.txt
        fi

        hora=$(date | awk '{print $2, $3, $5}')
        horaSalida=$(date | awk '{print "Hora_de_salida:", $5}')
        dia=$(date | awk '{print $3}')
        mes=$(date | awk '{print $3}')

        existe=$(awk -v var="$id" -v var2="$dia" -v var3="$mes" '$1==var && $3==var2 && $4==var3 {print "ID:"$1, "Nombre:"$2, "Día:"$3, "Mes:"$4, "Hora_de_entrada:"$5}' horaEntrada.txt)

        if [[ -z $existe ]]
        then
            echo "$estar $hora" >> horaEntrada.txt
            echo "ID acceptat, l'hora d'entrada és: $hora"
            break=0
        else
            if [[ ! -f horaSortida.txt ]]
            then
                > horaSortida.txt
            fi

            existe2=$(awk -v var="ID:$id" -v var2="Día:$dia" -v var3="Mes:$mes" '$1==var && $3==var2 && $4==var3 {print $1}' horaSortida.txt)

            if [[ -z $existe2 ]]
            then
                echo "$existe $horaSalida" >> horaSortida.txt
                echo "ID acceptat, l'hora de sortida és: $horaSalida"
                break=0
            else
                echo "La persona con este ID no puede fichar hasta mañana"
                break=0
            fi
        fi
    fi
done
