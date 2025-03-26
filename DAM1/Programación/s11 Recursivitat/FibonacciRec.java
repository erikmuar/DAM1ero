package com.company;

public class FibonacciRec {
    public static void main(String[] args) {
        int nombre = 7;
        for (int i = 0; i < nombre ; i++) {
            System.out.print(fibonacciRec(i) + " ");
        }
    }

    static int fibonacciRec(int n){
        if(n <= 1){
            return n;
        }
        else{
            return fibonacciRec(n-1) + fibonacciRec(n-2);
        }
    }
}
