#!/bin/bash

# Archivo necesario
entrada_file="horaEntrada.txt"

# Función para calcular el total de horas trabajadas entre dos tiempos
calcular_horas() {
    entrada=$1
    salida=$2
    # Convertir horas y minutos a minutos totales
    entrada_minutos=$(echo $entrada | awk -F: '{print ($1 * 60) + $2}')
    salida_minutos=$(echo $salida | awk -F: '{print ($1 * 60) + $2}')
    # Calcular diferencia y convertir de vuelta a horas
    minutos_totales=$((salida_minutos - entrada_minutos))
    echo "$((minutos_totales / 60))h $((minutos_totales % 60))m"
}

# Mostrar menú de opciones
echo -e "\nSelecciona una opción:"
echo "1) Horas diarias"
echo "2) Horas semanales"
echo "3) Horas mensuales"
read -p "Introduce el número de la opción: " opcion

# Solicitar ID del trabajador
read -p "Introduce el ID del trabajador: " id

# Verificar que el ID existe en el archivo
existe=$(awk -v id="$id" '$1 == id {found=1; exit} END{print found}' "$entrada_file")

if [[ -z $existe ]]; then
    echo "El ID no existe en los registros."
    exit 1
fi

# Procesar opción seleccionada
case $opcion in
    1) #Horas diarias
        echo "Informe de horas diarias para el ID: $id"
        echo "======================================="
        total_general=0
        registros_encontrados=0

        #Leer el archivo de entrada, filtrar por ID y luego procesar las fechas, hora de entrada y salida
        awk -v var="$id" '$1 == var {print $3, $4, $5}' "$entrada_file" | \
        # Convertir la fecha al formato YYYY-MM-DD y luego ordenar cronológicamente
        while read fecha hora_entrada hora_salida
        do
            # Convertir la fecha al formato YYYY-MM-DD
            fecha_convertida=$(echo $fecha | awk -F'-' '{print $3"-"$2"-"$1}')
            echo "$fecha_convertida $hora_entrada $hora_salida"
        done | sort -t'-' -k1,1 -k2,2 -k3,3 | \
        while read fecha_convertida hora_entrada hora_salida
        do
            # Convertir de nuevo a formato DD-MM-YYYY
            fecha_final=$(echo $fecha_convertida | awk -F'-' '{print $3"-"$2"-"$1}')
            horas_trabajadas=$(calcular_horas $hora_entrada $hora_salida)
            echo "Fecha: $fecha_final - Entrada: $hora_entrada - Salida: $hora_salida - Total: $horas_trabajadas"
            minutos=$(echo $horas_trabajadas | awk -F'[h m]' '{print ($1 * 60) + $2}')
            total_general=$((total_general + minutos))
            ((registros_encontrados++))
        done
        ;;
    2)
        echo "Informe de horas semanales"
echo "========================="

# Inicializar variables
total_semanal=0
semana=1
dias_consecutivos=0
fecha_inicio=""
touch horas_diarias.txt
# Procesar las horas diarias
while read id fecha hora_entrada hora_salida
do
    # Convertir la fecha al formato YYYY-MM-DD
    fecha_convertida=$(echo $fecha | awk -F'-' '{print $3"-"$2"-"$1}')

    # Calcular las horas trabajadas
    horas_trabajadas=$(calcular_horas "$hora_entrada" "$hora_salida")
    horas=$(echo $horas_trabajadas | awk '{print $1}')
    minutos=$(echo $horas_trabajadas | awk '{print $2}')

    minutos_totales=$(($horas * 60 + $minutos))
    total_semanal=$((total_semanal + minutos_totales))

    # Si es el primer registro o las fechas son consecutivas, sigue sumando
    if [[ -z $fecha_inicio || $fecha_convertida == $(date -d "$fecha_anterior +1 day" +%Y-%m-%d) ]]; then
        fecha_inicio=$fecha_convertida
        fecha_anterior=$fecha_convertida
        dias_consecutivos=$((dias_consecutivos + 1))
    else
        # Si no son consecutivas, se termina la semana actual y empieza una nueva
        horas_semanales=$((total_semanal / 60))
        minutos_semanales=$((total_semanal % 60))
        echo "Semana $semana ($fecha_inicio al $fecha_anterior): ${horas_semanales}h ${minutos_semanales}m"
        semana=$((semana + 1))

        # Reiniciar el conteo de la nueva semana
        total_semanal=0
        dias_consecutivos=1
        fecha_inicio=$fecha_convertida
        fecha_anterior=$fecha_convertida
    fi
done < horas_diarias.txt

# Imprimir la última semana (si hay registros restantes)
if [[ $dias_consecutivos -gt 0 ]]; then
    horas_semanales=$((total_semanal / 60))
    minutos_semanales=$((total_semanal % 60))
    echo "Semana $semana ($fecha_inicio al $fecha_anterior): ${horas_semanales}h ${minutos_semanales}m"
fi
;;
    3) # Horas mensuales
        echo "Informe de horas mensuales para el ID: $id"
        echo "======================================="

        # Procesar registros por mes usando variables temporales
        declare -A totales_mes
        while read -r linea; do
            fecha=$(echo "$linea" | awk '{print $3}')
            hora_entrada=$(echo "$linea" | awk '{print $4}')
            mes_anio=$(echo "$fecha" | awk -F- '{print $2"-"$3}')

            hora_salida=$(awk -v var="$id" -v fecha="$fecha" '$1 == var && $3 == fecha {print $4}' $salida_file)

            if [[ -n $hora_salida ]]; then
                horas_dia=$(calcular_horas "$hora_entrada" "$hora_salida")
                minutos=$(echo "$horas_dia" | awk -F'[h m]' '{print ($1 * 60) + $2}')
                totales_mes["$mes_anio"]=$((${totales_mes["$mes_anio"]:-0} + minutos))
            fi
        done < <(awk -v var="$id" '$1 == var {print $0}' "$entrada_file" | sort)

        # Mostrar resultados
        registros_encontrados=0
        for mes_anio in $(echo "${!totales_mes[@]}" | tr ' ' '\n' | sort); do
            total_mes=${totales_mes["$mes_anio"]}
            if [[ $total_mes -gt 0 ]]; then
                horas_mes=$((total_mes / 60))
                minutos_mes=$((total_mes % 60))
                echo "Mes $mes_anio: ${horas_mes}h ${minutos_mes}m"
                ((registros_encontrados++))
            fi
        done

        if [[ $registros_encontrados -eq 0 ]]; then
            echo "No se encontraron registros para este ID."
        fi
        ;;

    *)
        echo "Opción no válida."
        ;;
esac