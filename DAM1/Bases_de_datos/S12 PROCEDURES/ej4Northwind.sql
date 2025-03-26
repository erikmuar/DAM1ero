
/*
Crearem un procediment a la BD northwind amb l'objectiu de generar i exportar un informe per cada país amb el resum de les comandes creades, la varietat de productes demanats, la totalitat d'unitats encarregades i el benefici total generat.

Crea un procediment anomenat exportOrderDetailsPerCountry() sense paràmetres.
Crea un cursor curCountries amb només el nom dels diferents països presents a la taula northwind.customers.


Per a cada iteració del cursor, genera un fitxer anomenat 'Country_OrderDetailsResum.csv' on 'Country' ho canviarem pel nom del país en cada cas. Per tant, usarem sentència dinàmica.


Aquests fitxers exportats, contindran les següents columnes amb la informació de:
a) Nom del País AS País
b) Recompte de les comandes demanades AS QuantitatComandes (pista: northwind.orders.orderid)
c) Recompte de la varietat de diferents productes demanats AS QuantitatProductesDiferents (pista: northwind.ordersdetails.productid)
d) Sumatori d'unitats totals encarregades entre totes les comandes de cada país AS QuantitatUnitats (pista: northwind.orderdetails.quantity)
e) Sumatori del total de benefici generat entre totes les comandes de cada país AS ImportTotalComandes (pista: northwind.orderdetails.UnitPrice)

El fitxer separarà els camps per ';', opcionalment enclausarà els textos amb '"'" i separarà les files per '\n'.
*/






