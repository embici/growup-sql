SELECT Fecha, YEAR(Fecha) año, mes = MONTH(Fecha), DAY(Fecha) as 'dia'
FROM [Date]

-- Practica
/*
Para el siguiente caso muestre el script utilizado
se adjunta un print para que se de una idea del resultado deseado.
1. De la tabla Entity extraiga todos los registros en donde ParentEntityLabel sea Wisconsin o Texas,
2. Adicionalmente en EntityName cambie la palabra Contoso por Growup y llame esa columna como Nombre_Entidad,
3. los EntityKey deseados deben ser entre 680 y 720
4. EntityDescription conviertalo a Mayuscula, asignele el nombre de NombreMayuscula
5. Extraiga del campo LoadDate el año y llame a esa columna Año
6. Haga un case en donde EntityKey empiece con 6 sea Menor y si empieza 7 indique Mayor, esa columna llamela Rango
*/

SELECT EntityKey, ParentEntityLabel, Nombre_Entidad = REPLACE(EntityName, 'Contoso', 'Growup'), EntityName, UPPER(EntityDescription) NombreMayuscula, YEAR(LoadDate) Año,
    Rango = CASE WHEN LEFT(EntityKey,1) = 6 THEN 'Menor' 
             WHEN LEFT(EntityKey,1) = 7 THEN 'Mayor'
             ELSE CONVERT(VARCHAR(5),EntityKey)
             END
FROM [Entity]
WHERE ParentEntityLabel in('Wisconsin','Texas') -- WHERE (ParentEntityLabel = 'Wisconsin' OR ParentEntityLabel = 'Texas')
    AND EntityKey BETWEEN 680 AND 720

-- Ejemplo Try Cast
SELECT CASE WHEN TRY_CAST('Hola' as int) IS NULL THEN 0
    ELSE 1
    END Resultado1

-- Ejemplo Try Convert
SELECT CASE WHEN TRY_CONVERT( float, 'Hola') IS NULL THEN 0
    ELSE 1
    END Resultado2

-- Investigar las recomendaciones de cuando utilizar convert o cast

SELECT CONVERT( int,DiscountAmount) convertedDiscount, DiscountAmount -- Esto se come unos decimales, no nos sirve
FROM Sales

-- Round(campo, cantidad_decimales) --> manera recomendada
SELECT ROUND(DiscountAmount, 2) roundedDiscount, DiscountAmount
FROM Sales

SELECT ROUND(DiscountAmount, 0) roundedDiscount, DiscountAmount
FROM Sales

-- Funciones de valores NULL
-- ISNULL(Campo1, Campo2) -- Solo soporta 2 opciones
-- SELECT (precio * cantidad) * ISNULL(TipoCambio,630) as 'Ventas$'


-- COALESCE(campo1, campo2, campo3, campo4, ...)
-- SELECT COALESCE(opcion1, opcion2, opcion3, opcion4)

-- SQL JOINS

/* 
SQL Tiene dos tipos de sintaxis
DDL -> Definicion -> Create, Drop, Alter
DML -> Manipulacion -> Insert, Delete, Select, Update
*/

-- Script para crear tablas para practicar JOINS


--1
CREATE TABLE [dbo].[Cliente]
(
    [Numero_Client] [int] not NULL,
    [Nombre] [varchar](50) NULL,
    [Apellido] [varchar](50) NULL,
    [ID_Genero] int NULL
)
--2
insert into [Cliente]
values
    (1, 'Marianela', 'Navarro', 2)
insert into [Cliente]
values
    (2, 'Luis', 'Ureña', 1)
insert into [Cliente]
values
    (3, 'Meli', 'Moralez', 2)
insert into [Cliente]
values
    (4, 'Caro', 'Hernandez', 2)
insert into [Cliente]
values
    (5, 'Diana', 'Ramirez', 2)
insert into [Cliente]
values
    (6, 'Laura', 'Rojas', 2)
insert into [Cliente]
values
    (7, 'Tatiana', 'Alfaro', 2)
insert into [Cliente]
values
    (8, 'Esteban', 'Granados', 1)
insert into [Cliente]
values
    (9, 'Rafa', 'Blanco', 1)
insert into [Cliente]
values
    (10, 'Jorsua', 'Ramirez', 1)
insert into [Cliente]
values
    (15, 'Marlon', 'Calderon', 1)


--3
CREATE TABLE [dbo].[Genero]
(
    [ID_Genero] [int] not NULL,
    [Descripcion] [varchar](50) NULL
)
--4
insert into [Genero]
values
    (1, 'Masculino')
insert into [Genero]
values
    (2, 'Femenino')
insert into [Genero]
values
    (3, 'No Indica')

