package models;

public class Mitjons extends Roba{
    private String longitud;

    public Mitjons(String cod, float price, String size, String color, char genre, String longitud) {
        super(cod, price, size, color, genre);
        this.longitud = longitud;
    }

    @Override
    public String toString() {
        return super.toString() +
                "longitud='" + longitud + '\'' +
                '}';
    }
}
