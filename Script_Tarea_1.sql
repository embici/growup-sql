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
