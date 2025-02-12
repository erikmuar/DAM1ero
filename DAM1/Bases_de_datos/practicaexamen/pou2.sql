/*
1. Retorna un recompte de quants distribuidors (shippers) hi ha.
*/

SELECT COUNT (ShipperID) 
FROM Shippers; 


/*
2. Calcula quants proveïdors (suppliers) hi ha per ciutat.
*/

SELECT s.city, COUNT(SupplierID)
FROM Suppliers AS s  
GROUP BY s.city;  

/*
3. Calcula quants productes són distribuits pel shipper número 3.
*/

SELECT COUNT(od.ProductID) 
FROM OrderDetails AS od
JOIN Orders AS o ON o.orderID = od.OrderID
WHERE o.ShipVia = 3; 

/*
4. Crea un informe amb el nom del distribuidor, nom del proveidor, nom de la categoria i el recompte de productes que coincideixen.
*/

SELECT sh.CompanyName, s.CompanyName, c.CategoryName, COUNT(p.ProductID )
FROM Shippers AS sh
JOIN Orders AS o ON o.ShipVia = sh.ShipperID
JOIN OrderDetails AS od ON od.OrderID = o.OrderID 
JOIN Products AS p ON p.ProductID = od.ProductID 
JOIN Suppliers AS s ON s.SupplierID = p.SupplierID 
JOIN Categories AS c ON c.CategroyID = p.CategoryID 
GROUP BY sh.CompanyName, s.CompanyName, c.CategoryName; 



/*
5. Mostra un informe amb el nom dels clients (customers.companyname) que han rebut més de tres paquets provinents del shipper número 3.
*/

SELECT c.CompanyName 
FROM Customers AS c 
JOIN Orders AS o ON o.CustomerID = c.CustomerID 
WHERE o.ShipVia = 3
GROUP BY c.CompanyName 
HAVING COUNT(o.orderID) > 3; 


/*
6. Mostra un recompte de les ordres que ha rebut cada customer ordenant pel recompte de forma descendent.
*/

SELECT c.CompanyName, COUNT(o.orderID)
FROM Orders As o 
JOIN Customers AS c ON c.customerID = o.CustomerID 
ORDER BY COUNT(o.orderID) DESC; 



/*
7. Mostra un recompte de clients (customers) per codi postal sempre i quant
n'hi hagi més d'un al mateix codi postal.
*/

SELECT c.PostalCode, COUNT(CustomerID)
FROM Customers AS c 
GROUP BY c.PostalCode
HAVING COUNT(c.CustomerID) > 1; 

/*
8. Compta quants territoris diferents hi ha per cada regió. Mostra RegionDescription i el recompte.
*/

SELECT r.RegionDescription, COUNT( DISTINCT t.TerritoryID)
FROM Territories  AS t 
JOIN Region AS r ON r.RegionID = t.RegionID
GROUP BY r.RegionDescription; 



/*
9. Calcula la mitjana de comandes (orders) servides per cada shipper. 
*/

SELECT sh.CompanyName, COUNT(o.orderID)/COUNT(DISTINCT sh.ShipperID)
FROM Orders AS o 
JOIN Shippers AS sh ON sh.ShipperID = o.ShipVia
GROUP BY sh.CompanyName; 

/*
10. Compta quants empleats hi ha per cada territori. Mostra TerritoryDescription i el recompte.
*/

SELECT t.TerritoryDescription, COUNT(et.EmployeeID)
FROM Territory AS t 
JOIN EmployeeTerritories AS et ON et.territoryID = t.TerritoryID 
ORDER BY t.TerritoryDescription; 

/*
11. Compta quants empleats hi ha per cada regió. Mostra RegionDescription i el recompte.
*/

SELECT r.RegionDescription, COUNT(et.EmployeeID)
FROM Region AS r 
JOIN Territories AS t ON t.RegionID = r.RegionID
JOIN EmployeeTerritories AS et ON et.territoryID = t.TerritoryID
GROUP BY r.RegionDescription; 


/*
12. Retorna només el nom de la regió (region.description) que té més empleats.
*/

SELECT r.RegionDescription, COUNT(et.EmployeeID)
FROM Region AS r 
JOIN Territories AS t ON t.RegionID = r.RegionID
JOIN EmployeeTerritories AS et ON et.territoryID = t.TerritoryID
GROUP BY r.RegionDescription
ORDER BY COUNT(et.EmployeeID) DESC LIMIT 1; 

/*
13. Retorna el recompte de productes per categoria.
*/

SELECT c.CategoryName, COUNT(p.ProductID)
FROM Categories AS c 
JOIN Products AS p On p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

/*
14. Calcula quants productes pot servir cada distribuïdor. Mostra el CompanyName i el recompte de productes.
*/

SELECT sh.CompanyName, COUNT(od.ProductID)
FROM Shippers AS sh
JOIN Orders AS o ON o.Shipvia = sh.ShipperID
JOIN OrderDetails AS od ON od.orderID = o.OrderID
GROUP BY sh.CompanyName; 

/*
15. Calcula quants empleats hi ha per Ciutat contractats a partir de l'any 1993.
*/

SELECT e.city, COUNT(e.EmployeeID)
FROM Employees AS e 
WHERE YEAR(HireDate) >= 1993 
GROUP BY e.city; 