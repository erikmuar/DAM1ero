package com.company;

import java.util.Scanner;

public class FactorialRecursiu {

    public static void main(String[] args) {
        int numero = leerNumero();
        System.out.println(factorial(numero));
    }

    private static int factorial(int num){
        if (num == 1){
            return num;
        }   else {
            return num * factorial(num - 1);
        }
    }

    private static int leerNumero(){
        int num;
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduce un número (negativo para terminar): ");
        num = sc.nextInt();
        return num;
    }
}
