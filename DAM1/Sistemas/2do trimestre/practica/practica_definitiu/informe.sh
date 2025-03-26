#!/bin/bash

awk '{
    if (NF == 4) {
        split($4, time, ":"); 
        time[1] += 8;
        if (time[1] < 10) time[1] = "0" time[1]; 
        $5 = time[1] ":" time[2]; 
    }
    print $0;
}' registroEntradaSalida.txt > registroEntradaSalida.tmp && mv registroEntradaSalida.tmp registroEntradaSalida.txt

echo "Horas de salida completadas en 'registroEntradaSalida.txt'."

seguir=1

while [[ $seguir -eq 1 ]]; do
    echo "=== INFORME DE HORAS TRABAJADAS ==="
    echo -n "Introduce el ID del trabajador (o escribe SALIR para terminar): "
    read id

    # Salir si el usuario escribe SALIR
    if [[ "$id" == "SALIR" ]]; then
        echo "Saliendo..."
        break
    fi

    # Verificar si existe el ID
    existe=$(awk -v var="$id" '$1==var' registroEntradaSalida.txt)
    if [[ -z $existe ]]; then
        echo "El ID no existe en el registro."
        continue
    fi

    echo "Selecciona el informe:"
    echo "1. Horas diarias"
    echo "2. Horas semanales (últimos 7 días)"
    echo "3. Horas mensuales (mes actual)"
    echo "4. Salir"
    read opcion

    case $opcion in
        1)
            echo -n "Introduce el dia (2 dígitos, ej: 05): "
            read dia_sel
            echo -n "Introduce el mes (2 dígitos, ej: 03): "
            read mes_sel
            echo -n "Introduce el año (ej: 2025): "
            read anio_sel

            if [[ -z "$anio_sel" ]]; then
                anio_sel=$(date "+%Y")
            fi

            fecha_consulta="${dia_sel}-${mes_sel}-${anio_sel}"

            # Calcular minutos directamente con awk
            total_minutos=$(awk -v var="$id" -v fecha="$fecha_consulta" '
                $1==var && $3==fecha {
                    hora_ent = substr($4, 1, 2)
                    min_ent = substr($4, 4, 2)
                    hora_sal = substr($5, 1, 2)
                    min_sal = substr($5, 4, 2)
                    entrada_min = (hora_ent * 60) + min_ent
                    salida_min = (hora_sal * 60) + min_sal
                    total += (salida_min - entrada_min)
                }
                END { print total }' registroEntradaSalida.txt)

            horas=$((total_minutos / 60))
            resto=$((total_minutos % 60))

            echo "Horas trabajadas el día $fecha_consulta: $horas horas y $resto minutos"
            ;;


        2)
            echo -n "Introduce el DÍA de inicio (2 dígitos, ej: 10). Se recomienda empezar por un lunes: "
            read dia_ini
            echo -n "Introduce el MES de inicio (2 dígitos, ej: 04): "
            read mes_ini
            echo -n "Introduce el AÑO de inicio (ej: 2025): "
            read anio_ini

            # Convertir fecha inicial a segundos
            fecha_ini_seg=$(date -d "${anio_ini}-${mes_ini}-${dia_ini}" +%s)

            # Calcular fecha final (7 días después)
            fecha_fin_seg=$((fecha_ini_seg + 604800))  # 7 días = 604800 segundos

            total_minutos=$(awk -v var="$id" -v ini="$fecha_ini_seg" -v fin="$fecha_fin_seg" '
                {
                    split($3, d, "-")
                    cmd = "date -d\"" d[3] "-" d[2] "-" d[1] "\" +%s"
                    cmd | getline fechaseg
                    close(cmd)

                    if ($1 == var && fechaseg >= ini && fechaseg < fin) {
                        hora_ent = substr($4, 1, 2)
                        min_ent = substr($4, 4, 2)
                        hora_sal = substr($5, 1, 2)
                        min_sal = substr($5, 4, 2)

                        entrada_min = (hora_ent * 60) + min_ent
                        salida_min = (hora_sal * 60) + min_sal
                        total += (salida_min - entrada_min)
                    }
                }
                END { print total }' registroEntradaSalida.txt)

            horas=$((total_minutos / 60))
            resto=$((total_minutos % 60))

            echo "Horas trabajadas para la semana del ${dia_ini}-${mes_ini}-${anio_ini}: $horas horas y $resto minutos"
            ;;


        3)
            mes_actual=$(date "+%m-%Y")

            total_minutos=$(awk -v var="$id" -v mes="$mes_actual" '
                {
                    split($3, d, "-")
                    mes_reg = d[2] "-" d[3]

                    if ($1 == var && mes_reg == mes) {
                        hora_ent = substr($4, 1, 2)
                        min_ent = substr($4, 4, 2)
                        hora_sal = substr($5, 1, 2)
                        min_sal = substr($5, 4, 2)

                        entrada_min = (hora_ent * 60) + min_ent
                        salida_min = (hora_sal * 60) + min_sal
                        total += (salida_min - entrada_min)
                    }
                }
                END { print total }' registroEntradaSalida.txt)

            horas=$((total_minutos / 60))
            resto=$((total_minutos % 60))

            echo "Total horas trabajadas en el mes actual: $horas horas y $resto minutos"
            ;;
        4)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción no válida."
            ;;
    esac

    echo ""
done