--5
CREATE TABLE [dbo].[Tipo_Contacto]
(
    [ID_Contacto] [int] not NULL,
    [Descripcion] [varchar](50) NULL
)
--6
insert into [Tipo_Contacto]
values
    (1, 'Correo')
insert into [Tipo_Contacto]
values
    (2, 'Telefono')
insert into [Tipo_Contacto]
values
    (3, 'Direccion fisica')
--7
CREATE TABLE [dbo].[Contacto]
(
    [ID_Cliente] [int] not NULL,
    [ID_Contacto] [int] NULL,
    [Descripcion] [varchar](50) NULL
)
--8
insert into [Contacto]
values
    (1, 1, 'Nela@gmail.com')
insert into [Contacto]
values
    (2, 1, 'Luis@gmail.com')
insert into [Contacto]
values
    (3, 1, 'Meli@gmail.com')
insert into [Contacto]
values
    (4, 1, 'Caro@gmail.com')
insert into [Contacto]
values
    (5, 1, 'Dian@gmail.com')
insert into [Contacto]
values
    (6, 1, 'Lau@gmail.com')
insert into [Contacto]
values
    (9, 1, 'Rafa@gmail.com')
insert into [Contacto]
values
    (10, 1, 'JR@gmail.com')
insert into [Contacto]
values
    (11, 1, 'Prueba@gmail.com')
insert into [Contacto]
values
    (1, 2, '87879654')
insert into [Contacto]
values
    (2, 2, '87879655')
insert into [Contacto]
values
    (3, 2, '87879697')
insert into [Contacto]
values
    (4, 2, '87879659')
insert into [Contacto]
values
    (5, 2, '88879654')
insert into [Contacto]
values
    (6, 2, '86879654')
insert into [Contacto]
values
    (7, 2, '83879654')
insert into [Contacto]
values
    (8, 2, '87879680')
insert into [Contacto]
values
    (9, 2, '87879671')
insert into [Contacto]
values
    (10, 2, '87879624')
insert into [Contacto]
values
    (1, 3, 'Cartago,Guadalupe')
insert into [Contacto]
values
    (2, 3, 'San Jose, San Pedro')
insert into [Contacto]
values
    (4, 3, 'San Jose, Curri')
insert into [Contacto]
values
    (6, 3, 'Cartago, Central')
insert into [Contacto]
values
    (7, 3, 'Alajuela, Central')
insert into [Contacto]
values
    (8, 3, 'Heredia')
insert into [Contacto]
values
    (10, 3, 'Cartago, Arenilla')

--9

select *
from Cliente
select *
from Genero
select *
from Tipo_Contacto
select *
from Contacto

-- SQL JOINS
-- INNER JOIN
SELECT * FROM [Cliente] A
INNER JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente

-- LEFT JOIN
SELECT * FROM [Cliente] A
LEFT JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente

-- RIGHT JOIN
SELECT * FROM [Cliente] A
RIGHT JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente

-- LEFT JOIN WHERE IS NULL
SELECT * FROM [Cliente] A
LEFT JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente
WHERE B.ID_Cliente IS NULL

-- RIGHT JOIN WHERE IS NULL
SELECT * FROM [Cliente] A
RIGHT OUTER JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente

-- RIGHT JOIN WHERE A.Key IS NULL
SELECT * FROM [Cliente] A
RIGHT JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente
WHERE A.Numero_Client IS NULL

-- FULL JOIN
SELECT * FROM [Cliente] A
FULL JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente

-- FULL JOIN
SELECT * FROM [Cliente] A
FULL JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente
WHERE A.Numero_Client IS NULL OR B.ID_Cliente IS NULL

-- JOIN == INNER JOIN
SELECT * FROM [Cliente] A
JOIN [Contacto] B
ON A.Numero_Client = B.ID_Cliente


SELECT gn.Descripcion, COUNT(Descripcion) as N_Genero
FROM Cliente cl
INNER JOIN Genero gn
ON cl.ID_Genero = gn.ID_Genero
GROUP BY gn.Descripcion


SELECT cl.Nombre, gn.Descripcion
FROM Cliente cl
INNER JOIN Genero gn
ON cl.ID_Genero = gn.ID_Genero


SELECT cl.Nombre, gn.Descripcion Genero, ct.Descripcion Contacto, tc.Descripcion Tipo_Contacto
FROM Cliente cl
INNER JOIN Genero gn
ON cl.ID_Genero = gn.ID_Genero
INNER JOIN Contacto ct 
ON cl.Numero_Client = ct.ID_Cliente
INNER JOIN Tipo_Contacto tc
ON tc.ID_Contacto = ct.ID_Contacto