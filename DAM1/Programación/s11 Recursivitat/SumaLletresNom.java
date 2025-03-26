package com.company;

import java.util.Arrays;

public class SumaLletresNom {
    public static void main(String[] args) {

        char[] vec = "Gerard".toCharArray();

        int resultat = sumaLletresNom(vec, vec.length-1);
        System.out.println("El resultat de sumar tot el vector" + Arrays.toString(vec) + " es " + resultat);

    }

    public static int sumaLletresNom(char[] vec, int i) {
        if(i == 0){
            return vec[0];
        }else{
            return vec[i] + sumaLletresNom(vec,i-1);
        }

    }
}
