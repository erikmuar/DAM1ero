package models;

public class Texans extends Roba{
    private String type;

    public Texans(String cod, float price, String size, String color, char genre,String type) {
        super(cod,price,size,color,genre);
        this.type = type;
    }

    @Override
    public String toString() {
        return super.toString() +
                "type='" + type + '\'' +
                '}';
    }
}
