package models;

public class Roba {
    private String cod;
    private float price;
    private String size;
    private String color;
    private char genre;

    public Roba(String cod, float price, String size, String color, char genre) {
        this.cod = cod;
        this.price = price;
        this.size = size;
        this.color = color;
        this.genre = genre;
    }

    @Override
    public String toString() {
        return this.getClass() + "{"+
                "cod='" + cod + '\'' +
                ", price=" + price +
                ", size='" + size + '\'' +
                ", color='" + color + '\'' +
                ", genre=" + genre +
                '}';
    }
}
