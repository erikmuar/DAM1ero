package com.company;

public class CompteEndarrereRecursiu {
    public static void main(String[] args) {
        compteEndarrereRecursiu(10);
    }

    static void compteEndarrereRecursiu(int n){
        if(n == 0){
            System.out.print("Boom!!");
        }
        else {
            System.out.print(n + ",");
            compteEndarrereRecursiu(n - 1);
        }
    }
}
