#!/bin/bash

txt="horaSortida.txt"

while IFS= read -r linea
do

    entrada=$(echo "$linea" | awk '{print $5}')
    sortida=$(echo "$linea" | awk '{print $6}')

    entrada2=$( echo $entrada | awk -F":" '{print $2, $3, $4}')
    sortida2=$( echo $sortida | awk -F":" '{print $2, $3, $4}' )

    var=$( echo $entrada2 | awk '{print $1, $2, $3}')  # hora entrada H-M-S
    var2=$( echo $sortida2 | awk '{print $1, $2, $3}') # hora salida H-M-S

    hentrada=$( echo $var | awk '{print $1}')
    minentrada=$( echo $var | awk '{print $2}')

    hentrada=$(( 10#$hentrada*3600 )) #pasar horas a seg
    minentrada=$(( 10#$minentrada*60 )) #pasar min a seg
    segentrada=$( echo $var | awk '{print $3}' ) #segons
    segentrada=$((10#$segentrada+0)) # Se hace el +0 aquí también pq sino causa conflicto, lo considera octal la maquina

    t1=$(( $hentrada+$minentrada+$segentrada )) #tiempo total de entrada en segundos

    hsalida=$( echo $var2 | awk '{print $1}')
    minsalida=$( echo $var2 | awk '{print $2}')

    hsalida=$(( 10#$hsalida*3600 ))
    minsalida=$(( 10#$minsalida*60 ))
    segsalida=$( echo $var2 | awk '{print $3}')
    segsalida=$((10#$segsalida+0))

    t2=$(( $hsalida+$minsalida+$segsalida ))

    total1=$(echo "scale=2;($t2 - $t1)/3600" | bc)

    echo "$linea total_de_horas:$total1"

done < "$txt"
