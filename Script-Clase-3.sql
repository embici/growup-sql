-- iif
Select distinct NumeroMes, iif(NumeroMes <= 0, 'I Semestre', 'II Semestre') as Semestre
From Contoso.dbo.date
order by NumeroMes asc

-- case
Select distinct NumeroMes,
Trimestre = Case when NumeroMes in (1, 2, 3) then 'Q1'
				 when NumeroMes in (4, 5, 6) then 'Q2'
				 when NumeroMes in (7, 8, 9) then 'Q3'
				 when NumeroMes in (10, 11, 12) then 'Q4'
				 else 'Fuera de Rango'
				 end
from date
/*
Select distinct NumeroMes,
Trimestre2 = Case when NumeroMes when 1 then 'Q1'
							when 2 then 'Q1'
							when 3 then 'Q1'
							when 4 then 'Q2'
							when 5 then 'Q2'
							when 6 then 'Q2'
							when 7 then 'Q3'
							when 8 then 'Q3'
							when 9 then 'Q3'
							when 10 then 'Q4'
							when 11 then 'Q4'
							when 12 then 'Q4'
							else 'Fuera de Rango'
							end
from date*/

-- Choose - se utiliza solo para valores enteros y en secuencia

Select distinct NumeroMes, Mes = CHOOSE(NumeroMes, 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Setiembre', 'Octubre', 'Noviembre', 'Diciembre')
from date


-- replace
select ChannelName, replace(ChannelName, 'Store', 'Tienda') CampoNuevo
from Channel

-- upper - Mayusculas
Select ChannelName, upper(ChannelName)
from Channel

-- lower - Minusculas
Select ChannelName, lower(ChannelName)
from Channel

-- Funciones de Fechas
-- Year
Select Fecha, year(Fecha) año
from date
-- Month
Select Fecha, mes = year(Fecha)
from date
-- Day
Select Fecha, day(Fecha) as dia
from date

/*TAREA Para el siguientes casos muestre el scrip utilizado, se adjunta un print para que se dé una idea del resultado deseado.De la tabla Entity extraiga todos los registros en donde ParentEntityLabel sea de Wisconsin o de Texas, adicionalmente en  EntityName cambie la palabra Contoso por Growup y llame esa columna como Nombre_Entidad, los EntityKey deseados deben ser  entre 680 y 720,  EntityDescription conviértalo a Mayuscula asígnele el nombre de NombreMayuscula, extraiga del campo LoadDate el año y llame a esa columna Año, haga un case en donde EntityKey empiece con 6 sea Menor y si empieza con 7 indique Mayor, a esa columna llámela Rango.*/

Select *
from [dbo].[Entity]
where ParentEntityLabel in ('Wisconsin', 'Texas') 
-- Replace([EntityName], 'Contoso', 'Growup') as Entidad


--
-- Depart --extraer informcion de un campo fecha
-- 2 argumentos

select Fecha,
Año = DATEPART(yy, Fecha),
DATEPART(mm, Fecha) Mes,
DATEPART(q, Fecha) trimestre,
DATEPART(DAYOFYEAR, Fecha) dia_año,
DATEPART(dd, Fecha) dia,
DATEPART(dd, Fecha) semana,
DATEPART(dd, Fecha) dia_semana
from date

--datename --funcion solo para mes y dias
-- 2 arg (parametro, campo)

select Fecha,
DATENAME(mm, Fecha) NombreMes,
DATENAME(WEEKDAY, Fecha) DiaSemana
from date

-- dateadd  --sumar o agregar algun valor a un campo de fecha
-- 2 arg (parametro, cantidad, campo)

select Fecha,
DATEADD(dd, 8, Fecha) Sumar8Dias,
DATEADD(mm, 8, Fecha) Sumar8Meses,
DATEADD(yy, 8, Fecha) Sumar8años
from date

-- getDate() extrae la fecha actual
select getDate()

-- dateiff -- diferencias entre fechas
-- 3 argumentos (parametro, fechainicio, fechafinal)
select StartDate, EndDate,
Cantidad_Años = datediff(yy, StartDate, EndDate),
Cantidad_Dias = datediff(dd, StartDate, EndDate),
Cantidad_Meses = datediff(mm, StartDate, EndDate),
Cantidad_Anos_Actual = datediff(yy, StartDate, getDate())
from Promotion

-- datefromparts -- crear una fecha
-- 3 argumentos

select DATEFROMPARTS(Año,NumeroMes, Dia) Fecha
from date 

-- Eomonth --convierte cualquier dia del mes al ultimo dia del mes
Select Fecha, EOMONTH(Fecha)
from date

-- isDate
Select isdate('Hola')
Select isdate('2020/02/30')
Select isdate('2020/02/01')

-- Funciones de Texto
-- Concatenar
-- Concat

select CONCAT(BrandName, ' - ', ColorName, ' - ', ClassName, ' - ', Manufacturer) CampoConcatenado
from Product

-- Concat_ws
Select CONCAT_WS(' - ', BrandName, ColorName, ClassName, Manufacturer)
from Product

-- space -- agregar espacios
Select ProductName, concat(space(10), ProductName)
from Product

-- ltrim -- remover espacios a la derecha
Select ltrim(concat(SPACE(10), ProductName, SPACE(10))) as leftTrim
from Product

-- rtrim -- remover espacios a la derecha
Select rtrim(concat(SPACE(10), ProductName, SPACE(10))) as rightTrim
from Product

-- trim 
Select trim(concat(SPACE(10), ProductName, SPACE(10))) as justTrim
from Product

-- len
select StoreName, LEN(StoreName) Largo
from Stores

-- CharIndex -- Buscar un valor especifico y me devuelve la posicion donde se encuentra

select StoreName, CharIndex(' ', StoreName, 9) BuscarValor
from Stores

--Substring -- Extraer una cadena de un campo de texto
--3 argumentos substring(Campo, Posicion Inicial, Posicion Final)
select StoreName, SUBSTRING(StoreName, 9, 7) BuscarValor
from Stores

select StoreName, SUBSTRING(StoreName, 9, 7) BuscarValor
from Stores

-- funciones de conversion
-- Convert (Formato, campo)
Select SalesAmount, convert(decimal(10,2), SalesAmount)
from Sales

-- Cast(Campo as Formato)
select SalesAmount, cast(SalesAmount as decimal(10, 2))
from Sales

select convert(decimal(10,2),35)/60*100

select 35.00/60 * 100

select 35/60 * 100.00


select Fecha,
convert(varchar(15), Fecha, 101),
convert(varchar(15), Fecha, 102),
convert(varchar(15), Fecha, 103),
convert(varchar(15), Fecha, 104),
convert(varchar(15), Fecha, 105),
convert(varchar(15), Fecha, 106),
convert(varchar(15), Fecha, 107),
convert(varchar(15), Fecha, 108),
convert(varchar(15), Fecha, 109),
convert(varchar(15), Fecha, 110),
convert(varchar(15), Fecha, 111),
convert(varchar(15), Fecha, 112),
convert(varchar(15), Fecha, 113)
from Date