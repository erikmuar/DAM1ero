package models;

import java.util.ArrayList;

public class Botiga {
    private String nom;
    private String email;
    private String web;
    private ArrayList<Roba> productes;

    public Botiga(String nom, String email, String web) {
        this.nom = nom;
        this.email = email;
        this.web = web;
        this.productes = new ArrayList<>();
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWeb() {
        return web;
    }

    public void setWeb(String web) {
        this.web = web;
    }

    public ArrayList<Roba> getProductes() {
        return productes;
    }

    public void setProductes(ArrayList<Roba> productes) {
        this.productes = productes;
    }

    /**
     * Aquest mètode afegeix productes dins de l'AL de productes de la botiga
     * @param producte El nou producte a afegir
     * @return Retorna T - F en funció de si s'ha pogut afegir bé o no
     */
    public boolean afegirProducte(Roba producte){
        return this.productes.add(producte);
    }

    @Override
    public String toString() {
        return "Benvingut/da a la botiga: " +
                "nom='" + nom + '\'' +
                ", email='" + email + '\'' +
                ", web='" + web + '\'' +
                '}';
    }
}
