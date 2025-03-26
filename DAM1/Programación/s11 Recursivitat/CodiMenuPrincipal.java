package com.company;

import java.util.Scanner;

public class CodiMenuPrincipal {
    public static void main (String[] args) {
        menuPrincipal();
    }

    public static void menuPrincipal(){
        int opcio = 0;
        int min = 1, max = 2;
        opcio = llegirInt("Escull una de les opcions següents: \n1- Hola\n2- Adéu", min, max);

        switch (opcio){
            case 1:
                System.out.println("Hola");
                menuPrincipal();
                break;
            case 2:
                System.out.println("Adéu");
                menuPrincipal();
                break;
        }
    }

    private static int llegirInt(String menuPrincipal, int min, int max) {
        Scanner llegir = new Scanner(System.in);
        int opcio = 0;
        boolean valorCorrecte = false;

        do{
            System.out.println(menuPrincipal);
            valorCorrecte = llegir.hasNextInt();

            if (!valorCorrecte){
                System.out.println("ERROR: No has introduït un enter");
                llegir.nextLine();
            }else{
                opcio = llegir.nextInt();
                llegir.nextLine();
            }

            if (opcio < min || opcio > max){
                System.out.println("ERROR: Opció no correcte!");
                valorCorrecte = false;
            }

        }while (!valorCorrecte);
        return opcio;
    }

}
