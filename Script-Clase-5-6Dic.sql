-- Como cargar datos a una base de datos (tabla)

-- Conectar SQL a Excel

-- Conectar SQL a Power BI
-- Suma
SELECT ChannelName, SalesAmount, TotalCost,
Ganancia = SalesAmount + TotalCost
FROM Sales s
INNER JOIN Channel c 
on s.channelKey = c.Channel_Key

-- Div
SELECT ChannelName, SalesAmount, TotalCost,
(SalesAmount - TotalCost)/SalesAmount as Porc
FROM Sales s
INNER JOIN Channel c 
on s.channelKey = c.Channel_Key

-- Multiplicacion
SELECT ChannelName, SalesAmount, TotalCost,
(SalesAmount - TotalCost)*SalesAmount as Multi
FROM Sales s
INNER JOIN Channel c 
on s.channelKey = c.Channel_Key

-- Funciones de Agregacion
-- Suma
-- Si en una funcion de agregacion estamos llamando # campos, esos mismos # campos se deben agrupar

SELECT p.ProductName, sum(SalesAmount) Venta_Total
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
GROUP BY p.ProductName

-- AVG
SELECT c.ChannelName, sum(SalesAmount) Venta_Total, AVG(SalesAmount) Promedio
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
JOIN Channel c 
on c.Channel_Key = s.channelKey
GROUP BY c.ChannelName

-- MIN -> Valores minimos --> funciona con fechas y numeros
SELECT c.ChannelName, MIN(SalesAmount) Venta_minima
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
JOIN Channel c 
on c.Channel_Key = s.channelKey
GROUP BY c.ChannelName

-- MAX -- Valores maximos
SELECT c.ChannelName, MAX(SalesAmount) Venta_maxima
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
JOIN Channel c 
on c.Channel_Key = s.channelKey
GROUP BY c.ChannelName

-- MAX -- Valores maximos
SELECT d.Año, c.ChannelName, MAX(SalesAmount) Venta_maxima
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
JOIN Channel c 
on c.Channel_Key = s.channelKey
INNER JOIN Date d 
on d.Fecha = s.DateKey
GROUP BY d.Año, c.ChannelName

-- Varianza --> var()
-- es una medida para ver que tan dispersos estan los datos con respecto a la media
SELECT c.ChannelName, VAR(SalesAmount) Varianza
FROM Sales s
INNER JOIN Product p 
ON s.ProductKey = p.Product_Key
JOIN Channel c 
on c.Channel_Key = s.channelKey
INNER JOIN Date d 
on d.Fecha = s.DateKey
GROUP BY c.ChannelName

-- Desv Standar
SELECT c.ChannelName, STDEV(SalesAmount) desv_standar
FROM Sales s
JOIN Channel c 
on c.Channel_Key = s.channelKey
INNER JOIN Date d 
on d.Fecha = s.DateKey
GROUP BY c.ChannelName

-- Valores Absolutos
-- Abs
select ABS(-999)

-- Potencias
SELECT c.ChannelName, POWER(SalesAmount, 2) Potencia
FROM Sales s
JOIN Channel c 
on c.Channel_Key = s.channelKey
INNER JOIN Date d 
on d.Fecha = s.DateKey

-- Raiz cuadrada
SELECT c.ChannelName, SQRT(SalesAmount) Raiz_Cuadrada
FROM Sales s
JOIN Channel c 
on c.Channel_Key = s.channelKey
INNER JOIN Date d 
on d.Fecha = s.DateKey
