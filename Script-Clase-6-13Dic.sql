-- union
-- Todos los scripts tienen que tener los mismos campos

/*
Select Campo1 Nombre, Campo2 Apellido, Campo3 VentasTotales, Anno
from Tabla1
where Anno = 2018
union
Select Campo1 Nombre, Campo2 Apellido, Campo3 VentasTotales, Anno
from Tabla1
where Anno = 2019
union
Select Campo1 Nombre, Campo2 Apellido, Campo3 VentasTotales, Anno
from Tabla1
where Anno = 2020
*/

-- Ventas por Canal 2018

SELECT ChannelName, d.Año, SUM(SalesAmount) VentasTotales 
FROM Sales S
INNER JOIN [Date] d 
on s.DateKey = d.Fecha
INNER JOIN Channel Ch 
ON ch.Channel_Key = s.channelKey
WHERE d.Año = 2018
GROUP BY ChannelName, d.Año
UNION
SELECT ChannelName, d.Año, SUM(SalesAmount) VentasTotales 
FROM Sales S
INNER JOIN [Date] d 
on s.DateKey = d.Fecha
INNER JOIN Channel Ch 
ON ch.Channel_Key = s.channelKey
WHERE d.Año = 2019
GROUP BY ChannelName, d.Año
UNION
SELECT ChannelName, d.Año, SUM(SalesAmount) VentasTotales 
FROM Sales S
INNER JOIN [Date] d 
on s.DateKey = d.Fecha
INNER JOIN Channel Ch 
ON ch.Channel_Key = s.channelKey
WHERE d.Año = 2020
GROUP BY ChannelName, d.Año

-- estructuras mas complejas
-- Subqueries
-- Un select dentro de otro select

/*SELECT campos1, campos2, campos3 = (Select Count() from TablaB where condicion2)
FROM Tabla
WHERE Condicion = ''*/

-- Analisis de las ventas por products
-- productos 1 al 100
-- Ventas Asia y Europa
-- Cantidad de empleados sea mayor a 10
-- Si la marca es Contoso es ACEPTADO y sino DENEGADO

-- A
SELECT p.ProductName, SUM(s.SalesAmount) VentasTotales
FROM Sales s 
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
INNER JOIN Stores st 
ON st.Store_Key = s.StoreKey
INNER JOIN [Geography] g 
ON g.GeographyKey = st.Geography_Key
WHERE p.Product_Key BETWEEN 1 and 100
 AND g.ContinentName IN ('Asia', 'Europe')
 AND st.EmployeeCount > 10
GROUP BY p.ProductName

-- B
SELECT p.ProductName, SUM(s.SalesAmount) VentasTotales
FROM Sales s 
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key and p.Product_Key BETWEEN 1 and 100
INNER JOIN Stores st 
ON st.Store_Key = s.StoreKey and st.EmployeeCount > 10
INNER JOIN [Geography] g 
ON g.GeographyKey = st.Geography_Key and g.ContinentName IN ('Asia', 'Europe')
GROUP BY p.ProductName

-- C
SELECT Product_Key
FROM Product
WHERE Product_Key BETWEEN 1 and 100

SELECT distinct Store_Key
FROM Stores st
INNER JOIN [Geography] g 
ON g.GeographyKey = st.Geography_Key
WHERE g.ContinentName in ('Asia', 'Europe') AND st.EmployeeCount > 10

SELECT d.ProductName, d.Tipo, SUM(d.SalesAmount) VentasTotales
FROM(SELECT p.ProductName, 
Tipo = IIF(s.ProductKey in (SELECT Product_Key FROM Product WHERE BrandName = 'Contoso'), 'Aceptada', 'Denegada') ,
s.SalesAmount
FROM Sales s 
INNER JOIN (SELECT Product_Key, ProductName FROM Product WHERE Product_Key BETWEEN 1 and 100) p 
on p.Product_Key = s.ProductKey
WHERE s.StoreKey IN (SELECT distinct Store_Key
FROM Stores st
INNER JOIN [Geography] g 
ON g.GeographyKey = st.Geography_Key
WHERE g.ContinentName in ('Asia', 'Europe') AND st.EmployeeCount > 10)
) d
GROUP BY d.ProductName, d.Tipo


-- variables

-- tablas temporales

SELECT Product_Key INTO #Product FROM Product WHERE BrandName = 'Contoso'

SELECT * FROM #Product

-- vistas
-- Beneficios: Se mantienen actualizadas con los datos de las tablas

-- video

-- ppt proyectos