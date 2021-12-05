-- Scripts de clase 2

/*
08/11/2021
*/

--SQL
-- DDL Definition (Create / Drop / Alter)
-- DML Manipulacion (Insert/Delete/Update/Select)

-- sentencia Select
/*
Select Campos -- Que necesito?
from TablaA -- de donde lo traigo?
where condiciones -- Filtros

*/
use Contoso

-- * -> Significa Todo
/*Select *
from [dbo].[Date]*/

--Top Cantidad
Select top 10 * from Sales
Select top 10 * from Channel
Select top 10 * from Date

--Top Porcentaje
Select top 10 percent * from Sales

-- sintaxis para autorizacion de Diagrama de DB
ALTER AUTHORIZATION ON DATABASE::Contoso TO sa

-- Mayor que
Select *
from date
where Año > 2018

-- Mayor o igual que
Select *
from date
where Año >= 2018

-- Menor que
Select *
from date
where Año < 2018

-- Menor o igual que
Select *
from date
where Año <= 2018

-- Igual que
Select *
from date
where Año = 2018

-- Diferente a
Select *
from date
where Año != 2018

Select *
from date
where Año <> 2018

-- Operadores Logicos (AND - OR)
-- AND -- por fuerza el registro tiene que complir las 2 condiciones
Select GeographyKey, GeographyType, ContinentName, RegionCountryName 
from Geography
where ContinentName = 'Asia' and RegionCountryName = 'Pakistan'

-- OR -- con que cumpla alguna condicion me trae el registro
Select GeographyKey, GeographyType, ContinentName, RegionCountryName 
from Geography
where ContinentName = 'Asia' OR RegionCountryName = 'France'

-- between -- rangos (funciona para fechas y numeros) incluye los valores extremos
-- between valor1 and valor2
Select *
from Date
where Fecha between '2021/06/01' and '2021/11/08'

select GETDATE() -- fecha actual del servidor

Select *
from Date
where Fecha between '2021/06/01' and GETDATE()

Select *
from Geography
where GeographyKey between 270 and 280

-- IN (valor1, valor2,valor3, ...)
-- se utiliza para textos y numeros
-- se utiliza cuando tengo una lista de valores

-- textos
Select *
from Geography
where ContinentName in ('Europe', 'Asia')

-- numeros
Select *
from Geography
where GeographyKey in (269, 275, 280, 290, 291, 292, 295)

-- Like - busqueda de un valor determinado en un campo texto
-- termine en
Select *
from Geography
where RegionCountryName like ('%nia')

-- comience con
Select *
from Geography
where RegionCountryName like 'a%'

-- contenga
Select *
from Geography
where RegionCountryName like '%a%'

Select *
from Geography
where RegionCountryName like '%a%t%'

-- comience y termine con
Select *
from Geography
where RegionCountryName like 'c%a'

-- Alias en campos
Select 
NombreProduct = ProductName, 
Product_Key as 'Llave', 
ProductLabel Codigo, 
ColorName [Color del Producto]
from Product

-- tener cuidado con las comas en los campos
Select 
ProductName, 
Product_Key ProductLabel, -- aqui se le esta poniendo un alias de Label
ColorName
from Product

-- FUNCIONES -----

-- contar
-- Count() -- Funcion de agregacion
-- Importante -> siempre que se utilicen campos adicionales esos valores se deben agrupar
-- Group By -> con esto es que se agrupan los datos

Select colorname, ClassName,
Cantidad = COUNT(*),
Cantidad2 = COUNT(1),
Cantidad3 = COUNT(ProductLabel)
from Product
group by colorname, ClassName
order by colorname desc -- asc / desc

-- having -- filtro a los datos que ya estoy extrayendo
Select colorname, ClassName,
Cantidad1 = COUNT(*)
from Product
group by colorname, ClassName
having Count(*) > 100
order by Cantidad1 desc, ClassName desc

-- orden por cantidad
Select top 10 colorname, ClassName,
Cantidad1 = COUNT(*)
from Product
group by colorname, ClassName
order by Count(*) desc

-- Funcion para campos vacions
-- funciones para Null's

-- is null -> me permite identificar si existen campos vacios
Select *
from Date
where mes is null

-- NOT
Select *
From Geography
where GeographyKey not between 270 and 280

Select *
From date
where mes is not null

Select *
from Geography
where GeographyKey not in (269, 275, 280, 290, 291, 292, 295)

Select *
from Geography
where RegionCountryName not like ('%nia')

-- Distinct
Select Distinct
Mes, NumeroMes
from Date
order by NumeroMes 

-- contar valores unicos
Select 
ColorName,
COUNT(ClassName) Cantidad1,
COUNT(distinct ClassName) ContentValoresDistintos
from Product
group by ColorName