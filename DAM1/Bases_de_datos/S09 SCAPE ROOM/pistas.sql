3)

PC: _ _ _ _ 6
La segunda victima es mujer 

SELECT *
FROM Customers c
WHERE c.PostalCode LIKE ('____6')
AND c.Country = 'Germany';

el id es 6 porque nos aparecen 3 personas pero solo una es mujer


4)

SELECT *
FROM Customers c
WHERE c.Country LIKE ('Mexico') OR c.Country LIKE ('United Kingdom') AND PostalCode LIKE '%21%';

El id es 2 porque es la unica persona que le coincide ser de Mexico y tiene un 21 en su codigo postal


5)

