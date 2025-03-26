package com.company;

import java.util.Scanner;

public class MenuRecursiu {
    public static void main(String[] args) {
        menuPrincipal();
    }

    private static void menuPrincipal() {
        Scanner llegir = new Scanner(System.in);
        int opcio = 0;

        System.out.println("\n*********************************");
        System.out.println("Benvingut/da al menú principal...");
        System.out.println("*********************************");
        System.out.println("Escull una de les opcions següents\n1- Hola\n2- Adeu\n3- Sortir");

        opcio = llegir.nextInt();
        llegir.nextLine();

        switch (opcio){
            case 1:
                System.out.println("Hola!");
                menuPrincipal();
                break;
            case 2:
                System.out.println("Adèu!");
                menuPrincipal();
                break;
            case 3:
                System.out.println("Sortint del programa...");
                break;
            default:
                System.out.println("Opció no vàlida");
                menuPrincipal();
                break;
        }

    }
}
