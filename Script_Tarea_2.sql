/*
Indicaciones:
Se necesita realizar un análisis de las ventas  realizadas el año 2018 en North America, solo de las tiendas actualmente activas, y el que tipo de tienda sean online y store.

Tablas a utilizar:

Sales  = ventas
Date = tabla de fecha
Stores = Tiendas
Geography = Dirección
Product = Producto
Product_SubCategory = Categoría de Producto

Se necesita la venta total, por producto (ProductSubcategoryName), provincia (StateProvinceName) , mes (Mes) y Tipo de tienda (StoreType)
*/

-- Para filtrar el año utilice el campo Fecha y extraiga el año. Tiene que ser igual a 2018
SELECT *
FROM Sales ventas
WHERE DATEPART(yy, ventas.DateKey) = 2018

-- Para identificar si una tienda esta activa utilice el campo Status en donde sea igual a “On”
-- Para identificar el tipo de tienda es el campo StoreType
SELECT tiendas.Store_Key, tiendas.Status, tiendas.StoreType, tiendas.Geography_Key
FROM Stores tiendas
WHERE tiendas.Status = 'On'

-- Y el continente sea North America
SELECT *
FROM [Geography]
WHERE ContinentName = 'North America'


-- SOLUCION TAREA
SELECT producto_sc.ProductSubcategoryName, geo.StateProvinceName, calendario.Mes, tiendas.StoreType, sum(ventas.SalesAmount) as Ventas_Totales
FROM Product_SubCategory as producto_sc 
INNER JOIN Product as producto
ON producto_sc.ProductCategoryKey = producto.Product_Key
INNER JOIN Sales as ventas
ON producto.Product_Key = ventas.ProductKey
INNER JOIN Stores as tiendas
ON ventas.StoreKey = tiendas.Store_Key
INNER JOIN [Geography] as geo
ON tiendas.Geography_Key = geo.GeographyKey
INNER JOIN Date as calendario
ON ventas.DateKey = calendario.Fecha
WHERE geo.ContinentName = 'North America' AND DATEPART(yy, ventas.DateKey) = 2018 AND tiendas.Status = 'On' AND (tiendas.StoreType = 'Online' OR tiendas.StoreType = 'Store')
GROUP BY producto_sc.ProductSubcategoryName, geo.StateProvinceName, calendario.Mes, tiendas.StoreType
