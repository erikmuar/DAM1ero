/*1. Fes una query en SQL que mostri totes les columnes de tots els productes per
pantalla. És a dir retorna totes les columnes i totes les files de la taula Products.*/ 
SELECT * FROM products;

/*2. Mostra només la columna descripció de la taula Categories.*/

SELECT Description FROM categories; 

/*3. Retorna la informació de tots els clients per pantalla usant la taula Customers.*/

SELECT * FROM customers;

/*4. Mostra ara les columnes CategoryName i Description de la taula Categories. */

SELECT CategoryName, Description FROM categories;

 /* 5. Mostra ara només la columna descripció de la taula Categories i només per la fila on CategoryName = “Grains/Cereals”.*/

 SELECT Description FROM categories WHERE CategoryName = “Grains/Cereals”; 

 /*6. Desenvolupa una consulta que retorni tota la informació relativa a tots els productes de la taula Products que tenen categoria = 1.*/

 SELECT * FROM products WHERE CategoryID = 1;

 /* 7. Retorna el ProductID del producte que té “Filo Mix” per nom*/

SELECT ProductID FROM products WHERE ProductName = 'Filo Mix';

/*8. Mostra tota la info de tots els productes del SupplierID número 3. Usa la taula Products.*/

SELECT * FROM products WHERE SupplierID = 3;

/*9. Retorna tots els productes de la categoria 2 que tenen un preu > 20. */

SELECT * FROM products WHERE CategoryID = 2 AND UnitPrice > 20; 

/*10.Fes una query que retorni les dades de tots els clients alemanys. */

SELECT * FROM customers WHERE Country = 'Germany'; 

/*11.Retorna el nom i la data de naixement de l’empleat Steven Buchanan usant la taula Employees.*/

SELECT FirstName, LastName, BirthDate FROM employees WHERE FirstName = 'Steven' AND LastName = 'Buchanan';

/*12.Volem un llistat dels noms de tots els proveïdors japonesos. Usa la taula Suppliers*/

SELECT ContactName FROM suppliers WHERE Country = 'Japan'; 

/*13.Volem ara un llistat de les persones de contacte dels proveïdors britànics i el seu telèfon. Usa la taula Suppliers.*/

SELECT ContactName, Phone FROM suppliers WHERE Country = 'UK'; 

/* 14.Troba el nom de l’empresa d’enviaments que té el telèfon = (503) 555-3199. Usa la taula Shippers*/

SELECT CompanyName FROM shippers WHERE Phone = '(503) 555-3199';

/* 15.Mostra el preu i el pes del ProductID = 69. */

SELECT UnitPrice, QuantityPerUnit FROM products WHERE ProductID = 69;

/*16.Retorna un llistat de tota la informació de tots els clients ordenats pel país de procedència alfabèticament */

SELECT * FROM customers ORDER BY Country; 

/*17.Fes el recompte de quants productes hi ha de la categoria 2 que tenen un preu > 20.  ponemos el id porque es unico y asi contamos todos los productos*/  

SELECT COUNT(productid) FROM products WHERE categoryid = 2 and unitprice > 20; 

/*18 .Fes una query que retorni la xifra del producte més car de la taula Products. */ 

 

/*19 .Retorna el preu mig de la taula Products. Usamos el round para que no salga con decimales*/

SELECT ROUND(AVG(unitprice)) FROM products;

/*21 .Mostra el preu de la Order 10255 (Price x quantitat de tots els productes).*/

SELECT UnitPrice*Quantity FROM orderdetails WHERE orderid = 10255;

/* 21.1 para sumar todos los precios por unidad */

SELECT sum(UnitPrice*Quantity) FROM orderdetails WHERE orderid = 10255;
