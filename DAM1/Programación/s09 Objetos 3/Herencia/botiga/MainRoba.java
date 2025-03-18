package com.company;

import jdk.jshell.execution.Util;
import models.*;
import utilitats.Utilities;

public class MainRoba {
    public static void main (String[] args){
        Botiga zara = new Botiga(Utilities.llegirFrase("Escriu el nom de la botiga")
                                , Utilities.llegirParaula("Escriu l'email de la botiga")
                                , Utilities.llegirParaula("Escriu la url de la botiga"));

        System.out.println(zara);
        Roba producte = donarAltaProducte();
        System.out.println(producte);



        int quantitatProducte = Utilities.llegirInt("Escriu quants productes vols crear", 1, 10);

        for (int i = 0; i < quantitatProducte; i++) {
            producte = donarAltaProducte();
            System.out.println(producte);
            zara.afegirProducte(producte);
        }

    }

    private static Roba donarAltaProducte(){
        Roba producte = null;
        int tipusProducte = Utilities.llegirInt("Escriu el tipus de producte a crear:\n1-Texans\n2-Mitjons\n3-Bufanda\n4-Roba",1,4);

        switch (tipusProducte){
            case 1:
                producte = new Texans(Utilities.llegirParaula("Escriu el codi del producte")
                        ,Utilities.llegirFloat("Escriu el preu del producte",0,10000)
                        ,Utilities.llegirParaula("Escriu la mida de la roba")
                        ,Utilities.llegirParaula("Escriu el color de la roba")
                        ,Utilities.llegirChar("Escriu H/D")
                        ,Utilities.llegirParaula("Escriu el tipus de texans"));
                break;
            case 2:
                producte = new Mitjons(Utilities.llegirParaula("Escriu el codi del producte")
                        ,Utilities.llegirFloat("Escriu el preu del producte",0,10000)
                        ,Utilities.llegirParaula("Escriu la mida de la roba")
                        ,Utilities.llegirParaula("Escriu el color de la roba")
                        ,Utilities.llegirChar("Escriu H/D")
                        ,Utilities.llegirParaula("Escriu la longitud dels mitjons"));
                break;
            case 3:
                producte = new Bufanda(Utilities.llegirParaula("Escriu el codi del producte")
                        ,Utilities.llegirFloat("Escriu el preu del producte",0,10000)
                        ,Utilities.llegirParaula("Escriu la mida de la roba")
                        ,Utilities.llegirParaula("Escriu el color de la roba")
                        ,Utilities.llegirChar("Escriu H/D"));
                break;
            case 4:
                producte = new Roba(Utilities.llegirParaula("Escriu el codi del producte")
                        ,Utilities.llegirFloat("Escriu el preu del producte",0,10000)
                        ,Utilities.llegirParaula("Escriu la mida de la roba")
                        ,Utilities.llegirParaula("Escriu el color de la roba")
                        ,Utilities.llegirChar("Escriu H/D"));
                break;
        }

        return producte;
    }

}
