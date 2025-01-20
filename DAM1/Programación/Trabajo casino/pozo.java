import java.util.Random;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

public class M03_UF1_PR01_RodriguezAleix_MunozErik {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double saldo = 0; // Saldo inicial del usuario
        boolean salir = false; // Bandera para controlar la salida del programa

        // Bucle principal del programa
        
        do {
            System.out.println("Menú Principal:");
            System.out.println("1. Introducir dinero");
            System.out.println("2. Jugar");
            System.out.println("3. Salir");
            System.out.print("Elige una opción: ");
            int opcion = scanner.nextInt(); // El usuario mete la opción que quiere

            switch (opcion) {
                case 1:
                    // Introducir dinero al saldo
                    System.out.print("¿Cuánto dinero quieres introducir? ");
                    saldo += scanner.nextDouble();
                    System.out.println("Saldo actualizado: " + saldo + "€");
                    break;

                case 2:
                    // Ir al menú de juegos si hay saldo
                    if (saldo > 0) {
                        menuJuegos(saldo, scanner);
                    } else {
                        System.out.println("No tienes saldo suficiente. Introduce dinero primero.");
                    }
                    break;

                case 3:
                    // Salir del programa
                    salir = true;
                    System.out.println("¡Gracias por jugar! Saldo final: " + saldo + "€");
                    break;

                default:
                    // Opción no válida
                    System.out.println("Opción no válida. Intenta de nuevo.");
            }
        
        } while (!salir);
        scanner.close(); // Cierra el scanner al finalizar
    }

    private static void menuJuegos(double saldo, Scanner scanner) {
        boolean volver = false; // Bandera para volver al menú principal

        // Bucle del menú de juegos
        while (!volver) {
            System.out.println("Menú de Juegos:");
            System.out.println("1. Blackjack");
            System.out.println("2. Tres en Raya");
            System.out.println("3. Tragaperras");
            System.out.println("4. Rojo o Negro");
            System.out.println("5. Volver al Menú Principal");
            System.out.print("Elige una opción: ");
            int opcion = scanner.nextInt();
            switch (opcion) {
                case 1:
                    // Jugar al Blackjack
                    saldo = jugarBlackjack(saldo, scanner);
                    break;

                case 2:
                    // Jugar a Tres en Raya
                    jugarTresEnRaya();
                    break;

                case 3:
                    // Jugar a Tragaperras
                    saldo = jugarTragaperras(saldo, scanner);
                    break;

                case 4:
                    // Jugar a Rojo o Negro
                    saldo = jugarRojoONegro(saldo, scanner);
                    break;

                case 5:
                    // Volver al menú principal
                    volver = true;
                    break;

                default:
                    // Opción no válida
                    System.out.println("Opción no válida. Intenta de nuevo.");
            }
        }
    }
    private static double jugarBlackjack(double saldo, Scanner scanner) {

        Random random = new Random();

        // Creamos 2 arraylists con las manos del jugador y del crupier

        ArrayList<Integer> manoJugador = new ArrayList<>();
        ArrayList<Integer> manoCrupier = new ArrayList<>();


        System.out.println("¡Bienvenido al Blackjack!");
        System.out.print("¿Cuánto quieres apostar? ");
        double apuesta = scanner.nextDouble(); // Introduce la cantidad apostada

        // Verifica si el usuario tiene saldo suficiente
        if (apuesta > saldo) {
            System.out.println("No tienes suficiente saldo para esta apuesta.");
            return saldo;
        }

        // Lógica del juego

        // Se reparten las cartas al jugador y al crupier

        manoJugador.add(robarCarta(random));
        manoJugador.add(robarCarta(random));
        manoCrupier.add(robarCarta(random));
        manoCrupier.add(robarCarta(random));


        // Imprimimos que cartas le ha tocado a cada uno

        System.out.println("Tus cartas son las siguientes: " + manoJugador + " en total tienes un " + calcularMano(manoJugador));
        System.out.println("Las carta del crupier es " + manoCrupier.get(0));


        // Inicio del turno del jugador

        boolean plantado = false;

        while (!plantado){

            System.out.println("Elige una de las siguientes opciones");
            System.out.println("1. Pedir carta");
            System.out.println("2. Plantarse");

            int opcion = scanner.nextInt();



            switch (opcion){

                case 1:
                    manoJugador.add(robarCarta(random));

                    System.out.println("Tus cartas son las siguientes: " + manoJugador + " en total tienes un " + calcularMano(manoJugador));


                    if (calcularMano(manoJugador) > 21){

                        System.out.println("Te has pasado de 21. Has perdido");

                        saldo -= apuesta; // Cuando te pasas, restamos la apuesta al saldo total y devolvemos el valor
                        return saldo;

                    }

                    break;

                case 2:
                    plantado = true;

                    System.out.println("Te has plantado.");

                    break;



                default:

                    System.out.println("Vuelve a introducir un valor válido. 1 o 2  ");


            }



        }

        //Turno del crupier

        while (calcularMano(manoCrupier)< 17){ // Ponemos de limite 17 para que el crupier vaya pidiendo cartas y tenga opciones de ganar también

            manoCrupier.add(robarCarta(random));

            System.out.println("El crupier roba una carta. Cartas: " + manoCrupier + " Total: " + calcularMano(manoCrupier));
        }


        // Comprobación de las manos para ver quien gana

        int totalJugador = calcularMano(manoJugador);
        int totalCrupier = calcularMano(manoCrupier);

        if (totalJugador > totalCrupier || totalCrupier > 21){

            saldo += apuesta;
            System.out.println("Has ganado!");


        } else if (totalJugador == totalCrupier) {
            System.out.println("Empate!");
            
        }else{

            System.out.println("Has perdido!");
            saldo -= apuesta;

        }

        return saldo;
    }

    private static int robarCarta(Random random){

        return random.nextInt(11) + 1; // Esta funcion devuelve un numero entre el 1 y el 11

    }

    private static int calcularMano(ArrayList <Integer> mano){


        int total = 0;
        int ases = 0;

        for (int carta : mano){

            if (carta == 1){

                ases++;
                total +=11;
            }else{
                total += carta;
            }
        }

        while (total > 21 && ases > 0){  // Si el total se pasa de 21, convertimos los ases en 1

            total -= 10;
            ases--;
        }

        return total;
    }



















    private static void jugarTresEnRaya() {
        System.out.println("¡Bienvenido al Tres en Raya!");
        // Lógica del juego pendiente
        System.out.println("Juego en desarrollo...");
    }
    private static double jugarTragaperras(double saldo, Scanner scanner) {
        System.out.println("¡Bienvenido a las Tragaperras!");
        System.out.print("¿Cuánto quieres apostar? ");
        double apuesta = scanner.nextDouble();

        // Verifica si el usuario tiene saldo suficiente
        if (apuesta > saldo) {
            System.out.println("No tienes suficiente saldo para esta apuesta.");
            return saldo;
        }

        // Lógica simplificada del juego
        boolean gana = Math.random() > 0.8; // 20% de probabilidad de ganar
        if (gana) {
            saldo += apuesta * 5; // Ganancia x5
            System.out.println("¡Has ganado! Nuevo saldo: " + saldo + "€");
        } else {
            saldo -= apuesta;
            System.out.println("Has perdido. Nuevo saldo: " + saldo + "€");
        }

        return saldo; // Devuelve el saldo actualizado.
    }
    private static double jugarRojoONegro(double saldo, Scanner scanner) {
        System.out.println("¡Bienvenido a Rojo o Negro!");
        System.out.print("¿Cuánto quieres apostar? ");
        double apuesta = scanner.nextDouble();

        // Verifica si el usuario tiene saldo suficiente
        if (apuesta > saldo) {
            System.out.println("No tienes suficiente saldo para esta apuesta.");
            return saldo;
        }

        System.out.print("Elige un color (rojo/negro): ");
        String color = scanner.next();

        // Lógica simplificada
        boolean esRojo = Math.random() > 0.5;
        if ((color.equalsIgnoreCase("rojo") && esRojo) ||
                (color.equalsIgnoreCase("negro") && !esRojo)) {
            saldo += apuesta;
            System.out.println("¡Has ganado! Nuevo saldo: " + saldo + "€");
        } else {
            saldo -= apuesta;
            System.out.println("Has perdido. Nuevo saldo: " + saldo + "€");
        }

        return saldo; // Devuelve el saldo actualizado
    }
}